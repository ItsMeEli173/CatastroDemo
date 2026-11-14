import 'package:flutter/material.dart';

/// Nombres de ruta y argumentos tipados de la navegación.
abstract final class AppRoutes {
  static const String home = '/';
  static const String farmers = '/farmers';
  static const String farmerForm = '/farmers/form';
  static const String farmerDetail = '/farmers/detail';
  static const String parcels = '/parcels';
  static const String parcelForm = '/parcels/form';
  static const String parcelDetail = '/parcels/detail';
  static const String parcelMap = '/parcels/map';
  static const String parcelVertices = '/parcels/vertices';
  static const String varieties = '/varieties';
  static const String production = '/production';
  static const String export = '/export';

  static Future<T?>? push<T>(
    BuildContext context,
    String route, {
    Object? arguments,
  }) =>
      Navigator.of(context).pushNamed<T>(route, arguments: arguments);

  static void replace(BuildContext context, String route, {Object? arguments}) {
    Navigator.of(context).pushReplacementNamed(route, arguments: arguments);
  }
}

/// Argumentos del formulario de agricultor (`null` crea uno nuevo).
class FarmerFormArgs {
  const FarmerFormArgs({this.farmerId});

  final String? farmerId;
}

/// Argumentos del detalle de agricultor.
class FarmerDetailArgs {
  const FarmerDetailArgs({required this.farmerId});

  final String farmerId;
}

/// Argumentos del formulario de parcela (`null` crea una nueva).
class ParcelFormArgs {
  const ParcelFormArgs({this.parcelId});

  final String? parcelId;
}

/// Argumentos del detalle de parcela.
class ParcelDetailArgs {
  const ParcelDetailArgs({required this.parcelId});

  final String parcelId;
}

/// Argumentos del mapa de parcela.
class ParcelMapArgs {
  const ParcelMapArgs({required this.parcelId});

  final String parcelId;
}

/// Argumentos del editor de vértices.
class ParcelVerticesArgs {
  const ParcelVerticesArgs({required this.parcelId});

  final String parcelId;
}
