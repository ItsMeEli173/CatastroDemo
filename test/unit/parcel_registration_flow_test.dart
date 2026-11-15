import 'dart:io';

import 'package:catastrodemo/core/database/app_database.dart';
import 'package:catastrodemo/core/storage/photo_storage.dart';
import 'package:catastrodemo/features/farmers/data/drift_farmer_repository.dart';
import 'package:catastrodemo/features/farmers/domain/entities/farmer.dart';
import 'package:catastrodemo/features/parcel_owners/data/drift_parcel_owner_repository.dart';
import 'package:catastrodemo/features/parcel_owners/domain/entities/parcel_owner.dart';
import 'package:catastrodemo/features/parcels/data/drift_parcel_repository.dart';
import 'package:catastrodemo/features/parcels/domain/entities/parcel.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakePhotoStorage implements PhotoStorage {
  @override
  Future<String?> copyFrom(String sourceAbsolutePath) async => 'photos/test.jpg';

  @override
  Future<void> deleteRelative(String relativePath) async {}

  @override
  Future<File?> resolve(String relativePath) async => null;

  @override
  Future<bool> exists(String relativePath) async => true;

  @override
  Future<List<String>> missingFiles(Iterable<String> relativePaths) async => [];

  @override
  Future<int> cleanOrphans(Iterable<String> knownRelativePaths) async => 0;

  @override
  Future<Directory> photosDirectory() async => Directory.systemTemp;
}

void main() {
  late AppDatabase db;
  late DriftFarmerRepository farmerRepo;
  late DriftParcelRepository parcelRepo;
  late DriftParcelOwnerRepository ownerRepo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    farmerRepo = DriftFarmerRepository(db.farmerDao);
    parcelRepo = DriftParcelRepository(db.parcelDao, db.parcelVertexDao, _FakePhotoStorage());
    ownerRepo = DriftParcelOwnerRepository(db.parcelOwnerDao);
  });

  tearDown(() async {
    await db.close();
  });

  test('Flujo completo de registro de parcela vinculada a agricultor con código correlativo e imagen', () async {
    final now = DateTime.now().toUtc();

    // 1. Crear agricultor
    final farmerCode = await farmerRepo.nextCode();
    expect(farmerCode, 'AGR-001');

    final farmer = Farmer(
      id: 'farmer-1',
      firstName: 'Juan',
      lastName: 'Pérez',
      documentNumber: farmerCode,
      createdAt: now,
      updatedAt: now,
    );
    await farmerRepo.save(farmer);

    // 2. Obtener siguiente código de parcela
    final parcelCode = await parcelRepo.nextCode();
    expect(parcelCode, 'PAR-001');

    // 3. Crear parcela con imagen y superficie
    final parcel = Parcel(
      id: 'parcel-1',
      code: parcelCode,
      name: 'La Finca Norte',
      declaredAreaM2: 25000.0, // 2.5 ha en m²
      status: ParcelStatus.draft,
      imagePath: 'photos/test.jpg',
      notes: 'Nota de prueba',
      createdAt: now,
      updatedAt: now,
    );
    await parcelRepo.save(parcel);

    // 4. Vincular agricultor a la parcela
    final owner = ParcelOwner(
      id: 'owner-1',
      parcelId: parcel.id,
      farmerId: farmer.id,
      ownershipPercentage: 100.0,
      createdAt: now,
      updatedAt: now,
    );
    await ownerRepo.save(owner);

    // Verificaciones
    final savedParcel = await parcelRepo.findById('parcel-1');
    expect(savedParcel, isNotNull);
    expect(savedParcel!.code, 'PAR-001');
    expect(savedParcel.imagePath, 'photos/test.jpg');
    expect(savedParcel.declaredAreaM2, 25000.0);

    final owners = await ownerRepo.findByParcel('parcel-1');
    expect(owners.length, 1);
    expect(owners.first.farmerId, 'farmer-1');

    // Segundo código correlativo
    final nextParcelCode = await parcelRepo.nextCode();
    expect(nextParcelCode, 'PAR-002');
  });
}
