import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/core_providers.dart';
import '../domain/services/export_service.dart';
import 'local_export_service.dart';

/// Servicio de exportación JSON y ZIP.
final exportServiceProvider = Provider<ExportService>(
  (ref) => LocalExportService(
    ref.watch(appDatabaseProvider).exportDao,
    ref.watch(photoStorageProvider),
  ),
);
