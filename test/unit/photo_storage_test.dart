import 'dart:io';
import 'dart:typed_data';

import 'package:catastrodemo/core/media/photo_compressor.dart';
import 'package:catastrodemo/core/storage/photo_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;

/// Compresor que siempre devuelve un resultado más pesado que la entrada.
class _InflatingCompressor extends PhotoCompressor {
  @override
  Future<Uint8List?> compress(Uint8List source) async =>
      Uint8List(source.length + 1024);
}

img.Image _gradient(int width, int height) {
  final image = img.Image(width: width, height: height);
  for (var y = 0; y < height; y++) {
    for (var x = 0; x < width; x++) {
      image.setPixelRgb(x, y, x % 256, y % 256, (x + y) % 256);
    }
  }
  return image;
}

void main() {
  late Directory tempDir;
  late PhotoStorage storage;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('catastro_photo_test');
    Future<Directory> directory() async => tempDir;
    storage = PhotoStorage(documentsDirectoryProvider: directory);
  });

  tearDown(() {
    if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
  });

  File writeSource(String name, Uint8List bytes) =>
      File(p.join(tempDir.path, name))..writeAsBytesSync(bytes);

  test('guarda la foto comprimida como JPEG con lado mayor 1600', () async {
    final sourceBytes = img.encodeJpg(_gradient(2400, 1200), quality: 100);
    final source = writeSource('origen.jpg', sourceBytes);

    final relativePath = await storage.copyFrom(source.path);

    expect(relativePath, startsWith('photos/'));
    expect(relativePath, endsWith('.jpg'));

    final stored = await storage.resolve(relativePath!);
    final storedBytes = stored!.readAsBytesSync();
    expect(img.decodeJpg(storedBytes), isNotNull);
    final decoded = img.decodeImage(storedBytes)!;
    expect(decoded.width, 1600);
    expect(decoded.height, 800);
    expect(storedBytes.length, lessThan(sourceBytes.length));
  });

  test('conserva el archivo original cuando no es una imagen', () async {
    final sourceBytes = Uint8List.fromList('no soy una imagen'.codeUnits);
    final source = writeSource('roto.jpg', sourceBytes);

    final relativePath = await storage.copyFrom(source.path);

    expect(relativePath, endsWith('.jpg'));
    final stored = await storage.resolve(relativePath!);
    expect(stored!.readAsBytesSync(), sourceBytes);
  });

  test('nunca guarda un archivo más pesado que el original', () async {
    final sourceBytes = img.encodeJpg(_gradient(64, 64), quality: 30);
    final source = writeSource('chica.jpg', sourceBytes);

    final relativePath = await storage.copyFrom(source.path);

    final stored = await storage.resolve(relativePath!);
    expect(stored!.lengthSync(), lessThanOrEqualTo(sourceBytes.length));
  });

  test('conserva el original byte a byte si comprimir no lo reduce', () async {
    final sourceBytes = img.encodePng(_gradient(32, 32));
    final source = writeSource('chica.png', sourceBytes);
    final inflating = PhotoStorage(
      documentsDirectoryProvider: () async => tempDir,
      compressor: _InflatingCompressor(),
    );

    final relativePath = await inflating.copyFrom(source.path);

    expect(relativePath, endsWith('.png'));
    final stored = await inflating.resolve(relativePath!);
    expect(stored!.readAsBytesSync(), sourceBytes);
  });

  test('devuelve null cuando el origen no existe', () async {
    final missing = p.join(tempDir.path, 'no-existe.jpg');

    expect(await storage.copyFrom(missing), isNull);
  });
}
