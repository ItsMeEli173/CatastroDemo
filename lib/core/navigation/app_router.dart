import 'package:flutter/material.dart';

import '../../features/data_export/presentation/data_export_page.dart';
import 'package:catastrodemo/features/farmers/presentation/farmer_detail_page.dart';
import '../../features/farmers/presentation/farmer_form_page.dart';
import '../../features/farmers/presentation/farmers_list_page.dart';
import '../../features/grape_varieties/presentation/grape_varieties_page.dart';
import '../../features/parcels/presentation/parcel_detail_page.dart';
import '../../features/parcels/presentation/parcel_form_page.dart';
import '../../features/parcels/presentation/parcel_map_page.dart';
import '../../features/parcels/presentation/parcel_vertices_page.dart';
import '../../features/parcels/presentation/parcels_list_page.dart';
import '../../features/production/presentation/production_page.dart';
import '../presentation/home_page.dart';
import 'app_routes.dart';

/// Construcción de rutas con argumentos tipados.
Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.home:
      return _route(const HomePage(), settings);
    case AppRoutes.farmers:
      return _route(const FarmersListPage(), settings);
    case AppRoutes.farmerForm:
      final args = settings.arguments as FarmerFormArgs?;
      return _route(FarmerFormPage(farmerId: args?.farmerId), settings);
    case AppRoutes.farmerDetail:
      final args = settings.arguments! as FarmerDetailArgs;
      return _route(FarmerDetailPage(farmerId: args.farmerId), settings);
    case AppRoutes.parcels:
      return _route(const ParcelsListPage(), settings);
    case AppRoutes.parcelForm:
      final args = settings.arguments as ParcelFormArgs?;
      return _route(ParcelFormPage(parcelId: args?.parcelId), settings);
    case AppRoutes.parcelDetail:
      final args = settings.arguments! as ParcelDetailArgs;
      return _route(ParcelDetailPage(parcelId: args.parcelId), settings);
    case AppRoutes.parcelMap:
      final args = settings.arguments! as ParcelMapArgs;
      return _route(ParcelMapPage(parcelId: args.parcelId), settings);
    case AppRoutes.parcelVertices:
      final args = settings.arguments! as ParcelVerticesArgs;
      return _route(ParcelVerticesPage(parcelId: args.parcelId), settings);
    case AppRoutes.varieties:
      return _route(const GrapeVarietiesPage(), settings);
    case AppRoutes.production:
      return _route(const ProductionPage(), settings);
    case AppRoutes.export:
      return _route(const DataExportPage(), settings);
    default:
      return _route(const HomePage(), settings);
  }
}

MaterialPageRoute<void> _route(Widget page, RouteSettings settings) =>
    MaterialPageRoute<void>(builder: (_) => page, settings: settings);
