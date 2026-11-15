/// Formateo numérico y de fechas determinista para la interfaz en español.
///
/// Se implementa sin dependencias de localización para que el formato sea
/// estable en pruebas y en dispositivos sin datos regionales descargados.
abstract final class Formatters {
  /// Separador de miles `.` y decimal `,` (convención es-BO).
  static String decimal(double value, {int fractionDigits = 2}) {
    if (!value.isFinite) return '—';
    final negative = value < 0;
    final fixed = value.abs().toStringAsFixed(fractionDigits);
    final parts = fixed.split('.');
    final integerPart = parts.first;
    final buffer = StringBuffer();
    for (var i = 0; i < integerPart.length; i++) {
      if (i > 0 && (integerPart.length - i) % 3 == 0) buffer.write('.');
      buffer.write(integerPart[i]);
    }
    final decimals = fractionDigits > 0 ? ',${parts.last}' : '';
    return '${negative ? '-' : ''}$buffer$decimals';
  }

  static String area(double? squareMeters) =>
      squareMeters == null ? '—' : '${decimal(squareMeters)} m²';

  static String hectares(double? squareMeters) =>
      squareMeters == null ? '—' : '${decimal(squareMeters / 10000, fractionDigits: 2)} ha';

  static String kilograms(double? kilograms) =>
      kilograms == null ? '—' : '${decimal(kilograms)} kg';

  static String percent(double? value) {
    if (value == null) return '—';
    final fractionDigits = value == value.roundToDouble() ? 0 : 2;
    return '${decimal(value, fractionDigits: fractionDigits)} %';
  }

  /// Formato plano sin separador de miles para campos editables (e.g. 1000 o 12.5).
  static String plainNumber(double? value, {int maxDecimals = 4}) {
    if (value == null || !value.isFinite) return '';
    if (value % 1 == 0) return value.toInt().toString();
    final fixed = value.toStringAsFixed(maxDecimals);
    return fixed.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
  }

  static String quantity(double? value) =>
      value == null ? '—' : decimal(value, fractionDigits: 2);

  /// Coordenadas con 6 decimales y punto decimal (evita ambigüedad de separador).
  static String coordinate(double value) => value.toStringAsFixed(6);

  static String point(double latitude, double longitude) =>
      '${coordinate(latitude)}, ${coordinate(longitude)}';

  static String date(DateTime? value) {
    if (value == null) return '—';
    final local = value.toLocal();
    return '${_two(local.day)}/${_two(local.month)}/${local.year}';
  }

  static String dateTime(DateTime? value) {
    if (value == null) return '—';
    final local = value.toLocal();
    return '${date(local)} ${_two(local.hour)}:${_two(local.minute)}';
  }

  static String _two(int value) => value.toString().padLeft(2, '0');
}
