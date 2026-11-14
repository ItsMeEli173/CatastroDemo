/// Estado del registro de una parcela.
///
/// `draft` admite datos incompletos (geometría o porcentajes); `active` exige
/// geometría válida; `inactive` conserva el historial sin participar en nuevos
/// registros.
enum ParcelStatus {
  draft('Borrador'),
  active('Activa'),
  inactive('Inactiva');

  const ParcelStatus(this.label);

  final String label;
}

/// Identificación y datos generales de una parcela.
///
/// La superficie declarada y la calculada se conservan separadas: la aplicación
/// nunca sustituye una por otra.
class Parcel {
  const Parcel({
    required this.id,
    required this.code,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.name,
    this.declaredAreaM2,
    this.calculatedAreaM2,
    this.notes,
  });

  final String id;
  final String code;
  final String? name;
  final double? declaredAreaM2;
  final double? calculatedAreaM2;
  final ParcelStatus status;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  String get displayName {
    final descriptive = name?.trim() ?? '';
    return descriptive.isEmpty ? code : '$code · $descriptive';
  }

  bool get hasCalculatedArea => calculatedAreaM2 != null;
}
