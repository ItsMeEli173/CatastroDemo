import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/core_providers.dart';
import '../domain/entities/vertex_photo.dart';
import '../domain/repositories/vertex_photo_repository.dart';
import 'drift_vertex_photo_repository.dart';

/// Repositorio de fotografías de vértices.
final vertexPhotoRepositoryProvider = Provider<VertexPhotoRepository>(
  (ref) => DriftVertexPhotoRepository(
    ref.watch(appDatabaseProvider).vertexPhotoDao,
    ref.watch(photoStorageProvider),
    ref.watch(appDatabaseProvider).parcelDao,
  ),
);

/// Fotografías de un vértice.
final vertexPhotosProvider =
    FutureProvider.family<List<VertexPhoto>, String>(
  (ref, vertexId) =>
      ref.watch(vertexPhotoRepositoryProvider).findByVertex(vertexId),
);
