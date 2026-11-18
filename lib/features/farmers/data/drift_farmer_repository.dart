import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/farmer_dao.dart';
import '../../../../core/database/registration_code.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/validation/validators.dart';
import '../domain/entities/farmer.dart';
import '../domain/repositories/farmer_repository.dart';

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
    return row?.toFarmerEntity();
  }

  @override
  Future<int> count() => _dao.count();

  @override
  Stream<int> watchCount() => _dao.watchCount();

  @override
  Future<String> nextCode() async =>
      RegistrationCode.next('AGR-', (await _dao.allCodes()).toSet());

  /// Resuelve el código que se guardará.
  ///
  /// El repositorio es la autoridad: conserva el código de un registro que ya
  /// lo tiene y asigna uno libre cuando el registro es nuevo o cuando el valor
  /// recibido ya pertenece a otro agricultor. Así el sistema garantiza que no
  /// existan conflictos aunque dos formularios se abran a la vez.
  Future<String> _resolveCode(Farmer farmer) async {
    final provided = farmer.code?.trim() ?? '';
    if (provided.isNotEmpty) {
      final owner = await _dao.findByCode(provided);
      if (owner == null || owner.id == farmer.id) return provided;
    }
    // Sin código utilizable: si el registro ya existe, conserva el suyo.
    final current = (await _dao.findById(farmer.id))?.code?.trim() ?? '';
    return current.isNotEmpty ? current : nextCode();
  }

  @override
  Future<void> save(Farmer farmer) async {
    final firstNameError = Validators.requiredName(
      farmer.firstName,
      message: 'Ingresa el nombre.',
    );
    if (firstNameError != null) throw ValidationFailure(firstNameError);
    final lastNameError = Validators.requiredName(
      farmer.lastName,
      message: 'Ingresa el apellido.',
    );
    if (lastNameError != null) throw ValidationFailure(lastNameError);
    final emailError = Validators.optionalEmail(farmer.email);
    if (emailError != null) throw ValidationFailure(emailError);
    final phoneError = Validators.optionalPhone(farmer.phone);
    if (phoneError != null) throw ValidationFailure(phoneError);

    final code = await _resolveCode(farmer);

    try {
      await _dao.upsert(
        FarmersCompanion(
          id: Value(farmer.id),
          code: Value(code),
          firstName: Value(Validators.normalizePersonName(farmer.firstName)),
          lastName: Value(Validators.normalizePersonName(farmer.lastName)),
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
        code: code,
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
