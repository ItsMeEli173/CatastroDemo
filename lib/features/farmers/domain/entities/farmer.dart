/// Datos generales de un agricultor.
class Farmer {
  const Farmer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.createdAt,
    required this.updatedAt,
    this.documentNumber,
    this.phone,
    this.email,
    this.locality,
    this.address,
    this.notes,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String? documentNumber;
  final String? phone;
  final String? email;
  final String? locality;
  final String? address;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  String get fullName => '$firstName $lastName'.trim();

  String get searchableText => [
        firstName,
        lastName,
        documentNumber ?? '',
        locality ?? '',
        phone ?? '',
        email ?? '',
      ].join(' ').toLowerCase();
}
