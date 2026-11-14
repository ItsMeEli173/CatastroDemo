import 'dart:ui' show Rect;

import 'package:share_plus/share_plus.dart';

import '../errors/app_failure.dart';

/// Compartición de archivos generados con las aplicaciones del sistema.
class ShareService {
  Future<void> shareFile(
    String filePath, {
    String? subject,
    Rect? sharePositionOrigin,
  }) async {
    try {
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(filePath)],
          subject: subject,
          sharePositionOrigin: sharePositionOrigin,
        ),
      );
    } on AppFailure {
      rethrow;
    } catch (_) {
      throw const ExportFailure(
        'No se pudo compartir el archivo en este dispositivo.',
      );
    }
  }
}
