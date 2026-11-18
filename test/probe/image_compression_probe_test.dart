/// Sondas de verificación independiente para la compresión de imágenes al
/// guardar (`feature/17-image-compression`, rango `abb92ba..4f2df7b`).
///
/// Derivadas de las specs `S1`..`S7` de
/// `odd/tasks/compresion-imagenes-al-guardar.md` por un verificador
/// independiente, no de los tests del autor. Se conservan como red de
/// regresión.
///
/// Las sondas marcadas `S1/S2`, `S3` y `S6` inspeccionan el texto fuente a
/// propósito: el picker es un plugin de plataforma y el hilo del isolate no
/// son observables desde `flutter test`, así que la única comprobación
/// ejecutable es que la constante o la llamada sigan ahí.
library;

import 'dart:io';

import 'package:catastrodemo/core/media/photo_compressor.dart';
import 'package:catastrodemo/core/storage/photo_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;

Uint8List gradientJpg(int w, int h, {int quality = 100}) {
  final image = img.Image(width: w, height: h);
  for (var y = 0; y < h; y++) {
    for (var x = 0; x < w; x++) {
      image.setPixelRgb(
        x,
        y,
        (x * 255) ~/ w,
        (y * 255) ~/ h,
        ((x + y) * 255) ~/ (w + h),
      );
    }
  }
  return img.encodeJpg(image, quality: quality);
}

bool isJpeg(Uint8List b) =>
    b.length > 3 && b[0] == 0xFF && b[1] == 0xD8 && b[2] == 0xFF;

class _NullCompressor extends PhotoCompressor {
  const _NullCompressor();
  @override
  Future<Uint8List?> compress(Uint8List source) async => null;
}

class _BiggerCompressor extends PhotoCompressor {
  const _BiggerCompressor();
  @override
  Future<Uint8List?> compress(Uint8List source) async =>
      Uint8List(source.length + 1024);
}

