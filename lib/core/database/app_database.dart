import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import 'daos/export_dao.dart';
import 'daos/farmer_dao.dart';
import 'daos/grape_variety_dao.dart';
import 'daos/parcel_dao.dart';
import 'daos/parcel_owner_dao.dart';
import 'daos/parcel_variety_dao.dart';
import 'daos/parcel_vertex_dao.dart';
import 'daos/production_daos.dart';
import 'daos/vertex_photo_dao.dart';
import '../../features/parcels/domain/entities/parcel.dart';
import '../../features/parcels/domain/entities/parcel_vertex.dart';
import 'registration_code.dart';
import 'tables.dart';

part 'app_database.g.dart';

/// Base de datos local única de la demo (SQLite mediante Drift).
@DriftDatabase(tables: [
  Farmers,
  Parcels,
  ParcelOwners,
  ParcelVertices,
  VertexPhotos,
  GrapeVarieties,
  ParcelVarieties,
  HarvestSeasons,
  MeasurementUnits,
  ProductionEstimates,
], daos: [
  FarmerDao,
  ParcelDao,
  ParcelOwnerDao,
  ParcelVertexDao,
  VertexPhotoDao,
  GrapeVarietyDao,
  ParcelVarietyDao,
  HarvestSeasonDao,
  MeasurementUnitDao,
  ProductionEstimateDao,
  ExportDao,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  static const int currentSchemaVersion = 4;

  @override
  int get schemaVersion => currentSchemaVersion;

  /// Patrón del correlativo heredado que quedó guardado en `document_number`
  /// antes de la versión 3 del esquema.
  static final RegExp _legacyFarmerCode = RegExp(r'^AGR-\d+$');

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (migrator) async {
          await migrator.createAll();
          await _seedCatalogs();
        },
        onUpgrade: (migrator, from, to) async {
          if (from < 2) {
            await migrator.addColumn(parcels, parcels.imagePath);
          }
          if (from < 3) {
            await migrator.addColumn(farmers, farmers.code);
            await migrator.addColumn(grapeVarieties, grapeVarieties.code);
            await migrator.addColumn(harvestSeasons, harvestSeasons.code);
            await migrator.addColumn(
              measurementUnits,
              measurementUnits.abbreviation,
            );
            await _backfillRegistrationCodes();
            // Los registros creados desde cero ya traen estas restricciones por
            // `uniqueKeys`; las bases migradas las reciben aquí para que ambas
            // rutas terminen con el mismo comportamiento.
            await customStatement(
              'CREATE UNIQUE INDEX IF NOT EXISTS idx_farmers_code '
              'ON farmers (code)',
            );
            await customStatement(
              'CREATE UNIQUE INDEX IF NOT EXISTS idx_grape_varieties_code '
              'ON grape_varieties (code)',
            );
            await customStatement(
              'CREATE UNIQUE INDEX IF NOT EXISTS idx_harvest_seasons_code '
              'ON harvest_seasons (code)',
            );
            await customStatement(
              'CREATE UNIQUE INDEX IF NOT EXISTS '
              'idx_measurement_units_abbreviation '
              'ON measurement_units (abbreviation)',
            );
          }
          if (from < 4) {
            // Un vértice pasa a tener a lo sumo una fotografía: primero se
            // depuran los duplicados históricos y recién después se crea el
            // índice único, que fallaría con duplicados presentes.
            await _dedupeVertexPhotos();
            await customStatement(
              'DROP INDEX IF EXISTS idx_vertex_photos_vertex',
            );
            await customStatement(
              'CREATE UNIQUE INDEX IF NOT EXISTS idx_vertex_photos_vertex '
              'ON vertex_photos (vertex_id)',
            );
          }
        },
        beforeOpen: (details) async {
          // SQLite no aplica claves foráneas si la PRAGMA está desactivada.
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  /// Rellena los códigos de registro de los datos anteriores a la versión 3.
  ///
  /// Antes de esta versión el correlativo del agricultor vivía dentro de
  /// `document_number` y el código de la unidad de medida guardaba su
  /// abreviatura. La migración separa ambas cosas: copia el correlativo a
  /// `code` y vacía el documento, y copia la abreviatura a su columna propia
  /// antes de regenerar el correlativo `UNI-###`.
  Future<void> _backfillRegistrationCodes() async {
    await _backfillFarmerCodes();
    await _backfillMeasurementUnitCodes();
    await _assignNewCodes(
      prefix: 'UVA-',
      ids: await _idsByCreation(grapeVarieties),
      write: (id, code) => (update(grapeVarieties)
            ..where((t) => t.id.equals(id)))
          .write(GrapeVarietiesCompanion(code: Value(code))),
    );
    await _assignNewCodes(
      prefix: 'TEM-',
      ids: await _idsByCreation(harvestSeasons),
      write: (id, code) => (update(harvestSeasons)
            ..where((t) => t.id.equals(id)))
          .write(HarvestSeasonsCompanion(code: Value(code))),
    );
  }

  Future<void> _backfillFarmerCodes() async {
    final rows = await (select(farmers)
          ..orderBy([
            (t) => OrderingTerm.asc(t.createdAt),
            (t) => OrderingTerm.asc(t.id),
          ]))
        .get();
    final used = <String>{};
    for (final row in rows) {
      final legacy = row.documentNumber?.trim() ?? '';
      final looksLikeCode = _legacyFarmerCode.hasMatch(legacy);
      // El correlativo heredado se conserva tal cual; si estaba repetido o
      // ausente, el sistema asigna uno libre.
      final reusesLegacy = looksLikeCode && used.add(legacy);
      final code = reusesLegacy ? legacy : RegistrationCode.next('AGR-', used);
      if (!reusesLegacy) used.add(code);
      await (update(farmers)..where((t) => t.id.equals(row.id))).write(
        FarmersCompanion(
          code: Value(code),
          // Un documento con forma de correlativo nunca fue un CI real.
          documentNumber: Value(looksLikeCode ? null : row.documentNumber),
        ),
      );
    }
  }

  Future<void> _backfillMeasurementUnitCodes() async {
    final rows = await (select(measurementUnits)
          ..orderBy([
            (t) => OrderingTerm.asc(t.createdAt),
            (t) => OrderingTerm.asc(t.id),
          ]))
        .get();
    final used = <String>{};
    for (final row in rows) {
      final previous = row.abbreviation?.trim() ?? '';
      final code = RegistrationCode.next('UNI-', used);
      used.add(code);
      await (update(measurementUnits)..where((t) => t.id.equals(row.id)))
          .write(
        MeasurementUnitsCompanion(
          code: Value(code),
          abbreviation: Value(previous.isEmpty ? row.code.trim() : previous),
        ),
      );
    }
  }

  Future<List<String>> _idsByCreation(TableInfo<Table, dynamic> table) async {
    final rows = await customSelect(
      'SELECT id FROM ${table.actualTableName} ORDER BY created_at ASC, id ASC',
      readsFrom: {table},
    ).get();
    return [for (final row in rows) row.read<String>('id')];
  }

  Future<void> _assignNewCodes({
    required String prefix,
    required List<String> ids,
    required Future<void> Function(String id, String code) write,
  }) async {
    final used = <String>{};
    for (final id in ids) {
      final code = RegistrationCode.next(prefix, used);
      used.add(code);
      await write(id, code);
    }
  }

  /// Deja una sola fotografía por vértice antes de crear el índice único.
  ///
  /// Conserva la más antigua —el mismo criterio de `findByVertex`, que ordena
  /// por `created_at` ASC, es decir la que la interfaz ya mostraba— y elimina
  /// el resto de filas. Los archivos de las filas eliminadas quedan huérfanos y
  /// se depuran desde mantenimiento (RN-30 y RN-35).
  Future<void> _dedupeVertexPhotos() async {
    await customStatement(
      'DELETE FROM vertex_photos WHERE id NOT IN ('
      'SELECT keep.id FROM vertex_photos AS keep WHERE NOT EXISTS ('
      'SELECT 1 FROM vertex_photos AS other '
      'WHERE other.vertex_id = keep.vertex_id AND ('
      'other.created_at < keep.created_at '
      'OR (other.created_at = keep.created_at AND other.id < keep.id))))',
    );
  }

  /// Semillas editables documentadas en la Fase 0.
  Future<void> _seedCatalogs() async {
    const uuid = Uuid();
    final now = DateTime.now().toUtc();
    var varietyNumber = 0;
    var unitNumber = 0;

    await batch((batch) {
      batch.insertAll(grapeVarieties, [
        for (final seed in _varietySeeds)
          GrapeVarietiesCompanion.insert(
            id: uuid.v4(),
            code: Value(RegistrationCode.format('UVA-', ++varietyNumber)),
            name: seed.name,
            category: Value(seed.category),
            active: const Value(true),
            createdAt: now,
            updatedAt: now,
          ),
      ]);
      batch.insertAll(measurementUnits, [
        for (final seed in _unitSeeds)
          MeasurementUnitsCompanion.insert(
            id: uuid.v4(),
            code: RegistrationCode.format('UNI-', ++unitNumber),
            abbreviation: Value(seed.abbreviation),
            name: seed.name,
            kilogramsEquivalent: Value(seed.kilogramsEquivalent),
            active: const Value(true),
            createdAt: now,
            updatedAt: now,
          ),
      ]);
    });
  }
}

class _VarietySeed {
  const _VarietySeed(this.name, this.category);

  final String name;
  final String category;
}

class _UnitSeed {
  const _UnitSeed(this.abbreviation, this.name, this.kilogramsEquivalent);

  /// Abreviatura visible (`kg`, `crate`, `ton`); su código lo asigna el sistema.
  final String abbreviation;
  final String name;
  final double? kilogramsEquivalent;
}

const List<_VarietySeed> _varietySeeds = [
  _VarietySeed('Moscatel de Alejandría', 'Blanca'),
  _VarietySeed('Malbec', 'Tinta'),
  _VarietySeed('Cabernet Sauvignon', 'Tinta'),
  _VarietySeed('Syrah', 'Tinta'),
];

/// El cajón no tiene equivalencia universal: se configura por estimación.
const List<_UnitSeed> _unitSeeds = [
  _UnitSeed('kg', 'Kilogramo', 1.0),
  _UnitSeed('crate', 'Cajón', null),
  _UnitSeed('ton', 'Tonelada', 1000.0),
];
