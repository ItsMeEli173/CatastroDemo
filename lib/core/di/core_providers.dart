import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/app_database.dart';
import '../location/location_service.dart';
import '../media/photo_picker_service.dart';
import '../sharing/share_service.dart';
import '../storage/photo_storage.dart';

/// Base de datos local única de la aplicación.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase(driftDatabase(name: 'catastrodemo'));
  ref.onDispose(database.close);
  return database;
});

/// Almacenamiento privado de fotografías.
final photoStorageProvider = Provider<PhotoStorage>((ref) => PhotoStorage());

/// Acceso a la ubicación del dispositivo.
final locationServiceProvider =
    Provider<LocationService>((ref) => LocationService());

/// Selección de imágenes desde cámara o galería.
final photoPickerServiceProvider =
    Provider<PhotoPickerService>((ref) => PhotoPickerService());

/// Compartición de archivos con el sistema.
final shareServiceProvider = Provider<ShareService>((ref) => ShareService());
