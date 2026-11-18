import 'dart:io';

import 'package:flutter/material.dart';

import 'feedback.dart';

/// Visor de una fotografía a pantalla completa, con zoom y borrado opcional.
///
/// Es el único visor de la aplicación: lo usan el detalle de parcela, el
/// formulario de parcela y el diálogo de fotografías del vértice.
///
/// Cuando [onDelete] es nulo el visor es de solo lectura; cuando no lo es,
/// pide confirmación y ejecuta el borrado antes de cerrarse.
class PhotoViewer extends StatelessWidget {
  const PhotoViewer({
    required this.file,
    this.title,
    this.onDelete,
    this.deleteMessage =
        'Se eliminará la fotografía del almacenamiento de la aplicación.',
    super.key,
  });

  /// Archivo de imagen a mostrar.
  final File file;

  /// Título de la barra superior.
  final String? title;

  /// Acción de borrado aportada por el llamador.
  ///
  /// El visor sólo la invoca después de que el usuario confirme, y cierra la
  /// pantalla únicamente si la acción termina sin error.
  final Future<void> Function()? onDelete;

  /// Mensaje de la confirmación de borrado.
  final String deleteMessage;

  Future<void> _confirmDelete(BuildContext context) async {
    final confirmed = await confirmAction(
      context,
      title: 'Eliminar fotografía',
      message: deleteMessage,
      confirmLabel: 'Eliminar',
      destructive: true,
    );
    if (!confirmed || !context.mounted) return;
    final done = await runGuarded(context, onDelete!);
    if (done && context.mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(title ?? 'Fotografía'),
        actions: [
          if (onDelete != null)
            IconButton(
              tooltip: 'Eliminar',
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _confirmDelete(context),
            ),
        ],
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 1,
          maxScale: 5,
          child: Image.file(
            file,
            fit: BoxFit.contain,
            errorBuilder: (_, _, _) => const Icon(
              Icons.broken_image_outlined,
              color: Colors.white54,
              size: 64,
            ),
          ),
        ),
      ),
    );
  }
}
