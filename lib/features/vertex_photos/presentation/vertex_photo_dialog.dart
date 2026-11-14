import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/core_providers.dart';
import '../../../core/media/photo_picker_service.dart';
import '../../../core/widgets/feedback.dart';
import '../data/vertex_photo_providers.dart';
import '../domain/entities/vertex_photo.dart';

/// Diálogo para listar, agregar y eliminar fotografías de un vértice.
class VertexPhotoDialog extends ConsumerStatefulWidget {
  const VertexPhotoDialog({required this.vertexId, super.key});

  final String vertexId;

  @override
  ConsumerState<VertexPhotoDialog> createState() => _VertexPhotoDialogState();
}

class _VertexPhotoDialogState extends ConsumerState<VertexPhotoDialog> {
  List<VertexPhoto>? _photos;
  bool _loading = true;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final photos = await ref
          .read(vertexPhotoRepositoryProvider)
          .findByVertex(widget.vertexId);
      if (!mounted) return;
      setState(() {
        _photos = photos;
        _loading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => _loading = false);
      showFailure(context, error);
    }
  }

  Future<void> _add(PhotoSource source) async {
    setState(() => _busy = true);
    try {
      final path = await ref.read(photoPickerServiceProvider).pick(source);
      if (path == null) return;
      await ref.read(vertexPhotoRepositoryProvider).addFromFile(
            vertexId: widget.vertexId,
            sourcePath: path,
          );
      await _load();
    } catch (error) {
      if (mounted) showFailure(context, error);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _delete(VertexPhoto photo) async {
    final confirmed = await confirmAction(
      context,
      title: 'Eliminar fotografía',
      message: 'Se eliminará la imagen del almacenamiento de la aplicación.',
      confirmLabel: 'Eliminar',
      destructive: true,
    );
    if (!confirmed) return;
    setState(() => _busy = true);
    try {
      await ref.read(vertexPhotoRepositoryProvider).delete(photo.id);
      await _load();
    } catch (error) {
      if (mounted) showFailure(context, error);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Fotografías del vértice'),
      content: SizedBox(
        width: double.maxFinite,
        height: 360,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _busy ? null : () => _add(PhotoSource.camera),
                    icon: const Icon(Icons.photo_camera_outlined),
                    label: const Text('Cámara'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _busy ? null : () => _add(PhotoSource.gallery),
                    icon: const Icon(Icons.photo_library_outlined),
                    label: const Text('Galería'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : (_photos == null || _photos!.isEmpty)
                      ? const Center(
                          child: Text(
                            'Sin fotografías. Son opcionales y se guardan en '
                            'el almacenamiento privado de la aplicación.',
                            textAlign: TextAlign.center,
                          ),
                        )
                      : ListView.separated(
                          itemCount: _photos!.length,
                          separatorBuilder: (_, _) =>
                              const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final photo = _photos![index];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: _PhotoThumbnail(
                                relativePath: photo.relativePath,
                              ),
                              title: Text(
                                photo.fileName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                photo.description ?? 'Sin descripción',
                              ),
                              trailing: IconButton(
                                tooltip: 'Eliminar',
                                icon: const Icon(Icons.delete_outline),
                                onPressed:
                                    _busy ? null : () => _delete(photo),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}

class _PhotoThumbnail extends ConsumerWidget {
  const _PhotoThumbnail({required this.relativePath});

  final String relativePath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<File?>(
      future: ref.read(photoStorageProvider).resolve(relativePath),
      builder: (context, snapshot) {
        final file = snapshot.data;
        if (file == null) {
          return const SizedBox(
            width: 48,
            height: 48,
            child: Icon(Icons.broken_image_outlined),
          );
        }
        return ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.file(
            file,
            width: 48,
            height: 48,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => const SizedBox(
              width: 48,
              height: 48,
              child: Icon(Icons.broken_image_outlined),
            ),
          ),
        );
      },
    );
  }
}
