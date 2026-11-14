import '../../../../core/errors/app_failure.dart';

/// Conversión de cantidades registradas a kilogramos (RN-22 y RN-23).
abstract final class ProductionMath {
  /// `kilogramos_estimados = cantidad_original × factor_conversion_kg`.
  static double estimatedKg({
    required double quantity,
    required double conversionFactorKg,
  }) {
    if (!quantity.isFinite || quantity <= 0) {
      throw const ValidationFailure('Ingresa una cantidad mayor a cero.');
    }
    if (!conversionFactorKg.isFinite || conversionFactorKg <= 0) {
      throw const ValidationFailure(
        'El factor de conversión debe ser mayor a cero.',
      );
    }
    return quantity * conversionFactorKg;
  }

  /// Redondeo de presentación a dos decimales, sin alterar el valor guardado.
  static double roundedKg(double kilograms) =>
      (kilograms * 100).roundToDouble() / 100;
}
