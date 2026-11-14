import 'package:image_picker/image_picker.dart';

import '../errors/app_failure.dart';

/// Origen de una imagen solicitada al usuario.
enum PhotoSource { camera, gallery }

/// Selección de imágenes desde cámara o galería.
class PhotoPickerService {
  PhotoPickerService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  /// Ruta del archivo elegido, o `null` si el usuario cancela.
  Future<String?> pick(PhotoSource source) async {
    try {
      final file = await _picker.pickImage(
        source: source == PhotoSource.camera
            ? ImageSource.camera
            : ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 2048,
      );
      return file?.path;
    } on AppFailure {
      rethrow;
    } catch (_) {
      throw const PermissionFailure(
        'No se pudo acceder a la cámara o la galería. Revisa los permisos del '
        'sistema.',
      );
    }
  }
}
