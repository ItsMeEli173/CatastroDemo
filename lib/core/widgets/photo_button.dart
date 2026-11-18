import 'dart:io';

import 'package:flutter/material.dart';

/// Foto mostrada como botón: al tocar abre el visor a pantalla completa.
///
/// Centraliza el aspecto del disparador (recorte, ripple y señal visual) para
/// que la foto se vea igual en el detalle de parcela, el formulario de parcela
/// y el diálogo de fotografías del vértice.
class PhotoButton extends StatelessWidget {
  const PhotoButton({
    required this.file,
    required this.onTap,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.borderRadius = 8,
    this.showHint = true,
    super.key,
  });

  final File file;

  /// Acción al tocar la foto; normalmente abre el visor.
  final VoidCallback onTap;

  final double? height;
  final double? width;
  final BoxFit fit;
  final double borderRadius;

  /// Señal visual sobre la foto. Se omite en miniaturas pequeñas.
  final bool showHint;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Stack(
        children: [
          Image.file(
            file,
            height: height,
            width: width,
            fit: fit,
            errorBuilder: (_, _, _) => SizedBox(
              height: height,
              width: width,
              child: const Center(
                child: Icon(Icons.broken_image_outlined, size: 32),
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                child: showHint
                    ? const Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: _ZoomHint(),
                        ),
                      )
                    : const SizedBox.expand(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ZoomHint extends StatelessWidget {
  const _ZoomHint();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: Colors.black54,
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.zoom_out_map, size: 16, color: Colors.white),
    );
  }
}
