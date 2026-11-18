import 'dart:typed_data';

import 'package:catastrodemo/core/media/photo_compressor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

/// Imagen con degradé: no es uniforme, así que se comprime de forma realista.
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
  group('PhotoCompressor', () {
    test('usa calidad 80 y lado máximo 1600 por defecto', () {
      const compressor = PhotoCompressor();

      expect(compressor.quality, 80);
      expect(compressor.maxDimension, 1600);
    });

    test('reduce el lado mayor de una imagen horizontal', () async {
      const compressor = PhotoCompressor(maxDimension: 200);
      final source = img.encodePng(_gradient(400, 200));

      final result = await compressor.compress(source);

      final decoded = img.decodeImage(result!)!;
      expect(decoded.width, 200);
      expect(decoded.height, 100);
    });

    test('reduce el lado mayor de una imagen vertical', () async {
      const compressor = PhotoCompressor(maxDimension: 200);
      final source = img.encodePng(_gradient(200, 400));

      final result = await compressor.compress(source);

      final decoded = img.decodeImage(result!)!;
      expect(decoded.width, 100);
      expect(decoded.height, 200);
    });

    test('no agranda una imagen que ya entra en el máximo', () async {
      const compressor = PhotoCompressor(maxDimension: 200);
      final source = img.encodePng(_gradient(100, 50));

      final result = await compressor.compress(source);

      final decoded = img.decodeImage(result!)!;
      expect(decoded.width, 100);
      expect(decoded.height, 50);
    });

    test('devuelve JPEG aunque el origen sea PNG', () async {
      const compressor = PhotoCompressor(maxDimension: 200);
      final source = img.encodePng(_gradient(400, 200));

      final result = await compressor.compress(source);

      expect(result![0], 0xFF);
      expect(result[1], 0xD8);
      expect(img.decodeJpg(result), isNotNull);
    });

    test('pesa menos que el original', () async {
      const compressor = PhotoCompressor(maxDimension: 200, quality: 80);
      final source = img.encodeJpg(_gradient(800, 400), quality: 100);

      final result = await compressor.compress(source);

      expect(result!.length, lessThan(source.length));
    });

    test('devuelve null cuando los bytes no son una imagen decodificable', () async {
      const compressor = PhotoCompressor();
      final notAnImage = Uint8List.fromList('esto no es una imagen'.codeUnits);

      expect(await compressor.compress(notAnImage), isNull);
    });

    test('acepta una imagen grande con los valores por defecto', () async {
      const compressor = PhotoCompressor();
      final source = img.encodeJpg(_gradient(2400, 1200), quality: 100);

      final result = await compressor.compress(source);

      final decoded = img.decodeImage(result!)!;
      expect(decoded.width, 1600);
      expect(decoded.height, 800);
    });
  });
}
