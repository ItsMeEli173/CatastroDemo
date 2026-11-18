/// Validaciones compartidas por formularios, casos de uso y persistencia.
///
/// Un widget nunca redefine estas reglas: los mensajes devueltos son los que se
/// muestran al usuario y los que usa la capa de datos al rechazar un registro.
abstract final class Validators {
  static final RegExp _email = RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$');
  static final RegExp _phone = RegExp(r'^[0-9+()\s-]{6,25}$');

  /// Nombre de persona: letras (con acentos, diéresis y Ñ) y espacios simples
  /// entre palabras. Sin dígitos, símbolos ni emojis.
  static final RegExp _personName = RegExp(
    r'^[A-Za-zÁÉÍÓÚÜÑáéíóúüñ]+(?: [A-Za-zÁÉÍÓÚÜÑáéíóúüñ]+)*$',
  );

  /// Convierte `1.234,5` o `1234.5` a número; devuelve null si no es numérico.
  static double? parseDecimal(String? raw) {
    final value = raw?.trim() ?? '';
    if (value.isEmpty) return null;
    final normalized = value.replaceAll('.', '').replaceAll(',', '.');
    return double.tryParse(normalized);
  }

  /// Variante para entradas con separador de miles o decimal ambiguo (`1.000,00` o `1000.00` o `1000,00`).
  static double? parsePlainDecimal(String? raw) {
    final value = raw?.trim() ?? '';
    if (value.isEmpty) return null;
    // Si contiene punto y coma (e.g. 1.000,00 o 1,000.00)
    if (value.contains('.') && value.contains(',')) {
      final lastDot = value.lastIndexOf('.');
      final lastComma = value.lastIndexOf(',');
      if (lastDot > lastComma) {
        // Formato 1,000.50 -> eliminar comas
        return double.tryParse(value.replaceAll(',', ''));
      } else {
        // Formato 1.000,50 -> eliminar puntos y cambiar coma a punto
        return double.tryParse(value.replaceAll('.', '').replaceAll(',', '.'));
      }
    }
    // Si solo tiene coma o solo tiene punto
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

  /// Recorta los extremos y colapsa cualquier espacio interno repetido.
  ///
  /// Se aplica antes de validar y antes de guardar, de modo que un nombre
  /// escrito como `"  Juan   Carlos "` termine persistido como `"Juan Carlos"`.
  static String normalizePersonName(String? raw) =>
      (raw ?? '').trim().replaceAll(RegExp(r'\s+'), ' ');

  /// Nombre o apellido de persona: solo letras y espacios simples.
  ///
  /// Normaliza primero, así que un valor con espacios sobrantes no se rechaza:
  /// se corrige. Los valores no vacíos con dígitos, símbolos o emojis sí se
  /// rechazan.
  static String? requiredName(
    String? value, {
    required String message,
    int maxLength = 120,
  }) {
    final text = normalizePersonName(value);
    if (text.isEmpty) return message;
    if (text.length > maxLength) return 'Máximo $maxLength caracteres.';
    if (!_personName.hasMatch(text)) {
      return 'Solo se permiten letras y espacios.';
    }
    return null;
  }

  static bool isValidPersonName(String value) =>
      _personName.hasMatch(normalizePersonName(value));

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
