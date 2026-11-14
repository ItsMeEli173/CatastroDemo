/// Errores explícitos y aptos para presentación.
///
/// El dominio y la capa de datos lanzan estas fallas; la presentación las
/// convierte en mensajes mediante `AppFailure.message`. No se usan excepciones
/// genéricas para condiciones esperadas del negocio.
sealed class AppFailure implements Exception {
  const AppFailure(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Datos inválidos detectados antes de persistir.
final class ValidationFailure extends AppFailure {
  const ValidationFailure(super.message);
}

/// El registro solicitado no existe.
final class NotFoundFailure extends AppFailure {
  const NotFoundFailure([super.message = 'No se encontró el registro.']);
}

/// El registro está referenciado por otros datos y no puede eliminarse.
final class InUseFailure extends AppFailure {
  const InUseFailure(super.message);
}

/// Fallo de lectura/escritura de base de datos o archivos.
final class StorageFailure extends AppFailure {
  const StorageFailure([super.message = 'No se pudo acceder al almacenamiento.']);
}

/// Permiso del sistema operativo denegado (GPS, cámara, galería).
final class PermissionFailure extends AppFailure {
  const PermissionFailure(super.message);
}

/// Fallo al obtener la ubicación del dispositivo.
final class LocationFailure extends AppFailure {
  const LocationFailure(super.message);
}

/// Fallo al generar o compartir una exportación.
final class ExportFailure extends AppFailure {
  const ExportFailure(super.message);
}
