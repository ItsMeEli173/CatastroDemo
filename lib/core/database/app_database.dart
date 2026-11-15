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

  static const int currentSchemaVersion = 2;

  @override
  int get schemaVersion => currentSchemaVersion;

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
        },
        beforeOpen: (details) async {
          // SQLite no aplica claves foráneas si la PRAGMA está desactivada.
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  /// Semillas editables documentadas en la Fase 0.
  Future<void> _seedCatalogs() async {
    const uuid = Uuid();
    final now = DateTime.now().toUtc();

    await batch((batch) {
      batch.insertAll(grapeVarieties, [
        for (final seed in _varietySeeds)
          GrapeVarietiesCompanion.insert(
            id: uuid.v4(),
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
            code: seed.code,
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
  const _UnitSeed(this.code, this.name, this.kilogramsEquivalent);

  final String code;
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
