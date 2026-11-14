import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/farmer_dao.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/validation/validators.dart';
import '../../domain/entities/farmer.dart';
import '../../domain/repositories/farmer_repository.dart';

/// Persistencia de agricultores sobre Drift.
class DriftFarmerRepository implements FarmerRepository {
  DriftFarmerRepository(this._dao);

  final FarmerDao _dao;

  @override
  Stream<List<Farmer>> watchFarmers({String query = ''}) =>
      _dao.watchAll(query: query).map(_mapRows);

  @override
  Future<List<Farmer>> findFarmers({String query = ''}) async =>
      _mapRows(await _dao.findAll(query: query));

  @override
  Future<Farmer?> findById(String id) async {
    final row = await _dao.findById(id);
    return row == null ? null : row.toFarmerEntity();
  }

  @override
  Future<int> count() => _dao.count();

  @override
  Future<void> save(Farmer farmer) async {
    final firstNameError = Validators.requiredText(
      farmer.firstName,
      message: 'Ingresa el nombre.',
    );
    if (firstNameError != null) throw ValidationFailure(firstNameError);
    final lastNameError = Validators.requiredText(
      farmer.lastName,
      message: 'Ingresa el apellido.',
    );
    if (lastNameError != null) throw ValidationFailure(lastNameError);
    final emailError = Validators.optionalEmail(farmer.email);
    if (emailError != null) throw ValidationFailure(emailError);
    final phoneError = Validators.optionalPhone(farmer.phone);
    if (phoneError != null) throw ValidationFailure(phoneError);

    try {
      await _dao.upsert(
        FarmersCompanion(
          id: Value(farmer.id),
          firstName: Value(farmer.firstName.trim()),
          lastName: Value(farmer.lastName.trim()),
          documentNumber: Value(_clean(farmer.documentNumber)),
          phone: Value(_clean(farmer.phone)),
          email: Value(_clean(farmer.email)),
          locality: Value(_clean(farmer.locality)),
          address: Value(_clean(farmer.address)),
          notes: Value(_clean(farmer.notes)),
          createdAt: Value(farmer.createdAt.toUtc()),
          updatedAt: Value(farmer.updatedAt.toUtc()),
        ),
      );
    } on AppFailure {
      rethrow;
    } catch (_) {
      throw const StorageFailure('No se pudo guardar el agricultor.');
    }
  }

  @override
  Future<void> delete(String id) async {
    final links = await _dao.countParcelLinks(id);
    if (links > 0) {
      throw const InUseFailure(
        'El agricultor tiene parcelas asociadas. Desvincula sus parcelas antes '
        'de eliminarlo.',
      );
    }
    try {
      await _dao.deleteById(id);
    } catch (_) {
      throw const StorageFailure('No se pudo eliminar el agricultor.');
    }
  }

  static String? _clean(String? value) {
    final text = value?.trim();
    return (text == null || text.isEmpty) ? null : text;
  }

  static List<Farmer> _mapRows(List<FarmerRow> rows) =>
      rows.map((row) => row.toFarmerEntity()).toList();
}

extension FarmerRowMapper on FarmerRow {
  Farmer toFarmerEntity() => Farmer(
        id: id,
        firstName: firstName,
        lastName: lastName,
        documentNumber: documentNumber,
        phone: phone,
        email: email,
        locality: locality,
        address: address,
        notes: notes,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
