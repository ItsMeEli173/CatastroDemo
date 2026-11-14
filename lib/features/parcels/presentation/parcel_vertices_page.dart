import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/di/core_providers.dart';
import '../../../core/formatting/formatters.dart';
import '../../../core/validation/validators.dart';
import '../../../core/widgets/feedback.dart';
import '../../vertex_photos/presentation/vertex_photo_dialog.dart';
import '../data/parcel_providers.dart';
import '../domain/entities/parcel_vertex.dart';

/// Editor de vértices GPS y manuales con reordenamiento y fotografías.
class ParcelVerticesPage extends ConsumerStatefulWidget {
  const ParcelVerticesPage({required this.parcelId, super.key});

  final String parcelId;

  @override
  ConsumerState<ParcelVerticesPage> createState() => _ParcelVerticesPageState();
}

class _ParcelVerticesPageState extends ConsumerState<ParcelVerticesPage> {
  List<ParcelVertex>? _vertices;
  bool _loading = true;
  bool _saving = false;
  bool _dirty = false;
  bool _locating = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final vertices = await ref
          .read(parcelVertexRepositoryProvider)
          .findByParcel(widget.parcelId);
      if (!mounted) return;
      setState(() {
        _vertices = vertices;
        _dirty = false;
        _loading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => _loading = false);
      showFailure(context, error);
    }
  }

  ParcelVertex _newVertex({
    required double latitude,
    required double longitude,
    double? accuracyM,
    required VertexCaptureMethod method,
    DateTime? capturedAt,
  }) {
    final now = DateTime.now().toUtc();
    return ParcelVertex(
      id: const Uuid().v4(),
      parcelId: widget.parcelId,
      sequenceNumber: _vertices?.length ?? 0,
      latitude: latitude,
      longitude: longitude,
      accuracyM: accuracyM,
      captureMethod: method,
      capturedAt: capturedAt,
      createdAt: now,
      updatedAt: now,
    );
  }

  Future<void> _addFromGps() async {
    setState(() => _locating = true);
    try {
      final sample = await ref.read(locationServiceProvider).currentPosition();
      if (!mounted) return;
      setState(() {
        _vertices = [
          ...?_vertices,
          _newVertex(
            latitude: sample.point.latitude,
            longitude: sample.point.longitude,
            accuracyM: sample.accuracyM,
            method: VertexCaptureMethod.gps,
            capturedAt: sample.capturedAt,
          ),
        ];
        _dirty = true;
      });
      if (sample.hasLowAccuracy && mounted) {
        showMessage(
          context,
          'Precisión baja (${sample.accuracyM!.toStringAsFixed(1)} m). '
          'Considera repetir la captura.',
        );
      }
    } catch (error) {
      if (mounted) showFailure(context, error);
    } finally {
      if (mounted) setState(() => _locating = false);
    }
  }

  Future<void> _addManual() async {
    final latitude = TextEditingController();
    final longitude = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Vértice manual'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: latitude,
                decoration: const InputDecoration(
                  labelText: 'Latitud',
                  hintText: '-17.783300',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(signed: true, decimal: true),
                validator: (value) => _coordinateError(value, 90),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: longitude,
                decoration: const InputDecoration(
                  labelText: 'Longitud',
                  hintText: '-63.182100',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(signed: true, decimal: true),
                validator: (value) => _coordinateError(value, 180),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                Navigator.of(dialogContext).pop(true);
              }
            },
            child: const Text('Agregar'),
          ),
        ],
      ),
    );
    final lat = Validators.parsePlainDecimal(latitude.text);
    final lon = Validators.parsePlainDecimal(longitude.text);
    latitude.dispose();
    longitude.dispose();
    if (result != true || lat == null || lon == null || !mounted) return;
    setState(() {
      _vertices = [
        ...?_vertices,
        _newVertex(
          latitude: lat,
          longitude: lon,
          method: VertexCaptureMethod.manual,
        ),
      ];
      _dirty = true;
    });
  }

  String? _coordinateError(String? value, double limit) {
    final parsed = Validators.parsePlainDecimal(value);
    if (parsed == null) return 'Ingresa un número.';
    if (parsed < -limit || parsed > limit) {
      return 'Debe estar entre -$limit y $limit.';
    }
    return null;
  }

  void _move(int index, int offset) {
    final vertices = _vertices;
    if (vertices == null) return;
    final target = index + offset;
    if (target < 0 || target >= vertices.length) return;
    setState(() {
      final copy = [...vertices];
      final moved = copy.removeAt(index);
      copy.insert(target, moved);
      _vertices = copy;
      _dirty = true;
    });
  }

  void _remove(int index) {
    final vertices = _vertices;
    if (vertices == null) return;
    setState(() {
      final copy = [...vertices]..removeAt(index);
      _vertices = copy;
      _dirty = true;
    });
  }

  Future<void> _save() async {
    final vertices = _vertices;
    if (vertices == null) return;
    setState(() => _saving = true);
    final done = await runGuarded(
      context,
      () => ref
          .read(parcelVertexRepositoryProvider)
          .replaceAll(widget.parcelId, vertices),
    );
    if (!mounted) return;
    setState(() => _saving = false);
    if (!done) return;
    ref.invalidate(parcelVerticesProvider(widget.parcelId));
    ref.invalidate(parcelProvider(widget.parcelId));
    showMessage(context, 'Geometría guardada.');
    await _load();
  }

  Future<void> _openPhotos(ParcelVertex vertex) async {
    if (_dirty) {
      final proceed = await confirmAction(
        context,
        title: 'Cambios sin guardar',
        message: 'Guarda la geometría antes de agregar fotografías a un '
            'vértice nuevo o modificado.',
        confirmLabel: 'Guardar ahora',
      );
      if (!proceed) return;
      await _save();
      if (_dirty) return;
    }
    if (!mounted) return;
    await showDialog<void>(
      context: context,
      builder: (_) => VertexPhotoDialog(vertexId: vertex.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vertices = _vertices;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vértices'),
        actions: [
          IconButton(
            tooltip: 'Agregar con GPS',
            onPressed: _locating ? null : _addFromGps,
            icon: _locating
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.gps_fixed),
          ),
          IconButton(
            tooltip: 'Agregar manualmente',
            onPressed: _addManual,
            icon: const Icon(Icons.add_location_alt_outlined),
          ),
        ],
      ),
      floatingActionButton: _dirty
          ? FloatingActionButton.extended(
              onPressed: _saving ? null : _save,
              icon: _saving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.save_outlined),
              label: Text(_saving ? 'Guardando…' : 'Guardar geometría'),
            )
          : null,
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : (vertices == null || vertices.isEmpty)
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Text(
                      'Sin vértices. Agrega puntos con GPS o manualmente; se '
                      'necesitan al menos 3 para formar un polígono.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        'El orden define el contorno del polígono. La '
                        'superficie se recalcula al guardar.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 96),
                        itemCount: vertices.length,
                        itemBuilder: (context, index) {
                          final vertex = vertices[index];
                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: vertex.hasLowAccuracy
                                    ? Theme.of(context).colorScheme.error
                                    : null,
                                child: Text('${index + 1}'),
                              ),
                              title: Text(
                                Formatters.point(
                                  vertex.latitude,
                                  vertex.longitude,
                                ),
                              ),
                              subtitle: Text(
                                '${vertex.captureMethod.label} · '
                                '${vertex.accuracyM == null ? 'sin precisión' : '±${vertex.accuracyM!.toStringAsFixed(1)} m'}'
                                '${vertex.hasLowAccuracy ? ' · precisión baja' : ''}',
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    tooltip: 'Fotografías',
                                    icon: const Icon(
                                      Icons.photo_camera_outlined,
                                    ),
                                    onPressed: () => _openPhotos(vertex),
                                  ),
                                  PopupMenuButton<String>(
                                    tooltip: 'Ordenar',
                                    onSelected: (value) {
                                      switch (value) {
                                        case 'up':
                                          _move(index, -1);
                                        case 'down':
                                          _move(index, 1);
                                        case 'remove':
                                          _remove(index);
                                      }
                                    },
                                    itemBuilder: (context) => const [
                                      PopupMenuItem(
                                        value: 'up',
                                        child: Text('Mover arriba'),
                                      ),
                                      PopupMenuItem(
                                        value: 'down',
                                        child: Text('Mover abajo'),
                                      ),
                                      PopupMenuItem(
                                        value: 'remove',
                                        child: Text('Eliminar'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}
