import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/di/core_providers.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/geo/geo_point.dart';
import '../../../core/location/location_service.dart';
import '../../../core/widgets/feedback.dart';
import '../data/parcel_providers.dart';
import '../domain/entities/parcel.dart';
import '../domain/entities/parcel_vertex.dart';
import '../domain/services/parcel_area_calculator.dart';
import '../../../core/formatting/formatters.dart';

/// Mapa OSM con la geometría de la parcela y la ubicación actual.
class ParcelMapPage extends ConsumerStatefulWidget {
  const ParcelMapPage({required this.parcelId, super.key});

  final String parcelId;

  @override
  ConsumerState<ParcelMapPage> createState() => _ParcelMapPageState();
}

class _ParcelMapPageState extends ConsumerState<ParcelMapPage> {
  static const LatLng _fallbackCenter = LatLng(-17.7833, -63.1821);

  final MapController _mapController = MapController();
  LocationSample? _currentLocation;
  bool _locating = false;

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  Future<void> _locate() async {
    setState(() => _locating = true);
    try {
      final sample = await ref.read(locationServiceProvider).currentPosition();
      if (!mounted) return;
      setState(() => _currentLocation = sample);
      _mapController.move(
        LatLng(sample.point.latitude, sample.point.longitude),
        18,
      );
    } on AppFailure catch (error) {
      if (mounted) showFailure(context, error);
    } finally {
      if (mounted) setState(() => _locating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final parcel = ref.watch(parcelProvider(widget.parcelId)).asData?.value;
    final vertices = ref
            .watch(parcelVerticesProvider(widget.parcelId))
            .asData?.value ??
        const <ParcelVertex>[];
    final ring = vertices
        .map((vertex) => LatLng(vertex.latitude, vertex.longitude))
        .toList();
    final center = ring.isNotEmpty
        ? ring.first
        : _currentLocation == null
            ? _fallbackCenter
            : LatLng(
                _currentLocation!.point.latitude,
                _currentLocation!.point.longitude,
              );
    return Scaffold(
      appBar: AppBar(
        title: Text(parcel?.displayName ?? 'Mapa'),
        actions: [
          IconButton(
            tooltip: 'Mi ubicación',
            onPressed: _locating ? null : _locate,
            icon: _locating
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.my_location),
          ),
        ],
      ),
      body: Column(
        children: [
          MaterialBanner(
            leading: const Icon(Icons.info_outline),
            content: Text(
              'El mapa se descarga de OpenStreetMap y necesita Internet. Los '
              'vértices, la superficie y los datos guardados funcionan sin '
              'conexión.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            actions: const [SizedBox.shrink()],
          ),
          if (vertices.length < 3)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                'Esta parcela aún no tiene un polígono válido (mínimo 3 '
                'vértices). Se muestra la ubicación de los puntos existentes.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: center,
                initialZoom: ring.length >= 3 ? 17 : 18,
                minZoom: 3,
                maxZoom: 19,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.catastrodemo.catastrodemo',
                  maxZoom: 19,
                ),
                if (ring.length >= 3)
                  PolygonLayer(
                    polygons: [
                      Polygon(
                        points: ring,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withValues(alpha: 0.18),
                        borderColor: Theme.of(context).colorScheme.primary,
                        borderStrokeWidth: 3,
                      ),
                    ],
                  ),
                MarkerLayer(
                  markers: [
                    for (var index = 0; index < vertices.length; index++)
                      Marker(
                        point: LatLng(
                          vertices[index].latitude,
                          vertices[index].longitude,
                        ),
                        width: 34,
                        height: 34,
                        child: _VertexMarker(
                          sequence: index + 1,
                          lowAccuracy: vertices[index].hasLowAccuracy,
                        ),
                      ),
                    if (_currentLocation != null)
                      Marker(
                        point: LatLng(
                          _currentLocation!.point.latitude,
                          _currentLocation!.point.longitude,
                        ),
                        width: 22,
                        height: 22,
                        child: const _CurrentLocationMarker(),
                      ),
                  ],
                ),
                RichAttributionWidget(
                  attributions: [
                    TextSourceAttribution('OpenStreetMap contributors'),
                  ],
                ),
              ],
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Calculada: '
                      '${Formatters.area(ParcelAreaCalculator.areaM2(ring.map((point) => GeoPoint(point.latitude, point.longitude)).toList()))}'
                      ' · Declarada: ${Formatters.area(_declaredArea(parcel))}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static double? _declaredArea(Parcel? parcel) => parcel?.declaredAreaM2;
}

class _VertexMarker extends StatelessWidget {
  const _VertexMarker({required this.sequence, required this.lowAccuracy});

  final int sequence;
  final bool lowAccuracy;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: lowAccuracy ? scheme.error : scheme.primary,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      alignment: Alignment.center,
      child: Text(
        '$sequence',
        style: TextStyle(
          color: lowAccuracy ? scheme.onError : scheme.onPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _CurrentLocationMarker extends StatelessWidget {
  const _CurrentLocationMarker();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
      ),
    );
  }
}
