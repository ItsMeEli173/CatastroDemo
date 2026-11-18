/// Tablas de CatastroDemo.
///
/// Convenciones:
/// - `id` es un UUID generado por la aplicación, nunca un entero autoincremental.
/// - Las fechas se guardan en UTC.
/// - Los nombres de columnas siguen `snake_case`.
/// - Las restricciones se declaran en SQLite además de validarse en dominio.
library;

import 'package:drift/drift.dart';

import '../../../features/parcels/domain/entities/parcel.dart';
import '../../../features/parcels/domain/entities/parcel_vertex.dart';

@DataClassName('FarmerRow')
@TableIndex(name: 'idx_farmers_name', columns: {#lastName, #firstName})
@TableIndex(name: 'idx_farmers_document', columns: {#documentNumber})
@TableIndex(name: 'idx_farmers_code', columns: {#code})
class Farmers extends Table {
  TextColumn get id => text()();

  /// Correlativo de registro asignado por el sistema (`AGR-###`).
  ///
  /// Es anulable solo por la migración que rellena los registros anteriores a
  /// la versión 3; el repositorio siempre escribe un valor.
  TextColumn get code => text().nullable()();
  TextColumn get firstName => text().withLength(min: 1, max: 120)();
  TextColumn get lastName => text().withLength(min: 1, max: 120)();
  TextColumn get documentNumber => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get locality => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {code},
      ];
}

@DataClassName('ParcelRow')
@TableIndex(name: 'idx_parcels_status', columns: {#status})
class Parcels extends Table {
  TextColumn get id => text()();
  TextColumn get code => text().withLength(min: 1, max: 40)();
  TextColumn get name => text().nullable()();
  RealColumn get declaredAreaM2 => real().nullable()();
  RealColumn get calculatedAreaM2 => real().nullable()();
  TextColumn get status => textEnum<ParcelStatus>()();
  TextColumn get imagePath => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {code},
      ];

  @override
  List<String> get customConstraints => [
        'CHECK (declared_area_m2 IS NULL OR declared_area_m2 >= 0)',
        'CHECK (calculated_area_m2 IS NULL OR calculated_area_m2 >= 0)',
      ];
}

@DataClassName('ParcelOwnerRow')
@TableIndex(name: 'idx_parcel_owners_farmer', columns: {#farmerId})
class ParcelOwners extends Table {
  TextColumn get id => text()();
  TextColumn get parcelId =>
      text().references(Parcels, #id, onDelete: KeyAction.cascade)();
  TextColumn get farmerId =>
      text().references(Farmers, #id, onDelete: KeyAction.restrict)();
  RealColumn get ownershipPercentage => real().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {parcelId, farmerId},
      ];

  @override
  List<String> get customConstraints => [
        'CHECK (ownership_percentage IS NULL OR '
            '(ownership_percentage >= 0 AND ownership_percentage <= 100))',
      ];
}

@DataClassName('ParcelVertexRow')
class ParcelVertices extends Table {
  TextColumn get id => text()();
  TextColumn get parcelId =>
      text().references(Parcels, #id, onDelete: KeyAction.cascade)();
  IntColumn get sequenceNumber => integer()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  RealColumn get accuracyM => real().nullable()();
  TextColumn get captureMethod => textEnum<VertexCaptureMethod>()();
  DateTimeColumn get capturedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {parcelId, sequenceNumber},
      ];

  @override
  List<String> get customConstraints => [
        'CHECK (latitude >= -90 AND latitude <= 90)',
        'CHECK (longitude >= -180 AND longitude <= 180)',
        'CHECK (sequence_number >= 0)',
        'CHECK (accuracy_m IS NULL OR accuracy_m >= 0)',
      ];
}

@DataClassName('VertexPhotoRow')
@TableIndex(name: 'idx_vertex_photos_vertex', columns: {#vertexId}, unique: true)
class VertexPhotos extends Table {
  TextColumn get id => text()();

  /// Cada vértice tiene a lo sumo una fotografía; el índice único lo impone.
  TextColumn get vertexId =>
      text().references(ParcelVertices, #id, onDelete: KeyAction.cascade)();
  TextColumn get relativePath => text()();
  TextColumn get fileName => text()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('GrapeVarietyRow')
@TableIndex(name: 'idx_grape_varieties_active', columns: {#active})
class GrapeVarieties extends Table {
  TextColumn get id => text()();

  /// Correlativo de registro asignado por el sistema (`UVA-###`).
  TextColumn get code => text().nullable()();
  TextColumn get name => text().withLength(min: 1, max: 80)();
  TextColumn get category => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get aliases => text().nullable()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {name},
        {code},
      ];
}

@DataClassName('ParcelVarietyRow')
@TableIndex(name: 'idx_parcel_varieties_variety', columns: {#grapeVarietyId})
class ParcelVarieties extends Table {
  TextColumn get id => text()();
  TextColumn get parcelId =>
      text().references(Parcels, #id, onDelete: KeyAction.cascade)();
  TextColumn get grapeVarietyId => text()
      .references(GrapeVarieties, #id, onDelete: KeyAction.restrict)();
  RealColumn get plantedAreaPercentage => real().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {parcelId, grapeVarietyId},
      ];

  @override
  List<String> get customConstraints => [
        'CHECK (planted_area_percentage IS NULL OR '
            '(planted_area_percentage >= 0 AND planted_area_percentage <= 100))',
      ];
}

@DataClassName('HarvestSeasonRow')
class HarvestSeasons extends Table {
  TextColumn get id => text()();

  /// Correlativo de registro asignado por el sistema (`TEM-###`).
  TextColumn get code => text().nullable()();
  TextColumn get name => text().withLength(min: 1, max: 60)();
  DateTimeColumn get startDate => dateTime().nullable()();
  DateTimeColumn get endDate => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {name},
        {code},
      ];

  @override
  List<String> get customConstraints => [
        'CHECK (start_date IS NULL OR end_date IS NULL OR start_date <= end_date)',
      ];
}

@DataClassName('MeasurementUnitRow')
class MeasurementUnits extends Table {
  TextColumn get id => text()();

  /// Correlativo de registro asignado por el sistema (`UNI-###`).
  TextColumn get code => text().withLength(min: 1, max: 16)();

  /// Abreviatura visible y editable por el usuario (`kg`, `cajón`, `ton`).
  ///
  /// Es la que se muestra junto a las cantidades y la que el usuario necesita
  /// para crear sus propias unidades y convertirlas a kilogramos.
  TextColumn get abbreviation => text().nullable()();
  TextColumn get name => text().withLength(min: 1, max: 60)();
  RealColumn get kilogramsEquivalent => real().nullable()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {code},
        {abbreviation},
      ];

  @override
  List<String> get customConstraints => [
        'CHECK (kilograms_equivalent IS NULL OR kilograms_equivalent > 0)',
      ];
}

@DataClassName('ProductionEstimateRow')
@TableIndex(name: 'idx_production_parcel_season', columns: {#parcelId, #seasonId})
@TableIndex(name: 'idx_production_season', columns: {#seasonId})
@TableIndex(name: 'idx_production_variety', columns: {#grapeVarietyId})
@TableIndex(name: 'idx_production_unit', columns: {#unitId})
class ProductionEstimates extends Table {
  TextColumn get id => text()();
  TextColumn get parcelId =>
      text().references(Parcels, #id, onDelete: KeyAction.cascade)();
  TextColumn get seasonId =>
      text().references(HarvestSeasons, #id, onDelete: KeyAction.restrict)();
  TextColumn get grapeVarietyId => text()
      .nullable()
      .references(GrapeVarieties, #id, onDelete: KeyAction.restrict)();
  RealColumn get quantity => real()();
  TextColumn get unitId =>
      text().references(MeasurementUnits, #id, onDelete: KeyAction.restrict)();
  RealColumn get conversionFactorKg => real()();
  RealColumn get estimatedKg => real()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
        'CHECK (quantity > 0)',
        'CHECK (conversion_factor_kg > 0)',
        'CHECK (estimated_kg >= 0)',
      ];
}
