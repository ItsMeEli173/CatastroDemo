import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables.dart';

part 'export_dao.g.dart';

/// Instantánea completa de la base para exportación.
class ExportSnapshot {
  const ExportSnapshot({
    required this.farmers,
    required this.parcels,
    required this.parcelOwners,
    required this.parcelVertices,
    required this.vertexPhotos,
    required this.grapeVarieties,
    required this.parcelVarieties,
    required this.harvestSeasons,
    required this.measurementUnits,
    required this.productionEstimates,
  });

  final List<FarmerRow> farmers;
  final List<ParcelRow> parcels;
  final List<ParcelOwnerRow> parcelOwners;
  final List<ParcelVertexRow> parcelVertices;
  final List<VertexPhotoRow> vertexPhotos;
  final List<GrapeVarietyRow> grapeVarieties;
  final List<ParcelVarietyRow> parcelVarieties;
  final List<HarvestSeasonRow> harvestSeasons;
  final List<MeasurementUnitRow> measurementUnits;
  final List<ProductionEstimateRow> productionEstimates;

  int get recordCount =>
      farmers.length +
      parcels.length +
      parcelOwners.length +
      parcelVertices.length +
      vertexPhotos.length +
      grapeVarieties.length +
      parcelVarieties.length +
      harvestSeasons.length +
      measurementUnits.length +
      productionEstimates.length;
}

/// Lectura de solo lectura de todas las tablas para exportación.
@DriftAccessor(tables: [
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
])
class ExportDao extends DatabaseAccessor<AppDatabase> with _$ExportDaoMixin {
  ExportDao(super.db);

  /// Lee todas las tablas dentro de una transacción para obtener una instantánea
  /// coherente aunque haya escrituras concurrentes.
  Future<ExportSnapshot> readSnapshot() => transaction(() async {
        return ExportSnapshot(
          farmers: await (select(farmers)
                ..orderBy([(t) => OrderingTerm.asc(t.lastName)]))
              .get(),
          parcels: await (select(parcels)
                ..orderBy([(t) => OrderingTerm.asc(t.code)]))
              .get(),
          parcelOwners: await (select(parcelOwners)
                ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
              .get(),
          parcelVertices: await (select(parcelVertices)
                ..orderBy([
                  (t) => OrderingTerm.asc(t.parcelId),
                  (t) => OrderingTerm.asc(t.sequenceNumber),
                ]))
              .get(),
          vertexPhotos: await (select(vertexPhotos)
                ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
              .get(),
          grapeVarieties: await (select(grapeVarieties)
                ..orderBy([(t) => OrderingTerm.asc(t.name)]))
              .get(),
          parcelVarieties: await (select(parcelVarieties)
                ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
              .get(),
          harvestSeasons: await (select(harvestSeasons)
                ..orderBy([(t) => OrderingTerm.asc(t.name)]))
              .get(),
          measurementUnits: await (select(measurementUnits)
                ..orderBy([(t) => OrderingTerm.asc(t.name)]))
              .get(),
          productionEstimates: await (select(productionEstimates)
                ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
              .get(),
        );
      });
}
