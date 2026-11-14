import 'package:geolocator/geolocator.dart';

import '../errors/app_failure.dart';
import '../geo/geo_point.dart';

/// Muestra de ubicación con su precisión reportada.
class LocationSample {
  const LocationSample({
    required this.point,
    required this.accuracyM,
    required this.capturedAt,
  });

  final GeoPoint point;
  final double? accuracyM;
  final DateTime capturedAt;

  bool get hasLowAccuracy => accuracyM != null && accuracyM! > 15;
}

/// Acceso a la ubicación del dispositivo con permisos explícitos.
class LocationService {
  /// Ubicación actual; falla con [PermissionFailure] o [LocationFailure].
  Future<LocationSample> currentPosition({bool highAccuracy = true}) async {
    try {
      final enabled = await Geolocator.isLocationServiceEnabled();
      if (!enabled) {
        throw const PermissionFailure(
          'Activa la ubicación del dispositivo para registrar vértices GPS.',
        );
      }
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw const PermissionFailure(
          'Se requiere permiso de ubicación. Puedes habilitarlo en los ajustes '
          'del sistema.',
        );
      }
      final position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy:
              highAccuracy ? LocationAccuracy.high : LocationAccuracy.medium,
          timeLimit: const Duration(seconds: 25),
        ),
      );
      return LocationSample(
        point: GeoPoint(position.latitude, position.longitude),
        accuracyM: position.accuracy,
        capturedAt: DateTime.now().toUtc(),
      );
    } on AppFailure {
      rethrow;
    } catch (_) {
      throw const LocationFailure(
        'No se pudo obtener la ubicación. Intenta nuevamente al aire libre.',
      );
    }
  }

  Future<bool> isServiceEnabled() async {
    try {
      return await Geolocator.isLocationServiceEnabled();
    } catch (_) {
      return false;
    }
  }

  Future<void> openAppSettings() async {
    try {
      await Geolocator.openAppSettings();
    } catch (_) {
      // Sin ajustes disponibles no hay acción adicional posible.
    }
  }

  Future<void> openLocationSettings() async {
    try {
      await Geolocator.openLocationSettings();
    } catch (_) {
      // Igual que openAppSettings.
    }
  }
}
