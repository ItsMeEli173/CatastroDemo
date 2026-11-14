/// Validaciones compartidas por formularios, casos de uso y persistencia.
///
/// Un widget nunca redefine estas reglas: los mensajes devueltos son los que se
/// muestran al usuario y los que usa la capa de datos al rechazar un registro.
abstract final class Validators {
  static final RegExp _email = RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$');
  static final RegExp _phone = RegExp(r'^[0-9+()\s-]{6,25}$');

  /// Convierte `1.234,5` o `1234.5` a número; devuelve null si no es numérico.
  static double? parseDecimal(String? raw) {
    final value = raw?.trim() ?? '';
    if (value.isEmpty) return null;
    final normalized = value.replaceAll('.', '').replaceAll(',', '.');
    return double.tryParse(normalized);
  }

  /// Variante para entradas sin separador de miles (`1234,5`).
  static double? parsePlainDecimal(String? raw) {
    final value = raw?.trim() ?? '';
    if (value.isEmpty) return null;
    return double.tryParse(value.replaceAll(',', '.'));
  }

  static String? requiredText(
    String? value, {
    required String message,
    int maxLength = 120,
  }) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return message;
    if (text.length > maxLength) return 'Máximo $maxLength caracteres.';
    return null;
  }

  static String? optionalText(String? value, {int maxLength = 500}) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return null;
    if (text.length > maxLength) return 'Máximo $maxLength caracteres.';
    return null;
  }

  static String? requiredCode(
    String? value, {
    required String message,
    int maxLength = 40,
  }) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return message;
    if (text.length > maxLength) return 'Máximo $maxLength caracteres.';
    return null;
  }

  static String? optionalEmail(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return null;
    if (!_email.hasMatch(text)) return 'Ingresa un correo válido.';
    return null;
  }

  static String? optionalPhone(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return null;
    if (!_phone.hasMatch(text)) return 'Ingresa un teléfono válido.';
    return null;
  }

  static String? nonNegativeDecimal(String? value, {required String message}) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return null;
    final parsed = parsePlainDecimal(text);
    if (parsed == null || parsed < 0) return message;
    return null;
  }

  static String? positiveDecimal(String? value, {required String message}) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return message;
    final parsed = parsePlainDecimal(text);
    if (parsed == null || parsed <= 0) return message;
    return null;
  }

  /// Porcentaje opcional en [0, 100].
  static String? percentage(String? value, {String label = 'El porcentaje'}) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return null;
    final parsed = parsePlainDecimal(text);
    if (parsed == null || parsed < 0 || parsed > 100) {
      return '$label debe estar entre 0 y 100.';
    }
    return null;
  }

  static bool isValidPercentage(double? value) =>
      value == null || (value >= 0 && value <= 100);

  static bool isValidEmail(String value) => _email.hasMatch(value.trim());

  static bool isValidPhone(String value) => _phone.hasMatch(value.trim());

  /// Búsqueda sin distinguir mayúsculas ni acentos.
  static String normalizeForSearch(String value) {
    const replacements = {
      'á': 'a', 'é': 'e', 'í': 'i', 'ó': 'o', 'ú': 'u', 'ü': 'u', 'ñ': 'n',
      'Á': 'a', 'É': 'e', 'Í': 'i', 'Ó': 'o', 'Ú': 'u', 'Ü': 'u', 'Ñ': 'n',
    };
    final buffer = StringBuffer();
    for (final rune in value.toLowerCase().runes) {
      final char = String.fromCharCode(rune);
      buffer.write(replacements[char] ?? char);
    }
    return buffer.toString();
  }
}
