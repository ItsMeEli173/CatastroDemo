import 'dart:isolate';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:image/image.dart' as img;

/// Re-codifica una imagen a JPEG para reducir su peso antes de guardarla.
///
/// La selección de la foto (`image_picker`) ya aplica su propia optimización,
/// pero no es una garantía: según la plataforma y el origen puede devolver el
/// archivo original. Este paso sí garantiza el formato y el tamaño objetivo
/// de lo que queda escrito en el almacenamiento privado.
class PhotoCompressor {
  const PhotoCompressor({this.maxDimension = 1600, this.quality = 80});

  /// Lado mayor permitido, en píxeles. Nunca se agranda una imagen.
  final int maxDimension;

  /// Calidad JPEG (1-100).
  final int quality;

  /// Bytes JPEG comprimidos, o `null` si la imagen no se pudo decodificar.
  ///
  /// Devolver `null` en lugar de lanzar es deliberado: quien guarda decide si
  /// conserva el archivo original. Una foto del usuario nunca debe perderse
  /// porque el compresor no la entienda.
  Future<Uint8List?> compress(Uint8List source) async {
    final maxDimension = this.maxDimension;
    final quality = this.quality;
    try {
      return await Isolate.run(
        () => _compressSync(source, maxDimension, quality),
      );
    } catch (_) {
      return null;
    }
  }

  static Uint8List? _compressSync(
    Uint8List source,
    int maxDimension,
    int quality,
  ) {
    final decoded = img.decodeImage(source);
    if (decoded == null) return null;
    return img.encodeJpg(_fitWithin(decoded, maxDimension), quality: quality);
  }

  /// Escala la imagen para que ningún lado supere [maxDimension], sin deformar.
  static img.Image _fitWithin(img.Image image, int maxDimension) {
    final longestSide = math.max(image.width, image.height);
    if (longestSide <= maxDimension) return image;
    return image.width >= image.height
        ? img.copyResize(
            image,
            width: maxDimension,
            interpolation: img.Interpolation.average,
          )
        : img.copyResize(
            image,
            height: maxDimension,
            interpolation: img.Interpolation.average,
          );
  }
}
