import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:archive/archive.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/daos/export_dao.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/storage/photo_storage.dart';
import '../domain/services/export_service.dart';

/// Exportación local: JSON versionado y respaldo ZIP con fotografías.
class LocalExportService implements ExportService {
  LocalExportService(
    this._dao,
    this._photoStorage, {
    Future<Directory> Function()? documentsDirectoryProvider,
  }) : _documentsDirectoryProvider =
            documentsDirectoryProvider ?? getApplicationDocumentsDirectory;

  final ExportDao _dao;
  final PhotoStorage _photoStorage;
  final Future<Directory> Function() _documentsDirectoryProvider;

  static const String format = 'catastrodemo';
  static const int schemaVersion = 1;

  @override
  Future<ExportArtifact> exportJson() async {
    try {
      final snapshot = await _dao.readSnapshot();
      final payload = _buildPayload(snapshot);
      final directory = await _exportsDirectory();
      final fileName = _fileName('catastro_export', 'json');
      final file = File(p.join(directory.path, fileName));
      await file.writeAsString(
        const JsonEncoder.withIndent('  ').convert(payload),
        flush: true,
      );
      final stat = await file.stat();
      return ExportArtifact(
        filePath: file.path,
        fileName: fileName,
        recordCount: snapshot.recordCount,
        photoCount: 0,
        sizeBytes: stat.size,
      );
    } on AppFailure {
      rethrow;
    } catch (_) {
      throw const ExportFailure(
        'No se pudo generar el archivo JSON. Verifica el espacio disponible.',
      );
    }
  }

  @override
  Future<ExportArtifact> exportZip() async {
    try {
      final snapshot = await _dao.readSnapshot();
      final payload = _buildPayload(snapshot);
      final generatedAt = payload['generatedAt'] as String;
      final archive = Archive();

      final dataBytes = utf8.encode(
        const JsonEncoder.withIndent('  ').convert(payload),
      );
      archive.addFile(ArchiveFile('data.json', dataBytes.length, dataBytes));

      final manifestBytes = utf8.encode(
        const JsonEncoder.withIndent('  ').convert({
          'format': format,
          'schemaVersion': schemaVersion,
          'generatedAt': generatedAt,
          'contents': {
            'data': 'data.json',
            'photos': PhotoStorage.folderName,
          },
        }),
      );
      archive.addFile(
        ArchiveFile('manifest.json', manifestBytes.length, manifestBytes),
      );

      var photoCount = 0;
      for (final photo in snapshot.vertexPhotos) {
        final file = await _photoStorage.resolve(photo.relativePath);
        if (file == null) continue;
        final bytes = await file.readAsBytes();
        archive.addFile(
          ArchiveFile(photo.relativePath, bytes.length, bytes),
        );
        photoCount++;
      }

      final encoded = ZipEncoder().encodeBytes(archive);
      final directory = await _exportsDirectory();
      final fileName = _fileName('catastro_backup', 'zip');
      final file = File(p.join(directory.path, fileName));
      await file.writeAsBytes(encoded, flush: true);
      final stat = await file.stat();
      return ExportArtifact(
        filePath: file.path,
        fileName: fileName,
        recordCount: snapshot.recordCount,
        photoCount: photoCount,
        sizeBytes: stat.size,
      );
    } on AppFailure {
      rethrow;
    } catch (_) {
      throw const ExportFailure(
        'No se pudo generar el respaldo ZIP. Verifica el espacio disponible.',
      );
    }
  }