void main() {
  late Directory root;
  late Directory docs;
  late PhotoStorage storage;

  setUp(() async {
    root = await Directory.systemTemp.createTemp('catastro_probe_');
    docs = Directory(p.join(root.path, 'documents'))
      ..createSync(recursive: true);
    storage = PhotoStorage(documentsDirectoryProvider: () async => docs);
  });

  tearDown(() async {
    if (await root.exists()) await root.delete(recursive: true);
  });

  Future<File> writeSource(String name, Uint8List bytes) async {
    final f = File(p.join(root.path, name));
    await f.writeAsBytes(bytes, flush: true);
    return f;
  }

  Future<Uint8List> storedBytes(PhotoStorage st, String relative) async {
    final dir = await st.photosDirectory();
    return File(p.join(dir.path, p.basename(relative))).readAsBytes();
  }

  test('S1 landscape 2400x1200 -> longest side 1600, smaller, decodable JPEG',
      () async {
    final src = await writeSource('big.jpg', gradientJpg(2400, 1200));
    final original = await src.readAsBytes();
    final rel = await storage.copyFrom(src.path);

    expect(rel, isNotNull);
    expect(rel!.startsWith('photos/'), isTrue);
    final stored = await storedBytes(storage, rel);
    expect(isJpeg(stored), isTrue, reason: 'stored bytes must be a JPEG');
    final decoded = img.decodeImage(stored);
    expect(decoded, isNotNull);
    expect(decoded!.width, 1600);
    expect(decoded.height, 800);
    expect(stored.length, lessThan(original.length));
  });

  test('S1 portrait 1200x2400 -> 800x1600', () async {
    final src = await writeSource('tall.jpg', gradientJpg(1200, 2400));
    final original = await src.readAsBytes();
    final rel = await storage.copyFrom(src.path);
    final stored = await storedBytes(storage, rel!);
    expect(isJpeg(stored), isTrue);
    final decoded = img.decodeImage(stored)!;
    expect(decoded.width, 800);
    expect(decoded.height, 1600);
    expect(stored.length, lessThan(original.length));
  });

  test('S1 quality is 80 by default and single-source constants', () {
    const c = PhotoCompressor();
    expect(c.maxDimension, 1600);
    expect(c.quality, 80);
  });

  test('S1/S2 picker keeps imageQuality 85 and maxWidth 2048', () async {
    final picker = File(p.join(Directory.current.path, 'lib', 'core', 'media',
        'photo_picker_service.dart'));
    expect(await picker.exists(), isTrue,
        reason: 'run with the package root as cwd');
    final source = await picker.readAsString();
    expect(source.contains('imageQuality: 85'), isTrue);
    expect(source.contains('maxWidth: 2048'), isTrue);
  });

  test('S3 both flows reach PhotoStorage.copyFrom', () async {
    final parcel = await File(p.join(Directory.current.path, 'lib', 'features',
            'parcels', 'presentation', 'parcel_form_page.dart'))
        .readAsString();
    final vertex = await File(p.join(Directory.current.path, 'lib', 'features',
            'vertex_photos', 'data', 'drift_vertex_photo_repository.dart'))
        .readAsString();
    expect(parcel.contains('copyFrom('), isTrue);
    expect(vertex.contains('copyFrom('), isTrue);
  });

  test('S4 non-image bytes with .jpg extension stored byte-for-byte, no throw',
      () async {
    final garbage = Uint8List.fromList(
      List<int>.generate(4096, (i) => (i * 37 + 11) % 256),
    );
    final src = await writeSource('fake.jpg', garbage);
    final rel = await storage.copyFrom(src.path);
    expect(rel, isNotNull);
    expect(rel!.endsWith('.jpg'), isTrue);
    final stored = await storedBytes(storage, rel);
    expect(listEquals(stored, garbage), isTrue);
  });

  test('S4 small already-compressed image is never larger on disk', () async {
    final src = await writeSource('small.jpg', gradientJpg(16, 16, quality: 30));
    final original = await src.readAsBytes();
    final rel = await storage.copyFrom(src.path);
    final stored = await storedBytes(storage, rel!);
    expect(stored.length, lessThanOrEqualTo(original.length));
  });

  test('invariant: null from compressor keeps original bytes and extension',
      () async {
    final docs2 = Directory(p.join(root.path, 'docs2'))..createSync();
    final s2 = PhotoStorage(
      documentsDirectoryProvider: () async => docs2,
      compressor: const _NullCompressor(),
    );
    final bytes = Uint8List.fromList(List<int>.generate(64, (i) => i));
    final src = await writeSource('plain.png', bytes);
    final rel = await s2.copyFrom(src.path);
    expect(rel!.endsWith('.png'), isTrue,
        reason: 'no compression means the source extension is kept');
    final stored = await storedBytes(s2, rel);
    expect(listEquals(stored, bytes), isTrue);
  });

  test('invariant: a bigger compressed result is discarded, bytes unchanged',
      () async {
    final docs2 = Directory(p.join(root.path, 'docs3'))..createSync();
    final s2 = PhotoStorage(
      documentsDirectoryProvider: () async => docs2,
      compressor: const _BiggerCompressor(),
    );
    final bytes = Uint8List.fromList(List<int>.generate(128, (i) => i % 7));
    final src = await writeSource('photo.jpg', bytes);
    final rel = await s2.copyFrom(src.path);
    final stored = await storedBytes(s2, rel!);
    expect(listEquals(stored, bytes), isTrue);
  });

  test('S4 compressor returns null (no throw) for undecodable bytes', () async {
    final result = await const PhotoCompressor()
        .compress(Uint8List.fromList(List<int>.generate(32, (i) => i)));
    expect(result, isNull);
  });

  test('pre-existing: copyFrom returns null when source does not exist',
      () async {
    final rel = await storage.copyFrom(p.join(root.path, 'missing.jpg'));
    expect(rel, isNull);
  });

  test('pre-existing: returned path is photos/<file>', () async {
    final src = await writeSource('x.jpg', gradientJpg(64, 64, quality: 50));
    final rel = await storage.copyFrom(src.path);
    expect(rel, startsWith('photos/photo_'));
  });

  test('S1 boundary: exactly 1600 px longest side is kept at 1600', () async {
    final src = await writeSource('exact.jpg', gradientJpg(1600, 1600));
    final rel = await storage.copyFrom(src.path);
    final stored = await storedBytes(storage, rel!);
    final decoded = img.decodeImage(stored)!;
    expect(decoded.width, 1600);
    expect(decoded.height, 1600);
  });

  test('interaction: stored photo resolves and is not an orphan', () async {
    final src = await writeSource('big.jpg', gradientJpg(2400, 1200));
    final rel = await storage.copyFrom(src.path);
    expect(await storage.exists(rel!), isTrue);
    expect(await storage.resolve(rel), isNotNull);
    expect(await storage.missingFiles(<String>[rel]), isEmpty);
    expect(await storage.cleanOrphans(<String>[rel]), 0);
    expect(await storage.exists(rel), isTrue);
  });

  test('S6 decode/encode runs in an isolate', () async {
    final source = await File(p.join(Directory.current.path, 'lib', 'core',
            'media', 'photo_compressor.dart'))
        .readAsString();
    expect(source.contains('Isolate.run'), isTrue);
  });
}
