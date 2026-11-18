/// Formato y asignación de los códigos de registro correlativos.
///
/// Un código de registro lo asigna siempre el sistema y nunca el usuario: es
/// la forma de garantizar que no existan conflictos entre registros.
abstract final class RegistrationCode {
  /// Cantidad mínima de dígitos del correlativo (`AGR-001`).
  static const int digits = 3;

  /// Compone el código a partir del [prefix] de la entidad y su número.
  ///
  /// El prefijo ya incluye el separador (`AGR-`, `UVA-`), de modo que
  /// `format('AGR-', 1)` devuelve `AGR-001`.
  static String format(String prefix, int number) =>
      '$prefix${number.toString().padLeft(digits, '0')}';

  /// Número que contiene [code] cuando usa [prefix]; `null` en cualquier otro
  /// caso.
  static int? parse(String prefix, String? code) {
    final value = code?.trim() ?? '';
    if (!value.startsWith(prefix)) return null;
    return int.tryParse(value.substring(prefix.length));
  }

  /// ¿[code] tiene la forma exacta de un correlativo de [prefix]?
  static bool matches(String prefix, String? code) =>
      parse(prefix, code) != null;

  /// Primer correlativo libre de [prefix] que no esté en [used].
  ///
  /// Recorre desde 1 y se detiene en el primer hueco. El rango explorado está
  /// acotado por la cantidad de códigos ya usados, así que la búsqueda siempre
  /// termina y siempre encuentra un valor libre: no depende de un tope
  /// arbitrario ni de reintentos contra la base.
  static String next(String prefix, Set<String> used) {
    for (var number = 1; number <= used.length + 1; number++) {
      final code = format(prefix, number);
      if (!used.contains(code)) return code;
    }
    // Inalcanzable: entre 1 y `used.length + 1` siempre queda un hueco.
    throw StateError('No hay correlativo libre para el prefijo $prefix.');
  }
}