  Map<String, Object?> _buildPayload(ExportSnapshot snapshot) {
    final generatedAt = DateTime.now().toUtc().toIso8601String();
    return {
      'format': format,
      'schemaVersion': schemaVersion,
      'generatedAt': generatedAt,
      'data': {
        'farmers': [
          for (final row in snapshot.farmers)
            {
              'id': row.id,
              'firstName': row.firstName,
              'lastName': row.lastName,
              'documentNumber': row.documentNumber,
              'phone': row.phone,
              'email': row.email,
              'locality': row.locality,
              'address': row.address,
              'notes': row.notes,
              'createdAt': _iso(row.createdAt),
              'updatedAt': _iso(row.updatedAt),
            },
        ],
        'parcels': [
          for (final row in snapshot.parcels)
            {
              'id': row.id,
              'code': row.code,
              'name': row.name,
              'declaredAreaM2': row.declaredAreaM2,
              'calculatedAreaM2': row.calculatedAreaM2,
              'status': row.status.name,
              'notes': row.notes,
              'createdAt': _iso(row.createdAt),
              'updatedAt': _iso(row.updatedAt),
            },
        ],
        'parcelOwners': [
          for (final row in snapshot.parcelOwners)
            {
              'id': row.id,
              'parcelId': row.parcelId,
              'farmerId': row.farmerId,
              'ownershipPercentage': row.ownershipPercentage,
              'notes': row.notes,
              'createdAt': _iso(row.createdAt),
              'updatedAt': _iso(row.updatedAt),
            },
        ],
        'parcelVertices': [
          for (final row in snapshot.parcelVertices)
            {
              'id': row.id,
              'parcelId': row.parcelId,
              'sequenceNumber': row.sequenceNumber,
              'latitude': row.latitude,
              'longitude': row.longitude,
              'accuracyM': row.accuracyM,
              'captureMethod': row.captureMethod.name,
              'capturedAt': _iso(row.capturedAt),
              'createdAt': _iso(row.createdAt),
              'updatedAt': _iso(row.updatedAt),
            },
        ],
        'vertexPhotos': [
          for (final row in snapshot.vertexPhotos)
            {
              'id': row.id,
              'vertexId': row.vertexId,
              'relativePath': row.relativePath,
              'fileName': row.fileName,
              'description': row.description,
              'createdAt': _iso(row.createdAt),
            },
        ],
        'grapeVarieties': [
          for (final row in snapshot.grapeVarieties)
            {
              'id': row.id,
              'name': row.name,
              'category': row.category,
              'description': row.description,
              'aliases': row.aliases,
              'active': row.active,
              'createdAt': _iso(row.createdAt),
              'updatedAt': _iso(row.updatedAt),
            },
        ],
        'parcelVarieties': [
          for (final row in snapshot.parcelVarieties)
            {
              'id': row.id,
              'parcelId': row.parcelId,
              'grapeVarietyId': row.grapeVarietyId,
              'plantedAreaPercentage': row.plantedAreaPercentage,
              'notes': row.notes,
              'createdAt': _iso(row.createdAt),
              'updatedAt': _iso(row.updatedAt),
            },
        ],
        'harvestSeasons': [
          for (final row in snapshot.harvestSeasons)
            {
              'id': row.id,
              'name': row.name,
              'startDate': _iso(row.startDate),
              'endDate': _iso(row.endDate),
              'notes': row.notes,
              'createdAt': _iso(row.createdAt),
              'updatedAt': _iso(row.updatedAt),
            },
        ],
        'measurementUnits': [
          for (final row in snapshot.measurementUnits)
            {
              'id': row.id,
              'code': row.code,
              'name': row.name,
              'kilogramsEquivalent': row.kilogramsEquivalent,
              'active': row.active,
              'createdAt': _iso(row.createdAt),
              'updatedAt': _iso(row.updatedAt),
            },
        ],
        'productionEstimates': [
          for (final row in snapshot.productionEstimates)
            {
              'id': row.id,
              'parcelId': row.parcelId,
              'seasonId': row.seasonId,
              'grapeVarietyId': row.grapeVarietyId,
              'quantity': row.quantity,
              'unitId': row.unitId,
              'conversionFactorKg': row.conversionFactorKg,
              'estimatedKg': row.estimatedKg,
              'notes': row.notes,
              'createdAt': _iso(row.createdAt),
              'updatedAt': _iso(row.updatedAt),
            },
        ],
      },
    };
  }

  Future<Directory> _exportsDirectory() async {
    final documents = await _documentsDirectoryProvider();
    final directory = Directory(p.join(documents.path, 'exports'));
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    return directory;
  }

  static String _iso(DateTime? value) =>
      value == null ? '' : value.toUtc().toIso8601String();

  static String _fileName(String prefix, String extension) {
    final now = DateTime.now();
    String two(int value) => value.toString().padLeft(2, '0');
    final stamp = '${now.year}${two(now.month)}${two(now.day)}'
        '_${two(now.hour)}${two(now.minute)}${two(now.second)}';
    return '${prefix}_$stamp.$extension';
  }
}
