// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FarmersTable extends Farmers with TableInfo<$FarmersTable, FarmerRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FarmersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _documentNumberMeta = const VerificationMeta(
    'documentNumber',
  );
  @override
  late final GeneratedColumn<String> documentNumber = GeneratedColumn<String>(
    'document_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localityMeta = const VerificationMeta(
    'locality',
  );
  @override
  late final GeneratedColumn<String> locality = GeneratedColumn<String>(
    'locality',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    firstName,
    lastName,
    documentNumber,
    phone,
    email,
    locality,
    address,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'farmers';
  @override
  VerificationContext validateIntegrity(
    Insertable<FarmerRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('document_number')) {
      context.handle(
        _documentNumberMeta,
        documentNumber.isAcceptableOrUnknown(
          data['document_number']!,
          _documentNumberMeta,
        ),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('locality')) {
      context.handle(
        _localityMeta,
        locality.isAcceptableOrUnknown(data['locality']!, _localityMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {code},
  ];
  @override
  FarmerRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FarmerRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      ),
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      )!,
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      )!,
      documentNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}document_number'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      locality: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}locality'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $FarmersTable createAlias(String alias) {
    return $FarmersTable(attachedDatabase, alias);
  }
}

class FarmerRow extends DataClass implements Insertable<FarmerRow> {
  final String id;

  /// Correlativo de registro asignado por el sistema (`AGR-###`).
  ///
  /// Es anulable solo por la migración que rellena los registros anteriores a
  /// la versión 3; el repositorio siempre escribe un valor.
  final String? code;
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
  const FarmerRow({
    required this.id,
    this.code,
    required this.firstName,
    required this.lastName,
    this.documentNumber,
    this.phone,
    this.email,
    this.locality,
    this.address,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    if (!nullToAbsent || documentNumber != null) {
      map['document_number'] = Variable<String>(documentNumber);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || locality != null) {
      map['locality'] = Variable<String>(locality);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FarmersCompanion toCompanion(bool nullToAbsent) {
    return FarmersCompanion(
      id: Value(id),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      firstName: Value(firstName),
      lastName: Value(lastName),
      documentNumber: documentNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(documentNumber),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      locality: locality == null && nullToAbsent
          ? const Value.absent()
          : Value(locality),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FarmerRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FarmerRow(
      id: serializer.fromJson<String>(json['id']),
      code: serializer.fromJson<String?>(json['code']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      documentNumber: serializer.fromJson<String?>(json['documentNumber']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      locality: serializer.fromJson<String?>(json['locality']),
      address: serializer.fromJson<String?>(json['address']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'code': serializer.toJson<String?>(code),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'documentNumber': serializer.toJson<String?>(documentNumber),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'locality': serializer.toJson<String?>(locality),
      'address': serializer.toJson<String?>(address),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FarmerRow copyWith({
    String? id,
    Value<String?> code = const Value.absent(),
    String? firstName,
    String? lastName,
    Value<String?> documentNumber = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> locality = const Value.absent(),
    Value<String?> address = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => FarmerRow(
    id: id ?? this.id,
    code: code.present ? code.value : this.code,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    documentNumber: documentNumber.present
        ? documentNumber.value
        : this.documentNumber,
    phone: phone.present ? phone.value : this.phone,
    email: email.present ? email.value : this.email,
    locality: locality.present ? locality.value : this.locality,
    address: address.present ? address.value : this.address,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FarmerRow copyWithCompanion(FarmersCompanion data) {
    return FarmerRow(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      documentNumber: data.documentNumber.present
          ? data.documentNumber.value
          : this.documentNumber,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      locality: data.locality.present ? data.locality.value : this.locality,
      address: data.address.present ? data.address.value : this.address,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FarmerRow(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('documentNumber: $documentNumber, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('locality: $locality, ')
          ..write('address: $address, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    code,
    firstName,
    lastName,
    documentNumber,
    phone,
    email,
    locality,
    address,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FarmerRow &&
          other.id == this.id &&
          other.code == this.code &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.documentNumber == this.documentNumber &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.locality == this.locality &&
          other.address == this.address &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FarmersCompanion extends UpdateCompanion<FarmerRow> {
  final Value<String> id;
  final Value<String?> code;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String?> documentNumber;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<String?> locality;
  final Value<String?> address;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const FarmersCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.documentNumber = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.locality = const Value.absent(),
    this.address = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FarmersCompanion.insert({
    required String id,
    this.code = const Value.absent(),
    required String firstName,
    required String lastName,
    this.documentNumber = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.locality = const Value.absent(),
    this.address = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       firstName = Value(firstName),
       lastName = Value(lastName),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<FarmerRow> custom({
    Expression<String>? id,
    Expression<String>? code,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? documentNumber,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? locality,
    Expression<String>? address,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (documentNumber != null) 'document_number': documentNumber,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (locality != null) 'locality': locality,
      if (address != null) 'address': address,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FarmersCompanion copyWith({
    Value<String>? id,
    Value<String?>? code,
    Value<String>? firstName,
    Value<String>? lastName,
    Value<String?>? documentNumber,
    Value<String?>? phone,
    Value<String?>? email,
    Value<String?>? locality,
    Value<String?>? address,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return FarmersCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      documentNumber: documentNumber ?? this.documentNumber,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      locality: locality ?? this.locality,
      address: address ?? this.address,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (documentNumber.present) {
      map['document_number'] = Variable<String>(documentNumber.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (locality.present) {
      map['locality'] = Variable<String>(locality.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FarmersCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('documentNumber: $documentNumber, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('locality: $locality, ')
          ..write('address: $address, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ParcelsTable extends Parcels with TableInfo<$ParcelsTable, ParcelRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ParcelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 40,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _declaredAreaM2Meta = const VerificationMeta(
    'declaredAreaM2',
  );
  @override
  late final GeneratedColumn<double> declaredAreaM2 = GeneratedColumn<double>(
    'declared_area_m2',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _calculatedAreaM2Meta = const VerificationMeta(
    'calculatedAreaM2',
  );
  @override
  late final GeneratedColumn<double> calculatedAreaM2 = GeneratedColumn<double>(
    'calculated_area_m2',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ParcelStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ParcelStatus>($ParcelsTable.$converterstatus);
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    name,
    declaredAreaM2,
    calculatedAreaM2,
    status,
    imagePath,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'parcels';
  @override
  VerificationContext validateIntegrity(
    Insertable<ParcelRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('declared_area_m2')) {
      context.handle(
        _declaredAreaM2Meta,
        declaredAreaM2.isAcceptableOrUnknown(
          data['declared_area_m2']!,
          _declaredAreaM2Meta,
        ),
      );
    }
    if (data.containsKey('calculated_area_m2')) {
      context.handle(
        _calculatedAreaM2Meta,
        calculatedAreaM2.isAcceptableOrUnknown(
          data['calculated_area_m2']!,
          _calculatedAreaM2Meta,
        ),
      );
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {code},
  ];
  @override
  ParcelRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ParcelRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      declaredAreaM2: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}declared_area_m2'],
      ),
      calculatedAreaM2: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}calculated_area_m2'],
      ),
      status: $ParcelsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ParcelsTable createAlias(String alias) {
    return $ParcelsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ParcelStatus, String, String> $converterstatus =
      const EnumNameConverter<ParcelStatus>(ParcelStatus.values);
}

class ParcelRow extends DataClass implements Insertable<ParcelRow> {
  final String id;
  final String code;
  final String? name;
  final double? declaredAreaM2;
  final double? calculatedAreaM2;
  final ParcelStatus status;
  final String? imagePath;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ParcelRow({
    required this.id,
    required this.code,
    this.name,
    this.declaredAreaM2,
    this.calculatedAreaM2,
    required this.status,
    this.imagePath,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['code'] = Variable<String>(code);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || declaredAreaM2 != null) {
      map['declared_area_m2'] = Variable<double>(declaredAreaM2);
    }
    if (!nullToAbsent || calculatedAreaM2 != null) {
      map['calculated_area_m2'] = Variable<double>(calculatedAreaM2);
    }
    {
      map['status'] = Variable<String>(
        $ParcelsTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ParcelsCompanion toCompanion(bool nullToAbsent) {
    return ParcelsCompanion(
      id: Value(id),
      code: Value(code),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      declaredAreaM2: declaredAreaM2 == null && nullToAbsent
          ? const Value.absent()
          : Value(declaredAreaM2),
      calculatedAreaM2: calculatedAreaM2 == null && nullToAbsent
          ? const Value.absent()
          : Value(calculatedAreaM2),
      status: Value(status),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ParcelRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ParcelRow(
      id: serializer.fromJson<String>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String?>(json['name']),
      declaredAreaM2: serializer.fromJson<double?>(json['declaredAreaM2']),
      calculatedAreaM2: serializer.fromJson<double?>(json['calculatedAreaM2']),
      status: $ParcelsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String?>(name),
      'declaredAreaM2': serializer.toJson<double?>(declaredAreaM2),
      'calculatedAreaM2': serializer.toJson<double?>(calculatedAreaM2),
      'status': serializer.toJson<String>(
        $ParcelsTable.$converterstatus.toJson(status),
      ),
      'imagePath': serializer.toJson<String?>(imagePath),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ParcelRow copyWith({
    String? id,
    String? code,
    Value<String?> name = const Value.absent(),
    Value<double?> declaredAreaM2 = const Value.absent(),
    Value<double?> calculatedAreaM2 = const Value.absent(),
    ParcelStatus? status,
    Value<String?> imagePath = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ParcelRow(
    id: id ?? this.id,
    code: code ?? this.code,
    name: name.present ? name.value : this.name,
    declaredAreaM2: declaredAreaM2.present
        ? declaredAreaM2.value
        : this.declaredAreaM2,
    calculatedAreaM2: calculatedAreaM2.present
        ? calculatedAreaM2.value
        : this.calculatedAreaM2,
    status: status ?? this.status,
    imagePath: imagePath.present ? imagePath.value : this.imagePath,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ParcelRow copyWithCompanion(ParcelsCompanion data) {
    return ParcelRow(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      declaredAreaM2: data.declaredAreaM2.present
          ? data.declaredAreaM2.value
          : this.declaredAreaM2,
      calculatedAreaM2: data.calculatedAreaM2.present
          ? data.calculatedAreaM2.value
          : this.calculatedAreaM2,
      status: data.status.present ? data.status.value : this.status,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ParcelRow(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('declaredAreaM2: $declaredAreaM2, ')
          ..write('calculatedAreaM2: $calculatedAreaM2, ')
          ..write('status: $status, ')
          ..write('imagePath: $imagePath, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    code,
    name,
    declaredAreaM2,
    calculatedAreaM2,
    status,
    imagePath,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ParcelRow &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.declaredAreaM2 == this.declaredAreaM2 &&
          other.calculatedAreaM2 == this.calculatedAreaM2 &&
          other.status == this.status &&
          other.imagePath == this.imagePath &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ParcelsCompanion extends UpdateCompanion<ParcelRow> {
  final Value<String> id;
  final Value<String> code;
  final Value<String?> name;
  final Value<double?> declaredAreaM2;
  final Value<double?> calculatedAreaM2;
  final Value<ParcelStatus> status;
  final Value<String?> imagePath;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ParcelsCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.declaredAreaM2 = const Value.absent(),
    this.calculatedAreaM2 = const Value.absent(),
    this.status = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ParcelsCompanion.insert({
    required String id,
    required String code,
    this.name = const Value.absent(),
    this.declaredAreaM2 = const Value.absent(),
    this.calculatedAreaM2 = const Value.absent(),
    required ParcelStatus status,
    this.imagePath = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       code = Value(code),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ParcelRow> custom({
    Expression<String>? id,
    Expression<String>? code,
    Expression<String>? name,
    Expression<double>? declaredAreaM2,
    Expression<double>? calculatedAreaM2,
    Expression<String>? status,
    Expression<String>? imagePath,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (declaredAreaM2 != null) 'declared_area_m2': declaredAreaM2,
      if (calculatedAreaM2 != null) 'calculated_area_m2': calculatedAreaM2,
      if (status != null) 'status': status,
      if (imagePath != null) 'image_path': imagePath,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ParcelsCompanion copyWith({
    Value<String>? id,
    Value<String>? code,
    Value<String?>? name,
    Value<double?>? declaredAreaM2,
    Value<double?>? calculatedAreaM2,
    Value<ParcelStatus>? status,
    Value<String?>? imagePath,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ParcelsCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      declaredAreaM2: declaredAreaM2 ?? this.declaredAreaM2,
      calculatedAreaM2: calculatedAreaM2 ?? this.calculatedAreaM2,
      status: status ?? this.status,
      imagePath: imagePath ?? this.imagePath,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (declaredAreaM2.present) {
      map['declared_area_m2'] = Variable<double>(declaredAreaM2.value);
    }
    if (calculatedAreaM2.present) {
      map['calculated_area_m2'] = Variable<double>(calculatedAreaM2.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $ParcelsTable.$converterstatus.toSql(status.value),
      );
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ParcelsCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('declaredAreaM2: $declaredAreaM2, ')
          ..write('calculatedAreaM2: $calculatedAreaM2, ')
          ..write('status: $status, ')
          ..write('imagePath: $imagePath, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ParcelOwnersTable extends ParcelOwners
    with TableInfo<$ParcelOwnersTable, ParcelOwnerRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ParcelOwnersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parcelIdMeta = const VerificationMeta(
    'parcelId',
  );
  @override
  late final GeneratedColumn<String> parcelId = GeneratedColumn<String>(
    'parcel_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES parcels (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _farmerIdMeta = const VerificationMeta(
    'farmerId',
  );
  @override
  late final GeneratedColumn<String> farmerId = GeneratedColumn<String>(
    'farmer_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES farmers (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _ownershipPercentageMeta =
      const VerificationMeta('ownershipPercentage');
  @override
  late final GeneratedColumn<double> ownershipPercentage =
      GeneratedColumn<double>(
        'ownership_percentage',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    parcelId,
    farmerId,
    ownershipPercentage,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'parcel_owners';
  @override
  VerificationContext validateIntegrity(
    Insertable<ParcelOwnerRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('parcel_id')) {
      context.handle(
        _parcelIdMeta,
        parcelId.isAcceptableOrUnknown(data['parcel_id']!, _parcelIdMeta),
      );
    } else if (isInserting) {
      context.missing(_parcelIdMeta);
    }
    if (data.containsKey('farmer_id')) {
      context.handle(
        _farmerIdMeta,
        farmerId.isAcceptableOrUnknown(data['farmer_id']!, _farmerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_farmerIdMeta);
    }
    if (data.containsKey('ownership_percentage')) {
      context.handle(
        _ownershipPercentageMeta,
        ownershipPercentage.isAcceptableOrUnknown(
          data['ownership_percentage']!,
          _ownershipPercentageMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {parcelId, farmerId},
  ];
  @override
  ParcelOwnerRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ParcelOwnerRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      parcelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parcel_id'],
      )!,
      farmerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}farmer_id'],
      )!,
      ownershipPercentage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ownership_percentage'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ParcelOwnersTable createAlias(String alias) {
    return $ParcelOwnersTable(attachedDatabase, alias);
  }
}

class ParcelOwnerRow extends DataClass implements Insertable<ParcelOwnerRow> {
  final String id;
  final String parcelId;
  final String farmerId;
  final double? ownershipPercentage;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ParcelOwnerRow({
    required this.id,
    required this.parcelId,
    required this.farmerId,
    this.ownershipPercentage,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['parcel_id'] = Variable<String>(parcelId);
    map['farmer_id'] = Variable<String>(farmerId);
    if (!nullToAbsent || ownershipPercentage != null) {
      map['ownership_percentage'] = Variable<double>(ownershipPercentage);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ParcelOwnersCompanion toCompanion(bool nullToAbsent) {
    return ParcelOwnersCompanion(
      id: Value(id),
      parcelId: Value(parcelId),
      farmerId: Value(farmerId),
      ownershipPercentage: ownershipPercentage == null && nullToAbsent
          ? const Value.absent()
          : Value(ownershipPercentage),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ParcelOwnerRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ParcelOwnerRow(
      id: serializer.fromJson<String>(json['id']),
      parcelId: serializer.fromJson<String>(json['parcelId']),
      farmerId: serializer.fromJson<String>(json['farmerId']),
      ownershipPercentage: serializer.fromJson<double?>(
        json['ownershipPercentage'],
      ),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'parcelId': serializer.toJson<String>(parcelId),
      'farmerId': serializer.toJson<String>(farmerId),
      'ownershipPercentage': serializer.toJson<double?>(ownershipPercentage),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ParcelOwnerRow copyWith({
    String? id,
    String? parcelId,
    String? farmerId,
    Value<double?> ownershipPercentage = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ParcelOwnerRow(
    id: id ?? this.id,
    parcelId: parcelId ?? this.parcelId,
    farmerId: farmerId ?? this.farmerId,
    ownershipPercentage: ownershipPercentage.present
        ? ownershipPercentage.value
        : this.ownershipPercentage,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ParcelOwnerRow copyWithCompanion(ParcelOwnersCompanion data) {
    return ParcelOwnerRow(
      id: data.id.present ? data.id.value : this.id,
      parcelId: data.parcelId.present ? data.parcelId.value : this.parcelId,
      farmerId: data.farmerId.present ? data.farmerId.value : this.farmerId,
      ownershipPercentage: data.ownershipPercentage.present
          ? data.ownershipPercentage.value
          : this.ownershipPercentage,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ParcelOwnerRow(')
          ..write('id: $id, ')
          ..write('parcelId: $parcelId, ')
          ..write('farmerId: $farmerId, ')
          ..write('ownershipPercentage: $ownershipPercentage, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    parcelId,
    farmerId,
    ownershipPercentage,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ParcelOwnerRow &&
          other.id == this.id &&
          other.parcelId == this.parcelId &&
          other.farmerId == this.farmerId &&
          other.ownershipPercentage == this.ownershipPercentage &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ParcelOwnersCompanion extends UpdateCompanion<ParcelOwnerRow> {
  final Value<String> id;
  final Value<String> parcelId;
  final Value<String> farmerId;
  final Value<double?> ownershipPercentage;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ParcelOwnersCompanion({
    this.id = const Value.absent(),
    this.parcelId = const Value.absent(),
    this.farmerId = const Value.absent(),
    this.ownershipPercentage = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ParcelOwnersCompanion.insert({
    required String id,
    required String parcelId,
    required String farmerId,
    this.ownershipPercentage = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       parcelId = Value(parcelId),
       farmerId = Value(farmerId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ParcelOwnerRow> custom({
    Expression<String>? id,
    Expression<String>? parcelId,
    Expression<String>? farmerId,
    Expression<double>? ownershipPercentage,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (parcelId != null) 'parcel_id': parcelId,
      if (farmerId != null) 'farmer_id': farmerId,
      if (ownershipPercentage != null)
        'ownership_percentage': ownershipPercentage,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ParcelOwnersCompanion copyWith({
    Value<String>? id,
    Value<String>? parcelId,
    Value<String>? farmerId,
    Value<double?>? ownershipPercentage,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ParcelOwnersCompanion(
      id: id ?? this.id,
      parcelId: parcelId ?? this.parcelId,
      farmerId: farmerId ?? this.farmerId,
      ownershipPercentage: ownershipPercentage ?? this.ownershipPercentage,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (parcelId.present) {
      map['parcel_id'] = Variable<String>(parcelId.value);
    }
    if (farmerId.present) {
      map['farmer_id'] = Variable<String>(farmerId.value);
    }
    if (ownershipPercentage.present) {
      map['ownership_percentage'] = Variable<double>(ownershipPercentage.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ParcelOwnersCompanion(')
          ..write('id: $id, ')
          ..write('parcelId: $parcelId, ')
          ..write('farmerId: $farmerId, ')
          ..write('ownershipPercentage: $ownershipPercentage, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ParcelVerticesTable extends ParcelVertices
    with TableInfo<$ParcelVerticesTable, ParcelVertexRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ParcelVerticesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parcelIdMeta = const VerificationMeta(
    'parcelId',
  );
  @override
  late final GeneratedColumn<String> parcelId = GeneratedColumn<String>(
    'parcel_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES parcels (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _sequenceNumberMeta = const VerificationMeta(
    'sequenceNumber',
  );
  @override
  late final GeneratedColumn<int> sequenceNumber = GeneratedColumn<int>(
    'sequence_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accuracyMMeta = const VerificationMeta(
    'accuracyM',
  );
  @override
  late final GeneratedColumn<double> accuracyM = GeneratedColumn<double>(
    'accuracy_m',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<VertexCaptureMethod, String>
  captureMethod =
      GeneratedColumn<String>(
        'capture_method',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<VertexCaptureMethod>(
        $ParcelVerticesTable.$convertercaptureMethod,
      );
  static const VerificationMeta _capturedAtMeta = const VerificationMeta(
    'capturedAt',
  );
  @override
  late final GeneratedColumn<DateTime> capturedAt = GeneratedColumn<DateTime>(
    'captured_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    parcelId,
    sequenceNumber,
    latitude,
    longitude,
    accuracyM,
    captureMethod,
    capturedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'parcel_vertices';
  @override
  VerificationContext validateIntegrity(
    Insertable<ParcelVertexRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('parcel_id')) {
      context.handle(
        _parcelIdMeta,
        parcelId.isAcceptableOrUnknown(data['parcel_id']!, _parcelIdMeta),
      );
    } else if (isInserting) {
      context.missing(_parcelIdMeta);
    }
    if (data.containsKey('sequence_number')) {
      context.handle(
        _sequenceNumberMeta,
        sequenceNumber.isAcceptableOrUnknown(
          data['sequence_number']!,
          _sequenceNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sequenceNumberMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('accuracy_m')) {
      context.handle(
        _accuracyMMeta,
        accuracyM.isAcceptableOrUnknown(data['accuracy_m']!, _accuracyMMeta),
      );
    }
    if (data.containsKey('captured_at')) {
      context.handle(
        _capturedAtMeta,
        capturedAt.isAcceptableOrUnknown(data['captured_at']!, _capturedAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {parcelId, sequenceNumber},
  ];
  @override
  ParcelVertexRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ParcelVertexRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      parcelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parcel_id'],
      )!,
      sequenceNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sequence_number'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      )!,
      accuracyM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}accuracy_m'],
      ),
      captureMethod: $ParcelVerticesTable.$convertercaptureMethod.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}capture_method'],
        )!,
      ),
      capturedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}captured_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ParcelVerticesTable createAlias(String alias) {
    return $ParcelVerticesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<VertexCaptureMethod, String, String>
  $convertercaptureMethod = const EnumNameConverter<VertexCaptureMethod>(
    VertexCaptureMethod.values,
  );
}

class ParcelVertexRow extends DataClass implements Insertable<ParcelVertexRow> {
  final String id;
  final String parcelId;
  final int sequenceNumber;
  final double latitude;
  final double longitude;
  final double? accuracyM;
  final VertexCaptureMethod captureMethod;
  final DateTime? capturedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ParcelVertexRow({
    required this.id,
    required this.parcelId,
    required this.sequenceNumber,
    required this.latitude,
    required this.longitude,
    this.accuracyM,
    required this.captureMethod,
    this.capturedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['parcel_id'] = Variable<String>(parcelId);
    map['sequence_number'] = Variable<int>(sequenceNumber);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    if (!nullToAbsent || accuracyM != null) {
      map['accuracy_m'] = Variable<double>(accuracyM);
    }
    {
      map['capture_method'] = Variable<String>(
        $ParcelVerticesTable.$convertercaptureMethod.toSql(captureMethod),
      );
    }
    if (!nullToAbsent || capturedAt != null) {
      map['captured_at'] = Variable<DateTime>(capturedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ParcelVerticesCompanion toCompanion(bool nullToAbsent) {
    return ParcelVerticesCompanion(
      id: Value(id),
      parcelId: Value(parcelId),
      sequenceNumber: Value(sequenceNumber),
      latitude: Value(latitude),
      longitude: Value(longitude),
      accuracyM: accuracyM == null && nullToAbsent
          ? const Value.absent()
          : Value(accuracyM),
      captureMethod: Value(captureMethod),
      capturedAt: capturedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(capturedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ParcelVertexRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ParcelVertexRow(
      id: serializer.fromJson<String>(json['id']),
      parcelId: serializer.fromJson<String>(json['parcelId']),
      sequenceNumber: serializer.fromJson<int>(json['sequenceNumber']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      accuracyM: serializer.fromJson<double?>(json['accuracyM']),
      captureMethod: $ParcelVerticesTable.$convertercaptureMethod.fromJson(
        serializer.fromJson<String>(json['captureMethod']),
      ),
      capturedAt: serializer.fromJson<DateTime?>(json['capturedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'parcelId': serializer.toJson<String>(parcelId),
      'sequenceNumber': serializer.toJson<int>(sequenceNumber),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'accuracyM': serializer.toJson<double?>(accuracyM),
      'captureMethod': serializer.toJson<String>(
        $ParcelVerticesTable.$convertercaptureMethod.toJson(captureMethod),
      ),
      'capturedAt': serializer.toJson<DateTime?>(capturedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ParcelVertexRow copyWith({
    String? id,
    String? parcelId,
    int? sequenceNumber,
    double? latitude,
    double? longitude,
    Value<double?> accuracyM = const Value.absent(),
    VertexCaptureMethod? captureMethod,
    Value<DateTime?> capturedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ParcelVertexRow(
    id: id ?? this.id,
    parcelId: parcelId ?? this.parcelId,
    sequenceNumber: sequenceNumber ?? this.sequenceNumber,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    accuracyM: accuracyM.present ? accuracyM.value : this.accuracyM,
    captureMethod: captureMethod ?? this.captureMethod,
    capturedAt: capturedAt.present ? capturedAt.value : this.capturedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ParcelVertexRow copyWithCompanion(ParcelVerticesCompanion data) {
    return ParcelVertexRow(
      id: data.id.present ? data.id.value : this.id,
      parcelId: data.parcelId.present ? data.parcelId.value : this.parcelId,
      sequenceNumber: data.sequenceNumber.present
          ? data.sequenceNumber.value
          : this.sequenceNumber,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      accuracyM: data.accuracyM.present ? data.accuracyM.value : this.accuracyM,
      captureMethod: data.captureMethod.present
          ? data.captureMethod.value
          : this.captureMethod,
      capturedAt: data.capturedAt.present
          ? data.capturedAt.value
          : this.capturedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ParcelVertexRow(')
          ..write('id: $id, ')
          ..write('parcelId: $parcelId, ')
          ..write('sequenceNumber: $sequenceNumber, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('accuracyM: $accuracyM, ')
          ..write('captureMethod: $captureMethod, ')
          ..write('capturedAt: $capturedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    parcelId,
    sequenceNumber,
    latitude,
    longitude,
    accuracyM,
    captureMethod,
    capturedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ParcelVertexRow &&
          other.id == this.id &&
          other.parcelId == this.parcelId &&
          other.sequenceNumber == this.sequenceNumber &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.accuracyM == this.accuracyM &&
          other.captureMethod == this.captureMethod &&
          other.capturedAt == this.capturedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ParcelVerticesCompanion extends UpdateCompanion<ParcelVertexRow> {
  final Value<String> id;
  final Value<String> parcelId;
  final Value<int> sequenceNumber;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<double?> accuracyM;
  final Value<VertexCaptureMethod> captureMethod;
  final Value<DateTime?> capturedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ParcelVerticesCompanion({
    this.id = const Value.absent(),
    this.parcelId = const Value.absent(),
    this.sequenceNumber = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.accuracyM = const Value.absent(),
    this.captureMethod = const Value.absent(),
    this.capturedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ParcelVerticesCompanion.insert({
    required String id,
    required String parcelId,
    required int sequenceNumber,
    required double latitude,
    required double longitude,
    this.accuracyM = const Value.absent(),
    required VertexCaptureMethod captureMethod,
    this.capturedAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       parcelId = Value(parcelId),
       sequenceNumber = Value(sequenceNumber),
       latitude = Value(latitude),
       longitude = Value(longitude),
       captureMethod = Value(captureMethod),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ParcelVertexRow> custom({
    Expression<String>? id,
    Expression<String>? parcelId,
    Expression<int>? sequenceNumber,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<double>? accuracyM,
    Expression<String>? captureMethod,
    Expression<DateTime>? capturedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (parcelId != null) 'parcel_id': parcelId,
      if (sequenceNumber != null) 'sequence_number': sequenceNumber,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (accuracyM != null) 'accuracy_m': accuracyM,
      if (captureMethod != null) 'capture_method': captureMethod,
      if (capturedAt != null) 'captured_at': capturedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ParcelVerticesCompanion copyWith({
    Value<String>? id,
    Value<String>? parcelId,
    Value<int>? sequenceNumber,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<double?>? accuracyM,
    Value<VertexCaptureMethod>? captureMethod,
    Value<DateTime?>? capturedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ParcelVerticesCompanion(
      id: id ?? this.id,
      parcelId: parcelId ?? this.parcelId,
      sequenceNumber: sequenceNumber ?? this.sequenceNumber,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      accuracyM: accuracyM ?? this.accuracyM,
      captureMethod: captureMethod ?? this.captureMethod,
      capturedAt: capturedAt ?? this.capturedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (parcelId.present) {
      map['parcel_id'] = Variable<String>(parcelId.value);
    }
    if (sequenceNumber.present) {
      map['sequence_number'] = Variable<int>(sequenceNumber.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (accuracyM.present) {
      map['accuracy_m'] = Variable<double>(accuracyM.value);
    }
    if (captureMethod.present) {
      map['capture_method'] = Variable<String>(
        $ParcelVerticesTable.$convertercaptureMethod.toSql(captureMethod.value),
      );
    }
    if (capturedAt.present) {
      map['captured_at'] = Variable<DateTime>(capturedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ParcelVerticesCompanion(')
          ..write('id: $id, ')
          ..write('parcelId: $parcelId, ')
          ..write('sequenceNumber: $sequenceNumber, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('accuracyM: $accuracyM, ')
          ..write('captureMethod: $captureMethod, ')
          ..write('capturedAt: $capturedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VertexPhotosTable extends VertexPhotos
    with TableInfo<$VertexPhotosTable, VertexPhotoRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VertexPhotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vertexIdMeta = const VerificationMeta(
    'vertexId',
  );
  @override
  late final GeneratedColumn<String> vertexId = GeneratedColumn<String>(
    'vertex_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES parcel_vertices (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _relativePathMeta = const VerificationMeta(
    'relativePath',
  );
  @override
  late final GeneratedColumn<String> relativePath = GeneratedColumn<String>(
    'relative_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileNameMeta = const VerificationMeta(
    'fileName',
  );
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
    'file_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vertexId,
    relativePath,
    fileName,
    description,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vertex_photos';
  @override
  VerificationContext validateIntegrity(
    Insertable<VertexPhotoRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('vertex_id')) {
      context.handle(
        _vertexIdMeta,
        vertexId.isAcceptableOrUnknown(data['vertex_id']!, _vertexIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vertexIdMeta);
    }
    if (data.containsKey('relative_path')) {
      context.handle(
        _relativePathMeta,
        relativePath.isAcceptableOrUnknown(
          data['relative_path']!,
          _relativePathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_relativePathMeta);
    }
    if (data.containsKey('file_name')) {
      context.handle(
        _fileNameMeta,
        fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VertexPhotoRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VertexPhotoRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      vertexId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vertex_id'],
      )!,
      relativePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relative_path'],
      )!,
      fileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $VertexPhotosTable createAlias(String alias) {
    return $VertexPhotosTable(attachedDatabase, alias);
  }
}

class VertexPhotoRow extends DataClass implements Insertable<VertexPhotoRow> {
  final String id;
  final String vertexId;
  final String relativePath;
  final String fileName;
  final String? description;
  final DateTime createdAt;
  const VertexPhotoRow({
    required this.id,
    required this.vertexId,
    required this.relativePath,
    required this.fileName,
    this.description,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['vertex_id'] = Variable<String>(vertexId);
    map['relative_path'] = Variable<String>(relativePath);
    map['file_name'] = Variable<String>(fileName);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  VertexPhotosCompanion toCompanion(bool nullToAbsent) {
    return VertexPhotosCompanion(
      id: Value(id),
      vertexId: Value(vertexId),
      relativePath: Value(relativePath),
      fileName: Value(fileName),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
    );
  }

  factory VertexPhotoRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VertexPhotoRow(
      id: serializer.fromJson<String>(json['id']),
      vertexId: serializer.fromJson<String>(json['vertexId']),
      relativePath: serializer.fromJson<String>(json['relativePath']),
      fileName: serializer.fromJson<String>(json['fileName']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'vertexId': serializer.toJson<String>(vertexId),
      'relativePath': serializer.toJson<String>(relativePath),
      'fileName': serializer.toJson<String>(fileName),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  VertexPhotoRow copyWith({
    String? id,
    String? vertexId,
    String? relativePath,
    String? fileName,
    Value<String?> description = const Value.absent(),
    DateTime? createdAt,
  }) => VertexPhotoRow(
    id: id ?? this.id,
    vertexId: vertexId ?? this.vertexId,
    relativePath: relativePath ?? this.relativePath,
    fileName: fileName ?? this.fileName,
    description: description.present ? description.value : this.description,
    createdAt: createdAt ?? this.createdAt,
  );
  VertexPhotoRow copyWithCompanion(VertexPhotosCompanion data) {
    return VertexPhotoRow(
      id: data.id.present ? data.id.value : this.id,
      vertexId: data.vertexId.present ? data.vertexId.value : this.vertexId,
      relativePath: data.relativePath.present
          ? data.relativePath.value
          : this.relativePath,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      description: data.description.present
          ? data.description.value
          : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VertexPhotoRow(')
          ..write('id: $id, ')
          ..write('vertexId: $vertexId, ')
          ..write('relativePath: $relativePath, ')
          ..write('fileName: $fileName, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, vertexId, relativePath, fileName, description, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VertexPhotoRow &&
          other.id == this.id &&
          other.vertexId == this.vertexId &&
          other.relativePath == this.relativePath &&
          other.fileName == this.fileName &&
          other.description == this.description &&
          other.createdAt == this.createdAt);
}

class VertexPhotosCompanion extends UpdateCompanion<VertexPhotoRow> {
  final Value<String> id;
  final Value<String> vertexId;
  final Value<String> relativePath;
  final Value<String> fileName;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const VertexPhotosCompanion({
    this.id = const Value.absent(),
    this.vertexId = const Value.absent(),
    this.relativePath = const Value.absent(),
    this.fileName = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VertexPhotosCompanion.insert({
    required String id,
    required String vertexId,
    required String relativePath,
    required String fileName,
    this.description = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       vertexId = Value(vertexId),
       relativePath = Value(relativePath),
       fileName = Value(fileName),
       createdAt = Value(createdAt);
  static Insertable<VertexPhotoRow> custom({
    Expression<String>? id,
    Expression<String>? vertexId,
    Expression<String>? relativePath,
    Expression<String>? fileName,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vertexId != null) 'vertex_id': vertexId,
      if (relativePath != null) 'relative_path': relativePath,
      if (fileName != null) 'file_name': fileName,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VertexPhotosCompanion copyWith({
    Value<String>? id,
    Value<String>? vertexId,
    Value<String>? relativePath,
    Value<String>? fileName,
    Value<String?>? description,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return VertexPhotosCompanion(
      id: id ?? this.id,
      vertexId: vertexId ?? this.vertexId,
      relativePath: relativePath ?? this.relativePath,
      fileName: fileName ?? this.fileName,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (vertexId.present) {
      map['vertex_id'] = Variable<String>(vertexId.value);
    }
    if (relativePath.present) {
      map['relative_path'] = Variable<String>(relativePath.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VertexPhotosCompanion(')
          ..write('id: $id, ')
          ..write('vertexId: $vertexId, ')
          ..write('relativePath: $relativePath, ')
          ..write('fileName: $fileName, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GrapeVarietiesTable extends GrapeVarieties
    with TableInfo<$GrapeVarietiesTable, GrapeVarietyRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GrapeVarietiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _aliasesMeta = const VerificationMeta(
    'aliases',
  );
  @override
  late final GeneratedColumn<String> aliases = GeneratedColumn<String>(
    'aliases',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    name,
    category,
    description,
    aliases,
    active,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'grape_varieties';
  @override
  VerificationContext validateIntegrity(
    Insertable<GrapeVarietyRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('aliases')) {
      context.handle(
        _aliasesMeta,
        aliases.isAcceptableOrUnknown(data['aliases']!, _aliasesMeta),
      );
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {name},
    {code},
  ];
  @override
  GrapeVarietyRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GrapeVarietyRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      aliases: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}aliases'],
      ),
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $GrapeVarietiesTable createAlias(String alias) {
    return $GrapeVarietiesTable(attachedDatabase, alias);
  }
}

class GrapeVarietyRow extends DataClass implements Insertable<GrapeVarietyRow> {
  final String id;

  /// Correlativo de registro asignado por el sistema (`UVA-###`).
  final String? code;
  final String name;
  final String? category;
  final String? description;
  final String? aliases;
  final bool active;
  final DateTime createdAt;
  final DateTime updatedAt;
  const GrapeVarietyRow({
    required this.id,
    this.code,
    required this.name,
    this.category,
    this.description,
    this.aliases,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || aliases != null) {
      map['aliases'] = Variable<String>(aliases);
    }
    map['active'] = Variable<bool>(active);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  GrapeVarietiesCompanion toCompanion(bool nullToAbsent) {
    return GrapeVarietiesCompanion(
      id: Value(id),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      name: Value(name),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      aliases: aliases == null && nullToAbsent
          ? const Value.absent()
          : Value(aliases),
      active: Value(active),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory GrapeVarietyRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GrapeVarietyRow(
      id: serializer.fromJson<String>(json['id']),
      code: serializer.fromJson<String?>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String?>(json['category']),
      description: serializer.fromJson<String?>(json['description']),
      aliases: serializer.fromJson<String?>(json['aliases']),
      active: serializer.fromJson<bool>(json['active']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'code': serializer.toJson<String?>(code),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String?>(category),
      'description': serializer.toJson<String?>(description),
      'aliases': serializer.toJson<String?>(aliases),
      'active': serializer.toJson<bool>(active),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  GrapeVarietyRow copyWith({
    String? id,
    Value<String?> code = const Value.absent(),
    String? name,
    Value<String?> category = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<String?> aliases = const Value.absent(),
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => GrapeVarietyRow(
    id: id ?? this.id,
    code: code.present ? code.value : this.code,
    name: name ?? this.name,
    category: category.present ? category.value : this.category,
    description: description.present ? description.value : this.description,
    aliases: aliases.present ? aliases.value : this.aliases,
    active: active ?? this.active,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  GrapeVarietyRow copyWithCompanion(GrapeVarietiesCompanion data) {
    return GrapeVarietyRow(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      description: data.description.present
          ? data.description.value
          : this.description,
      aliases: data.aliases.present ? data.aliases.value : this.aliases,
      active: data.active.present ? data.active.value : this.active,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GrapeVarietyRow(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('aliases: $aliases, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    code,
    name,
    category,
    description,
    aliases,
    active,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GrapeVarietyRow &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.category == this.category &&
          other.description == this.description &&
          other.aliases == this.aliases &&
          other.active == this.active &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class GrapeVarietiesCompanion extends UpdateCompanion<GrapeVarietyRow> {
  final Value<String> id;
  final Value<String?> code;
  final Value<String> name;
  final Value<String?> category;
  final Value<String?> description;
  final Value<String?> aliases;
  final Value<bool> active;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const GrapeVarietiesCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.description = const Value.absent(),
    this.aliases = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GrapeVarietiesCompanion.insert({
    required String id,
    this.code = const Value.absent(),
    required String name,
    this.category = const Value.absent(),
    this.description = const Value.absent(),
    this.aliases = const Value.absent(),
    this.active = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<GrapeVarietyRow> custom({
    Expression<String>? id,
    Expression<String>? code,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? description,
    Expression<String>? aliases,
    Expression<bool>? active,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (description != null) 'description': description,
      if (aliases != null) 'aliases': aliases,
      if (active != null) 'active': active,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GrapeVarietiesCompanion copyWith({
    Value<String>? id,
    Value<String?>? code,
    Value<String>? name,
    Value<String?>? category,
    Value<String?>? description,
    Value<String?>? aliases,
    Value<bool>? active,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return GrapeVarietiesCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      aliases: aliases ?? this.aliases,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (aliases.present) {
      map['aliases'] = Variable<String>(aliases.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GrapeVarietiesCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('aliases: $aliases, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ParcelVarietiesTable extends ParcelVarieties
    with TableInfo<$ParcelVarietiesTable, ParcelVarietyRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ParcelVarietiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parcelIdMeta = const VerificationMeta(
    'parcelId',
  );
  @override
  late final GeneratedColumn<String> parcelId = GeneratedColumn<String>(
    'parcel_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES parcels (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _grapeVarietyIdMeta = const VerificationMeta(
    'grapeVarietyId',
  );
  @override
  late final GeneratedColumn<String> grapeVarietyId = GeneratedColumn<String>(
    'grape_variety_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES grape_varieties (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _plantedAreaPercentageMeta =
      const VerificationMeta('plantedAreaPercentage');
  @override
  late final GeneratedColumn<double> plantedAreaPercentage =
      GeneratedColumn<double>(
        'planted_area_percentage',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    parcelId,
    grapeVarietyId,
    plantedAreaPercentage,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'parcel_varieties';
  @override
  VerificationContext validateIntegrity(
    Insertable<ParcelVarietyRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('parcel_id')) {
      context.handle(
        _parcelIdMeta,
        parcelId.isAcceptableOrUnknown(data['parcel_id']!, _parcelIdMeta),
      );
    } else if (isInserting) {
      context.missing(_parcelIdMeta);
    }
    if (data.containsKey('grape_variety_id')) {
      context.handle(
        _grapeVarietyIdMeta,
        grapeVarietyId.isAcceptableOrUnknown(
          data['grape_variety_id']!,
          _grapeVarietyIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_grapeVarietyIdMeta);
    }
    if (data.containsKey('planted_area_percentage')) {
      context.handle(
        _plantedAreaPercentageMeta,
        plantedAreaPercentage.isAcceptableOrUnknown(
          data['planted_area_percentage']!,
          _plantedAreaPercentageMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {parcelId, grapeVarietyId},
  ];
  @override
  ParcelVarietyRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ParcelVarietyRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      parcelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parcel_id'],
      )!,
      grapeVarietyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grape_variety_id'],
      )!,
      plantedAreaPercentage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}planted_area_percentage'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ParcelVarietiesTable createAlias(String alias) {
    return $ParcelVarietiesTable(attachedDatabase, alias);
  }
}

class ParcelVarietyRow extends DataClass
    implements Insertable<ParcelVarietyRow> {
  final String id;
  final String parcelId;
  final String grapeVarietyId;
  final double? plantedAreaPercentage;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ParcelVarietyRow({
    required this.id,
    required this.parcelId,
    required this.grapeVarietyId,
    this.plantedAreaPercentage,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['parcel_id'] = Variable<String>(parcelId);
    map['grape_variety_id'] = Variable<String>(grapeVarietyId);
    if (!nullToAbsent || plantedAreaPercentage != null) {
      map['planted_area_percentage'] = Variable<double>(plantedAreaPercentage);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ParcelVarietiesCompanion toCompanion(bool nullToAbsent) {
    return ParcelVarietiesCompanion(
      id: Value(id),
      parcelId: Value(parcelId),
      grapeVarietyId: Value(grapeVarietyId),
      plantedAreaPercentage: plantedAreaPercentage == null && nullToAbsent
          ? const Value.absent()
          : Value(plantedAreaPercentage),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ParcelVarietyRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ParcelVarietyRow(
      id: serializer.fromJson<String>(json['id']),
      parcelId: serializer.fromJson<String>(json['parcelId']),
      grapeVarietyId: serializer.fromJson<String>(json['grapeVarietyId']),
      plantedAreaPercentage: serializer.fromJson<double?>(
        json['plantedAreaPercentage'],
      ),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'parcelId': serializer.toJson<String>(parcelId),
      'grapeVarietyId': serializer.toJson<String>(grapeVarietyId),
      'plantedAreaPercentage': serializer.toJson<double?>(
        plantedAreaPercentage,
      ),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ParcelVarietyRow copyWith({
    String? id,
    String? parcelId,
    String? grapeVarietyId,
    Value<double?> plantedAreaPercentage = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ParcelVarietyRow(
    id: id ?? this.id,
    parcelId: parcelId ?? this.parcelId,
    grapeVarietyId: grapeVarietyId ?? this.grapeVarietyId,
    plantedAreaPercentage: plantedAreaPercentage.present
        ? plantedAreaPercentage.value
        : this.plantedAreaPercentage,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ParcelVarietyRow copyWithCompanion(ParcelVarietiesCompanion data) {
    return ParcelVarietyRow(
      id: data.id.present ? data.id.value : this.id,
      parcelId: data.parcelId.present ? data.parcelId.value : this.parcelId,
      grapeVarietyId: data.grapeVarietyId.present
          ? data.grapeVarietyId.value
          : this.grapeVarietyId,
      plantedAreaPercentage: data.plantedAreaPercentage.present
          ? data.plantedAreaPercentage.value
          : this.plantedAreaPercentage,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ParcelVarietyRow(')
          ..write('id: $id, ')
          ..write('parcelId: $parcelId, ')
          ..write('grapeVarietyId: $grapeVarietyId, ')
          ..write('plantedAreaPercentage: $plantedAreaPercentage, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    parcelId,
    grapeVarietyId,
    plantedAreaPercentage,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ParcelVarietyRow &&
          other.id == this.id &&
          other.parcelId == this.parcelId &&
          other.grapeVarietyId == this.grapeVarietyId &&
          other.plantedAreaPercentage == this.plantedAreaPercentage &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ParcelVarietiesCompanion extends UpdateCompanion<ParcelVarietyRow> {
  final Value<String> id;
  final Value<String> parcelId;
  final Value<String> grapeVarietyId;
  final Value<double?> plantedAreaPercentage;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ParcelVarietiesCompanion({
    this.id = const Value.absent(),
    this.parcelId = const Value.absent(),
    this.grapeVarietyId = const Value.absent(),
    this.plantedAreaPercentage = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ParcelVarietiesCompanion.insert({
    required String id,
    required String parcelId,
    required String grapeVarietyId,
    this.plantedAreaPercentage = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       parcelId = Value(parcelId),
       grapeVarietyId = Value(grapeVarietyId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ParcelVarietyRow> custom({
    Expression<String>? id,
    Expression<String>? parcelId,
    Expression<String>? grapeVarietyId,
    Expression<double>? plantedAreaPercentage,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (parcelId != null) 'parcel_id': parcelId,
      if (grapeVarietyId != null) 'grape_variety_id': grapeVarietyId,
      if (plantedAreaPercentage != null)
        'planted_area_percentage': plantedAreaPercentage,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ParcelVarietiesCompanion copyWith({
    Value<String>? id,
    Value<String>? parcelId,
    Value<String>? grapeVarietyId,
    Value<double?>? plantedAreaPercentage,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ParcelVarietiesCompanion(
      id: id ?? this.id,
      parcelId: parcelId ?? this.parcelId,
      grapeVarietyId: grapeVarietyId ?? this.grapeVarietyId,
      plantedAreaPercentage:
          plantedAreaPercentage ?? this.plantedAreaPercentage,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (parcelId.present) {
      map['parcel_id'] = Variable<String>(parcelId.value);
    }
    if (grapeVarietyId.present) {
      map['grape_variety_id'] = Variable<String>(grapeVarietyId.value);
    }
    if (plantedAreaPercentage.present) {
      map['planted_area_percentage'] = Variable<double>(
        plantedAreaPercentage.value,
      );
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ParcelVarietiesCompanion(')
          ..write('id: $id, ')
          ..write('parcelId: $parcelId, ')
          ..write('grapeVarietyId: $grapeVarietyId, ')
          ..write('plantedAreaPercentage: $plantedAreaPercentage, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HarvestSeasonsTable extends HarvestSeasons
    with TableInfo<$HarvestSeasonsTable, HarvestSeasonRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HarvestSeasonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 60,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    name,
    startDate,
    endDate,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'harvest_seasons';
  @override
  VerificationContext validateIntegrity(
    Insertable<HarvestSeasonRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {name},
    {code},
  ];
  @override
  HarvestSeasonRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HarvestSeasonRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      ),
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $HarvestSeasonsTable createAlias(String alias) {
    return $HarvestSeasonsTable(attachedDatabase, alias);
  }
}

class HarvestSeasonRow extends DataClass
    implements Insertable<HarvestSeasonRow> {
  final String id;

  /// Correlativo de registro asignado por el sistema (`TEM-###`).
  final String? code;
  final String name;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const HarvestSeasonRow({
    required this.id,
    this.code,
    required this.name,
    this.startDate,
    this.endDate,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime>(startDate);
    }
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  HarvestSeasonsCompanion toCompanion(bool nullToAbsent) {
    return HarvestSeasonsCompanion(
      id: Value(id),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      name: Value(name),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory HarvestSeasonRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HarvestSeasonRow(
      id: serializer.fromJson<String>(json['id']),
      code: serializer.fromJson<String?>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      startDate: serializer.fromJson<DateTime?>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'code': serializer.toJson<String?>(code),
      'name': serializer.toJson<String>(name),
      'startDate': serializer.toJson<DateTime?>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  HarvestSeasonRow copyWith({
    String? id,
    Value<String?> code = const Value.absent(),
    String? name,
    Value<DateTime?> startDate = const Value.absent(),
    Value<DateTime?> endDate = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => HarvestSeasonRow(
    id: id ?? this.id,
    code: code.present ? code.value : this.code,
    name: name ?? this.name,
    startDate: startDate.present ? startDate.value : this.startDate,
    endDate: endDate.present ? endDate.value : this.endDate,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  HarvestSeasonRow copyWithCompanion(HarvestSeasonsCompanion data) {
    return HarvestSeasonRow(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HarvestSeasonRow(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    code,
    name,
    startDate,
    endDate,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HarvestSeasonRow &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class HarvestSeasonsCompanion extends UpdateCompanion<HarvestSeasonRow> {
  final Value<String> id;
  final Value<String?> code;
  final Value<String> name;
  final Value<DateTime?> startDate;
  final Value<DateTime?> endDate;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const HarvestSeasonsCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HarvestSeasonsCompanion.insert({
    required String id,
    this.code = const Value.absent(),
    required String name,
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<HarvestSeasonRow> custom({
    Expression<String>? id,
    Expression<String>? code,
    Expression<String>? name,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HarvestSeasonsCompanion copyWith({
    Value<String>? id,
    Value<String?>? code,
    Value<String>? name,
    Value<DateTime?>? startDate,
    Value<DateTime?>? endDate,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return HarvestSeasonsCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HarvestSeasonsCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MeasurementUnitsTable extends MeasurementUnits
    with TableInfo<$MeasurementUnitsTable, MeasurementUnitRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MeasurementUnitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 16,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _abbreviationMeta = const VerificationMeta(
    'abbreviation',
  );
  @override
  late final GeneratedColumn<String> abbreviation = GeneratedColumn<String>(
    'abbreviation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 60,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kilogramsEquivalentMeta =
      const VerificationMeta('kilogramsEquivalent');
  @override
  late final GeneratedColumn<double> kilogramsEquivalent =
      GeneratedColumn<double>(
        'kilograms_equivalent',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    abbreviation,
    name,
    kilogramsEquivalent,
    active,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'measurement_units';
  @override
  VerificationContext validateIntegrity(
    Insertable<MeasurementUnitRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('abbreviation')) {
      context.handle(
        _abbreviationMeta,
        abbreviation.isAcceptableOrUnknown(
          data['abbreviation']!,
          _abbreviationMeta,
        ),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('kilograms_equivalent')) {
      context.handle(
        _kilogramsEquivalentMeta,
        kilogramsEquivalent.isAcceptableOrUnknown(
          data['kilograms_equivalent']!,
          _kilogramsEquivalentMeta,
        ),
      );
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {code},
    {abbreviation},
  ];
  @override
  MeasurementUnitRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MeasurementUnitRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      abbreviation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}abbreviation'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      kilogramsEquivalent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}kilograms_equivalent'],
      ),
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MeasurementUnitsTable createAlias(String alias) {
    return $MeasurementUnitsTable(attachedDatabase, alias);
  }
}

class MeasurementUnitRow extends DataClass
    implements Insertable<MeasurementUnitRow> {
  final String id;

  /// Correlativo de registro asignado por el sistema (`UNI-###`).
  final String code;

  /// Abreviatura visible y editable por el usuario (`kg`, `cajón`, `ton`).
  ///
  /// Es la que se muestra junto a las cantidades y la que el usuario necesita
  /// para crear sus propias unidades y convertirlas a kilogramos.
  final String? abbreviation;
  final String name;
  final double? kilogramsEquivalent;
  final bool active;
  final DateTime createdAt;
  final DateTime updatedAt;
  const MeasurementUnitRow({
    required this.id,
    required this.code,
    this.abbreviation,
    required this.name,
    this.kilogramsEquivalent,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['code'] = Variable<String>(code);
    if (!nullToAbsent || abbreviation != null) {
      map['abbreviation'] = Variable<String>(abbreviation);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || kilogramsEquivalent != null) {
      map['kilograms_equivalent'] = Variable<double>(kilogramsEquivalent);
    }
    map['active'] = Variable<bool>(active);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MeasurementUnitsCompanion toCompanion(bool nullToAbsent) {
    return MeasurementUnitsCompanion(
      id: Value(id),
      code: Value(code),
      abbreviation: abbreviation == null && nullToAbsent
          ? const Value.absent()
          : Value(abbreviation),
      name: Value(name),
      kilogramsEquivalent: kilogramsEquivalent == null && nullToAbsent
          ? const Value.absent()
          : Value(kilogramsEquivalent),
      active: Value(active),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MeasurementUnitRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MeasurementUnitRow(
      id: serializer.fromJson<String>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      abbreviation: serializer.fromJson<String?>(json['abbreviation']),
      name: serializer.fromJson<String>(json['name']),
      kilogramsEquivalent: serializer.fromJson<double?>(
        json['kilogramsEquivalent'],
      ),
      active: serializer.fromJson<bool>(json['active']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'code': serializer.toJson<String>(code),
      'abbreviation': serializer.toJson<String?>(abbreviation),
      'name': serializer.toJson<String>(name),
      'kilogramsEquivalent': serializer.toJson<double?>(kilogramsEquivalent),
      'active': serializer.toJson<bool>(active),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MeasurementUnitRow copyWith({
    String? id,
    String? code,
    Value<String?> abbreviation = const Value.absent(),
    String? name,
    Value<double?> kilogramsEquivalent = const Value.absent(),
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => MeasurementUnitRow(
    id: id ?? this.id,
    code: code ?? this.code,
    abbreviation: abbreviation.present ? abbreviation.value : this.abbreviation,
    name: name ?? this.name,
    kilogramsEquivalent: kilogramsEquivalent.present
        ? kilogramsEquivalent.value
        : this.kilogramsEquivalent,
    active: active ?? this.active,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MeasurementUnitRow copyWithCompanion(MeasurementUnitsCompanion data) {
    return MeasurementUnitRow(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      abbreviation: data.abbreviation.present
          ? data.abbreviation.value
          : this.abbreviation,
      name: data.name.present ? data.name.value : this.name,
      kilogramsEquivalent: data.kilogramsEquivalent.present
          ? data.kilogramsEquivalent.value
          : this.kilogramsEquivalent,
      active: data.active.present ? data.active.value : this.active,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MeasurementUnitRow(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('abbreviation: $abbreviation, ')
          ..write('name: $name, ')
          ..write('kilogramsEquivalent: $kilogramsEquivalent, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    code,
    abbreviation,
    name,
    kilogramsEquivalent,
    active,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MeasurementUnitRow &&
          other.id == this.id &&
          other.code == this.code &&
          other.abbreviation == this.abbreviation &&
          other.name == this.name &&
          other.kilogramsEquivalent == this.kilogramsEquivalent &&
          other.active == this.active &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MeasurementUnitsCompanion extends UpdateCompanion<MeasurementUnitRow> {
  final Value<String> id;
  final Value<String> code;
  final Value<String?> abbreviation;
  final Value<String> name;
  final Value<double?> kilogramsEquivalent;
  final Value<bool> active;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const MeasurementUnitsCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.abbreviation = const Value.absent(),
    this.name = const Value.absent(),
    this.kilogramsEquivalent = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MeasurementUnitsCompanion.insert({
    required String id,
    required String code,
    this.abbreviation = const Value.absent(),
    required String name,
    this.kilogramsEquivalent = const Value.absent(),
    this.active = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       code = Value(code),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<MeasurementUnitRow> custom({
    Expression<String>? id,
    Expression<String>? code,
    Expression<String>? abbreviation,
    Expression<String>? name,
    Expression<double>? kilogramsEquivalent,
    Expression<bool>? active,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (abbreviation != null) 'abbreviation': abbreviation,
      if (name != null) 'name': name,
      if (kilogramsEquivalent != null)
        'kilograms_equivalent': kilogramsEquivalent,
      if (active != null) 'active': active,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MeasurementUnitsCompanion copyWith({
    Value<String>? id,
    Value<String>? code,
    Value<String?>? abbreviation,
    Value<String>? name,
    Value<double?>? kilogramsEquivalent,
    Value<bool>? active,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return MeasurementUnitsCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      abbreviation: abbreviation ?? this.abbreviation,
      name: name ?? this.name,
      kilogramsEquivalent: kilogramsEquivalent ?? this.kilogramsEquivalent,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (abbreviation.present) {
      map['abbreviation'] = Variable<String>(abbreviation.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (kilogramsEquivalent.present) {
      map['kilograms_equivalent'] = Variable<double>(kilogramsEquivalent.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MeasurementUnitsCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('abbreviation: $abbreviation, ')
          ..write('name: $name, ')
          ..write('kilogramsEquivalent: $kilogramsEquivalent, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductionEstimatesTable extends ProductionEstimates
    with TableInfo<$ProductionEstimatesTable, ProductionEstimateRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductionEstimatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parcelIdMeta = const VerificationMeta(
    'parcelId',
  );
  @override
  late final GeneratedColumn<String> parcelId = GeneratedColumn<String>(
    'parcel_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES parcels (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _seasonIdMeta = const VerificationMeta(
    'seasonId',
  );
  @override
  late final GeneratedColumn<String> seasonId = GeneratedColumn<String>(
    'season_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES harvest_seasons (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _grapeVarietyIdMeta = const VerificationMeta(
    'grapeVarietyId',
  );
  @override
  late final GeneratedColumn<String> grapeVarietyId = GeneratedColumn<String>(
    'grape_variety_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES grape_varieties (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitIdMeta = const VerificationMeta('unitId');
  @override
  late final GeneratedColumn<String> unitId = GeneratedColumn<String>(
    'unit_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES measurement_units (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _conversionFactorKgMeta =
      const VerificationMeta('conversionFactorKg');
  @override
  late final GeneratedColumn<double> conversionFactorKg =
      GeneratedColumn<double>(
        'conversion_factor_kg',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _estimatedKgMeta = const VerificationMeta(
    'estimatedKg',
  );
  @override
  late final GeneratedColumn<double> estimatedKg = GeneratedColumn<double>(
    'estimated_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    parcelId,
    seasonId,
    grapeVarietyId,
    quantity,
    unitId,
    conversionFactorKg,
    estimatedKg,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'production_estimates';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductionEstimateRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('parcel_id')) {
      context.handle(
        _parcelIdMeta,
        parcelId.isAcceptableOrUnknown(data['parcel_id']!, _parcelIdMeta),
      );
    } else if (isInserting) {
      context.missing(_parcelIdMeta);
    }
    if (data.containsKey('season_id')) {
      context.handle(
        _seasonIdMeta,
        seasonId.isAcceptableOrUnknown(data['season_id']!, _seasonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_seasonIdMeta);
    }
    if (data.containsKey('grape_variety_id')) {
      context.handle(
        _grapeVarietyIdMeta,
        grapeVarietyId.isAcceptableOrUnknown(
          data['grape_variety_id']!,
          _grapeVarietyIdMeta,
        ),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_id')) {
      context.handle(
        _unitIdMeta,
        unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_unitIdMeta);
    }
    if (data.containsKey('conversion_factor_kg')) {
      context.handle(
        _conversionFactorKgMeta,
        conversionFactorKg.isAcceptableOrUnknown(
          data['conversion_factor_kg']!,
          _conversionFactorKgMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_conversionFactorKgMeta);
    }
    if (data.containsKey('estimated_kg')) {
      context.handle(
        _estimatedKgMeta,
        estimatedKg.isAcceptableOrUnknown(
          data['estimated_kg']!,
          _estimatedKgMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_estimatedKgMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductionEstimateRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductionEstimateRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      parcelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parcel_id'],
      )!,
      seasonId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}season_id'],
      )!,
      grapeVarietyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grape_variety_id'],
      ),
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      unitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit_id'],
      )!,
      conversionFactorKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}conversion_factor_kg'],
      )!,
      estimatedKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}estimated_kg'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ProductionEstimatesTable createAlias(String alias) {
    return $ProductionEstimatesTable(attachedDatabase, alias);
  }
}

class ProductionEstimateRow extends DataClass
    implements Insertable<ProductionEstimateRow> {
  final String id;
  final String parcelId;
  final String seasonId;
  final String? grapeVarietyId;
  final double quantity;
  final String unitId;
  final double conversionFactorKg;
  final double estimatedKg;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ProductionEstimateRow({
    required this.id,
    required this.parcelId,
    required this.seasonId,
    this.grapeVarietyId,
    required this.quantity,
    required this.unitId,
    required this.conversionFactorKg,
    required this.estimatedKg,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['parcel_id'] = Variable<String>(parcelId);
    map['season_id'] = Variable<String>(seasonId);
    if (!nullToAbsent || grapeVarietyId != null) {
      map['grape_variety_id'] = Variable<String>(grapeVarietyId);
    }
    map['quantity'] = Variable<double>(quantity);
    map['unit_id'] = Variable<String>(unitId);
    map['conversion_factor_kg'] = Variable<double>(conversionFactorKg);
    map['estimated_kg'] = Variable<double>(estimatedKg);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProductionEstimatesCompanion toCompanion(bool nullToAbsent) {
    return ProductionEstimatesCompanion(
      id: Value(id),
      parcelId: Value(parcelId),
      seasonId: Value(seasonId),
      grapeVarietyId: grapeVarietyId == null && nullToAbsent
          ? const Value.absent()
          : Value(grapeVarietyId),
      quantity: Value(quantity),
      unitId: Value(unitId),
      conversionFactorKg: Value(conversionFactorKg),
      estimatedKg: Value(estimatedKg),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ProductionEstimateRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductionEstimateRow(
      id: serializer.fromJson<String>(json['id']),
      parcelId: serializer.fromJson<String>(json['parcelId']),
      seasonId: serializer.fromJson<String>(json['seasonId']),
      grapeVarietyId: serializer.fromJson<String?>(json['grapeVarietyId']),
      quantity: serializer.fromJson<double>(json['quantity']),
      unitId: serializer.fromJson<String>(json['unitId']),
      conversionFactorKg: serializer.fromJson<double>(
        json['conversionFactorKg'],
      ),
      estimatedKg: serializer.fromJson<double>(json['estimatedKg']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'parcelId': serializer.toJson<String>(parcelId),
      'seasonId': serializer.toJson<String>(seasonId),
      'grapeVarietyId': serializer.toJson<String?>(grapeVarietyId),
      'quantity': serializer.toJson<double>(quantity),
      'unitId': serializer.toJson<String>(unitId),
      'conversionFactorKg': serializer.toJson<double>(conversionFactorKg),
      'estimatedKg': serializer.toJson<double>(estimatedKg),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ProductionEstimateRow copyWith({
    String? id,
    String? parcelId,
    String? seasonId,
    Value<String?> grapeVarietyId = const Value.absent(),
    double? quantity,
    String? unitId,
    double? conversionFactorKg,
    double? estimatedKg,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ProductionEstimateRow(
    id: id ?? this.id,
    parcelId: parcelId ?? this.parcelId,
    seasonId: seasonId ?? this.seasonId,
    grapeVarietyId: grapeVarietyId.present
        ? grapeVarietyId.value
        : this.grapeVarietyId,
    quantity: quantity ?? this.quantity,
    unitId: unitId ?? this.unitId,
    conversionFactorKg: conversionFactorKg ?? this.conversionFactorKg,
    estimatedKg: estimatedKg ?? this.estimatedKg,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ProductionEstimateRow copyWithCompanion(ProductionEstimatesCompanion data) {
    return ProductionEstimateRow(
      id: data.id.present ? data.id.value : this.id,
      parcelId: data.parcelId.present ? data.parcelId.value : this.parcelId,
      seasonId: data.seasonId.present ? data.seasonId.value : this.seasonId,
      grapeVarietyId: data.grapeVarietyId.present
          ? data.grapeVarietyId.value
          : this.grapeVarietyId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitId: data.unitId.present ? data.unitId.value : this.unitId,
      conversionFactorKg: data.conversionFactorKg.present
          ? data.conversionFactorKg.value
          : this.conversionFactorKg,
      estimatedKg: data.estimatedKg.present
          ? data.estimatedKg.value
          : this.estimatedKg,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductionEstimateRow(')
          ..write('id: $id, ')
          ..write('parcelId: $parcelId, ')
          ..write('seasonId: $seasonId, ')
          ..write('grapeVarietyId: $grapeVarietyId, ')
          ..write('quantity: $quantity, ')
          ..write('unitId: $unitId, ')
          ..write('conversionFactorKg: $conversionFactorKg, ')
          ..write('estimatedKg: $estimatedKg, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    parcelId,
    seasonId,
    grapeVarietyId,
    quantity,
    unitId,
    conversionFactorKg,
    estimatedKg,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductionEstimateRow &&
          other.id == this.id &&
          other.parcelId == this.parcelId &&
          other.seasonId == this.seasonId &&
          other.grapeVarietyId == this.grapeVarietyId &&
          other.quantity == this.quantity &&
          other.unitId == this.unitId &&
          other.conversionFactorKg == this.conversionFactorKg &&
          other.estimatedKg == this.estimatedKg &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProductionEstimatesCompanion
    extends UpdateCompanion<ProductionEstimateRow> {
  final Value<String> id;
  final Value<String> parcelId;
  final Value<String> seasonId;
  final Value<String?> grapeVarietyId;
  final Value<double> quantity;
  final Value<String> unitId;
  final Value<double> conversionFactorKg;
  final Value<double> estimatedKg;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ProductionEstimatesCompanion({
    this.id = const Value.absent(),
    this.parcelId = const Value.absent(),
    this.seasonId = const Value.absent(),
    this.grapeVarietyId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitId = const Value.absent(),
    this.conversionFactorKg = const Value.absent(),
    this.estimatedKg = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductionEstimatesCompanion.insert({
    required String id,
    required String parcelId,
    required String seasonId,
    this.grapeVarietyId = const Value.absent(),
    required double quantity,
    required String unitId,
    required double conversionFactorKg,
    required double estimatedKg,
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       parcelId = Value(parcelId),
       seasonId = Value(seasonId),
       quantity = Value(quantity),
       unitId = Value(unitId),
       conversionFactorKg = Value(conversionFactorKg),
       estimatedKg = Value(estimatedKg),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ProductionEstimateRow> custom({
    Expression<String>? id,
    Expression<String>? parcelId,
    Expression<String>? seasonId,
    Expression<String>? grapeVarietyId,
    Expression<double>? quantity,
    Expression<String>? unitId,
    Expression<double>? conversionFactorKg,
    Expression<double>? estimatedKg,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (parcelId != null) 'parcel_id': parcelId,
      if (seasonId != null) 'season_id': seasonId,
      if (grapeVarietyId != null) 'grape_variety_id': grapeVarietyId,
      if (quantity != null) 'quantity': quantity,
      if (unitId != null) 'unit_id': unitId,
      if (conversionFactorKg != null)
        'conversion_factor_kg': conversionFactorKg,
      if (estimatedKg != null) 'estimated_kg': estimatedKg,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductionEstimatesCompanion copyWith({
    Value<String>? id,
    Value<String>? parcelId,
    Value<String>? seasonId,
    Value<String?>? grapeVarietyId,
    Value<double>? quantity,
    Value<String>? unitId,
    Value<double>? conversionFactorKg,
    Value<double>? estimatedKg,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ProductionEstimatesCompanion(
      id: id ?? this.id,
      parcelId: parcelId ?? this.parcelId,
      seasonId: seasonId ?? this.seasonId,
      grapeVarietyId: grapeVarietyId ?? this.grapeVarietyId,
      quantity: quantity ?? this.quantity,
      unitId: unitId ?? this.unitId,
      conversionFactorKg: conversionFactorKg ?? this.conversionFactorKg,
      estimatedKg: estimatedKg ?? this.estimatedKg,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (parcelId.present) {
      map['parcel_id'] = Variable<String>(parcelId.value);
    }
    if (seasonId.present) {
      map['season_id'] = Variable<String>(seasonId.value);
    }
    if (grapeVarietyId.present) {
      map['grape_variety_id'] = Variable<String>(grapeVarietyId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unitId.present) {
      map['unit_id'] = Variable<String>(unitId.value);
    }
    if (conversionFactorKg.present) {
      map['conversion_factor_kg'] = Variable<double>(conversionFactorKg.value);
    }
    if (estimatedKg.present) {
      map['estimated_kg'] = Variable<double>(estimatedKg.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductionEstimatesCompanion(')
          ..write('id: $id, ')
          ..write('parcelId: $parcelId, ')
          ..write('seasonId: $seasonId, ')
          ..write('grapeVarietyId: $grapeVarietyId, ')
          ..write('quantity: $quantity, ')
          ..write('unitId: $unitId, ')
          ..write('conversionFactorKg: $conversionFactorKg, ')
          ..write('estimatedKg: $estimatedKg, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FarmersTable farmers = $FarmersTable(this);
  late final $ParcelsTable parcels = $ParcelsTable(this);
  late final $ParcelOwnersTable parcelOwners = $ParcelOwnersTable(this);
  late final $ParcelVerticesTable parcelVertices = $ParcelVerticesTable(this);
  late final $VertexPhotosTable vertexPhotos = $VertexPhotosTable(this);
  late final $GrapeVarietiesTable grapeVarieties = $GrapeVarietiesTable(this);
  late final $ParcelVarietiesTable parcelVarieties = $ParcelVarietiesTable(
    this,
  );
  late final $HarvestSeasonsTable harvestSeasons = $HarvestSeasonsTable(this);
  late final $MeasurementUnitsTable measurementUnits = $MeasurementUnitsTable(
    this,
  );
  late final $ProductionEstimatesTable productionEstimates =
      $ProductionEstimatesTable(this);
  late final Index idxFarmersName = Index(
    'idx_farmers_name',
    'CREATE INDEX idx_farmers_name ON farmers (last_name, first_name)',
  );
  late final Index idxFarmersDocument = Index(
    'idx_farmers_document',
    'CREATE INDEX idx_farmers_document ON farmers (document_number)',
  );
  late final Index idxFarmersCode = Index(
    'idx_farmers_code',
    'CREATE INDEX idx_farmers_code ON farmers (code)',
  );
  late final Index idxParcelsStatus = Index(
    'idx_parcels_status',
    'CREATE INDEX idx_parcels_status ON parcels (status)',
  );
  late final Index idxParcelOwnersFarmer = Index(
    'idx_parcel_owners_farmer',
    'CREATE INDEX idx_parcel_owners_farmer ON parcel_owners (farmer_id)',
  );
  late final Index idxVertexPhotosVertex = Index(
    'idx_vertex_photos_vertex',
    'CREATE INDEX idx_vertex_photos_vertex ON vertex_photos (vertex_id)',
  );
  late final Index idxGrapeVarietiesActive = Index(
    'idx_grape_varieties_active',
    'CREATE INDEX idx_grape_varieties_active ON grape_varieties (active)',
  );
  late final Index idxParcelVarietiesVariety = Index(
    'idx_parcel_varieties_variety',
    'CREATE INDEX idx_parcel_varieties_variety ON parcel_varieties (grape_variety_id)',
  );
  late final Index idxProductionParcelSeason = Index(
    'idx_production_parcel_season',
    'CREATE INDEX idx_production_parcel_season ON production_estimates (parcel_id, season_id)',
  );
  late final Index idxProductionSeason = Index(
    'idx_production_season',
    'CREATE INDEX idx_production_season ON production_estimates (season_id)',
  );
  late final Index idxProductionVariety = Index(
    'idx_production_variety',
    'CREATE INDEX idx_production_variety ON production_estimates (grape_variety_id)',
  );
  late final Index idxProductionUnit = Index(
    'idx_production_unit',
    'CREATE INDEX idx_production_unit ON production_estimates (unit_id)',
  );
  late final FarmerDao farmerDao = FarmerDao(this as AppDatabase);
  late final ParcelDao parcelDao = ParcelDao(this as AppDatabase);
  late final ParcelOwnerDao parcelOwnerDao = ParcelOwnerDao(
    this as AppDatabase,
  );
  late final ParcelVertexDao parcelVertexDao = ParcelVertexDao(
    this as AppDatabase,
  );
  late final VertexPhotoDao vertexPhotoDao = VertexPhotoDao(
    this as AppDatabase,
  );
  late final GrapeVarietyDao grapeVarietyDao = GrapeVarietyDao(
    this as AppDatabase,
  );
  late final ParcelVarietyDao parcelVarietyDao = ParcelVarietyDao(
    this as AppDatabase,
  );
  late final HarvestSeasonDao harvestSeasonDao = HarvestSeasonDao(
    this as AppDatabase,
  );
  late final MeasurementUnitDao measurementUnitDao = MeasurementUnitDao(
    this as AppDatabase,
  );
  late final ProductionEstimateDao productionEstimateDao =
      ProductionEstimateDao(this as AppDatabase);
  late final ExportDao exportDao = ExportDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    farmers,
    parcels,
    parcelOwners,
    parcelVertices,
    vertexPhotos,
    grapeVarieties,
    parcelVarieties,
    harvestSeasons,
    measurementUnits,
    productionEstimates,
    idxFarmersName,
    idxFarmersDocument,
    idxFarmersCode,
    idxParcelsStatus,
    idxParcelOwnersFarmer,
    idxVertexPhotosVertex,
    idxGrapeVarietiesActive,
    idxParcelVarietiesVariety,
    idxProductionParcelSeason,
    idxProductionSeason,
    idxProductionVariety,
    idxProductionUnit,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'parcels',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('parcel_owners', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'parcels',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('parcel_vertices', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'parcel_vertices',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('vertex_photos', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'parcels',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('parcel_varieties', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'parcels',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('production_estimates', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$FarmersTableCreateCompanionBuilder = FarmersCompanion Function({
  required String id,
  Value<String?> code,
  required String firstName,
  required String lastName,
  Value<String?> documentNumber,
  Value<String?> phone,
  Value<String?> email,
  Value<String?> locality,
  Value<String?> address,
  Value<String?> notes,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$FarmersTableUpdateCompanionBuilder = FarmersCompanion Function({
  Value<String> id,
  Value<String?> code,
  Value<String> firstName,
  Value<String> lastName,
  Value<String?> documentNumber,
  Value<String?> phone,
  Value<String?> email,
  Value<String?> locality,
  Value<String?> address,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$FarmersTableReferences
    extends BaseReferences<_$AppDatabase, $FarmersTable, FarmerRow> {
  $$FarmersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ParcelOwnersTable, List<ParcelOwnerRow>>
  _parcelOwnersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.parcelOwners,
    aliasName: 'farmers__id__parcel_owners__farmer_id',
  );

  $$ParcelOwnersTableProcessedTableManager get parcelOwnersRefs {
    final manager = $$ParcelOwnersTableTableManager(
      $_db,
      $_db.parcelOwners,
    ).filter((f) => f.farmerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_parcelOwnersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FarmersTableFilterComposer
    extends Composer<_$AppDatabase, $FarmersTable> {
  $$FarmersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get documentNumber => $composableBuilder(
    column: $table.documentNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locality => $composableBuilder(
    column: $table.locality,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> parcelOwnersRefs(
    Expression<bool> Function($$ParcelOwnersTableFilterComposer f) f,
  ) {
    final $$ParcelOwnersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.parcelOwners,
      getReferencedColumn: (t) => t.farmerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParcelOwnersTableFilterComposer(
            $db: $db,
            $table: $db.parcelOwners,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FarmersTableOrderingComposer
    extends Composer<_$AppDatabase, $FarmersTable> {
  $$FarmersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get documentNumber => $composableBuilder(
    column: $table.documentNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locality => $composableBuilder(
    column: $table.locality,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FarmersTableAnnotationComposer
    extends Composer<_$AppDatabase, $FarmersTable> {
  $$FarmersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get documentNumber => $composableBuilder(
    column: $table.documentNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get locality =>
      $composableBuilder(column: $table.locality, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> parcelOwnersRefs<T extends Object>(
    Expression<T> Function($$ParcelOwnersTableAnnotationComposer a) f,
  ) {
    final $$ParcelOwnersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.parcelOwners,
      getReferencedColumn: (t) => t.farmerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParcelOwnersTableAnnotationComposer(
            $db: $db,
            $table: $db.parcelOwners,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FarmersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FarmersTable,
          FarmerRow,
          $$FarmersTableFilterComposer,
          $$FarmersTableOrderingComposer,
          $$FarmersTableAnnotationComposer,
          $$FarmersTableCreateCompanionBuilder,
          $$FarmersTableUpdateCompanionBuilder,
          (FarmerRow, $$FarmersTableReferences),
          FarmerRow,
          PrefetchHooks Function({bool parcelOwnersRefs})
        > {
  $$FarmersTableTableManager(_$AppDatabase db, $FarmersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FarmersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FarmersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FarmersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> code = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<String?> documentNumber = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> locality = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FarmersCompanion(
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
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> code = const Value.absent(),
                required String firstName,
                required String lastName,
                Value<String?> documentNumber = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> locality = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => FarmersCompanion.insert(
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
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FarmersTable, FarmerRow>(table),
                  $$FarmersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({parcelOwnersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (parcelOwnersRefs) db.parcelOwners],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (parcelOwnersRefs)
                    await $_getPrefetchedDataByColumns<
                      FarmerRow,
                      $FarmersTable,
                      ParcelOwnerRow,
                      $ParcelOwnersTable
                    >(
                      currentTable: table,
                      referencedTable: $$FarmersTableReferences
                          ._parcelOwnersRefsTable(db),
                      managerFromTypedResult: (p0) => $$FarmersTableReferences(
                        db,
                        table,
                        p0,
                      ).parcelOwnersRefs,
                      currentColumn: 'id',
                      referencedColumn: 'farmer_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$FarmersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FarmersTable,
      FarmerRow,
      $$FarmersTableFilterComposer,
      $$FarmersTableOrderingComposer,
      $$FarmersTableAnnotationComposer,
      $$FarmersTableCreateCompanionBuilder,
      $$FarmersTableUpdateCompanionBuilder,
      (FarmerRow, $$FarmersTableReferences),
      FarmerRow,
      PrefetchHooks Function({bool parcelOwnersRefs})
    >;
typedef $$ParcelsTableCreateCompanionBuilder = ParcelsCompanion Function({
  required String id,
  required String code,
  Value<String?> name,
  Value<double?> declaredAreaM2,
  Value<double?> calculatedAreaM2,
  required ParcelStatus status,
  Value<String?> imagePath,
  Value<String?> notes,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$ParcelsTableUpdateCompanionBuilder = ParcelsCompanion Function({
  Value<String> id,
  Value<String> code,
  Value<String?> name,
  Value<double?> declaredAreaM2,
  Value<double?> calculatedAreaM2,
  Value<ParcelStatus> status,
  Value<String?> imagePath,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$ParcelsTableReferences
    extends BaseReferences<_$AppDatabase, $ParcelsTable, ParcelRow> {
  $$ParcelsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ParcelOwnersTable, List<ParcelOwnerRow>>
  _parcelOwnersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.parcelOwners,
    aliasName: 'parcels__id__parcel_owners__parcel_id',
  );

  $$ParcelOwnersTableProcessedTableManager get parcelOwnersRefs {
    final manager = $$ParcelOwnersTableTableManager(
      $_db,
      $_db.parcelOwners,
    ).filter((f) => f.parcelId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_parcelOwnersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ParcelVerticesTable, List<ParcelVertexRow>>
  _parcelVerticesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.parcelVertices,
    aliasName: 'parcels__id__parcel_vertices__parcel_id',
  );

  $$ParcelVerticesTableProcessedTableManager get parcelVerticesRefs {
    final manager = $$ParcelVerticesTableTableManager(
      $_db,
      $_db.parcelVertices,
    ).filter((f) => f.parcelId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_parcelVerticesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ParcelVarietiesTable, List<ParcelVarietyRow>>
  _parcelVarietiesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.parcelVarieties,
    aliasName: 'parcels__id__parcel_varieties__parcel_id',
  );

  $$ParcelVarietiesTableProcessedTableManager get parcelVarietiesRefs {
    final manager = $$ParcelVarietiesTableTableManager(
      $_db,
      $_db.parcelVarieties,
    ).filter((f) => f.parcelId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _parcelVarietiesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ProductionEstimatesTable,
    List<ProductionEstimateRow>
  >
  _productionEstimatesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.productionEstimates,
        aliasName: 'parcels__id__production_estimates__parcel_id',
      );

  $$ProductionEstimatesTableProcessedTableManager get productionEstimatesRefs {
    final manager = $$ProductionEstimatesTableTableManager(
      $_db,
      $_db.productionEstimates,
    ).filter((f) => f.parcelId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _productionEstimatesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ParcelsTableFilterComposer
    extends Composer<_$AppDatabase, $ParcelsTable> {
  $$ParcelsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get declaredAreaM2 => $composableBuilder(
    column: $table.declaredAreaM2,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get calculatedAreaM2 => $composableBuilder(
    column: $table.calculatedAreaM2,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ParcelStatus, ParcelStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> parcelOwnersRefs(
    Expression<bool> Function($$ParcelOwnersTableFilterComposer f) f,
  ) {
    final $$ParcelOwnersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.parcelOwners,
      getReferencedColumn: (t) => t.parcelId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParcelOwnersTableFilterComposer(
            $db: $db,
            $table: $db.parcelOwners,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> parcelVerticesRefs(
    Expression<bool> Function($$ParcelVerticesTableFilterComposer f) f,
  ) {
    final $$ParcelVerticesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.parcelVertices,
      getReferencedColumn: (t) => t.parcelId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParcelVerticesTableFilterComposer(
            $db: $db,
            $table: $db.parcelVertices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> parcelVarietiesRefs(
    Expression<bool> Function($$ParcelVarietiesTableFilterComposer f) f,
  ) {
    final $$ParcelVarietiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.parcelVarieties,
      getReferencedColumn: (t) => t.parcelId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParcelVarietiesTableFilterComposer(
            $db: $db,
            $table: $db.parcelVarieties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> productionEstimatesRefs(
    Expression<bool> Function($$ProductionEstimatesTableFilterComposer f) f,
  ) {
    final $$ProductionEstimatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productionEstimates,
      getReferencedColumn: (t) => t.parcelId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductionEstimatesTableFilterComposer(
            $db: $db,
            $table: $db.productionEstimates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ParcelsTableOrderingComposer
    extends Composer<_$AppDatabase, $ParcelsTable> {
  $$ParcelsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get declaredAreaM2 => $composableBuilder(
    column: $table.declaredAreaM2,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get calculatedAreaM2 => $composableBuilder(
    column: $table.calculatedAreaM2,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ParcelsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ParcelsTable> {
  $$ParcelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get declaredAreaM2 => $composableBuilder(
    column: $table.declaredAreaM2,
    builder: (column) => column,
  );

  GeneratedColumn<double> get calculatedAreaM2 => $composableBuilder(
    column: $table.calculatedAreaM2,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<ParcelStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> parcelOwnersRefs<T extends Object>(
    Expression<T> Function($$ParcelOwnersTableAnnotationComposer a) f,
  ) {
    final $$ParcelOwnersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.parcelOwners,
      getReferencedColumn: (t) => t.parcelId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParcelOwnersTableAnnotationComposer(
            $db: $db,
            $table: $db.parcelOwners,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> parcelVerticesRefs<T extends Object>(
    Expression<T> Function($$ParcelVerticesTableAnnotationComposer a) f,
  ) {
    final $$ParcelVerticesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.parcelVertices,
      getReferencedColumn: (t) => t.parcelId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParcelVerticesTableAnnotationComposer(
            $db: $db,
            $table: $db.parcelVertices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> parcelVarietiesRefs<T extends Object>(
    Expression<T> Function($$ParcelVarietiesTableAnnotationComposer a) f,
  ) {
    final $$ParcelVarietiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.parcelVarieties,
      getReferencedColumn: (t) => t.parcelId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParcelVarietiesTableAnnotationComposer(
            $db: $db,
            $table: $db.parcelVarieties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> productionEstimatesRefs<T extends Object>(
    Expression<T> Function($$ProductionEstimatesTableAnnotationComposer a) f,
  ) {
    final $$ProductionEstimatesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.productionEstimates,
          getReferencedColumn: (t) => t.parcelId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ProductionEstimatesTableAnnotationComposer(
                $db: $db,
                $table: $db.productionEstimates,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ParcelsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ParcelsTable,
          ParcelRow,
          $$ParcelsTableFilterComposer,
          $$ParcelsTableOrderingComposer,
          $$ParcelsTableAnnotationComposer,
          $$ParcelsTableCreateCompanionBuilder,
          $$ParcelsTableUpdateCompanionBuilder,
          (ParcelRow, $$ParcelsTableReferences),
          ParcelRow,
          PrefetchHooks Function({
            bool parcelOwnersRefs,
            bool parcelVerticesRefs,
            bool parcelVarietiesRefs,
            bool productionEstimatesRefs,
          })
        > {
  $$ParcelsTableTableManager(_$AppDatabase db, $ParcelsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ParcelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ParcelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ParcelsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<double?> declaredAreaM2 = const Value.absent(),
                Value<double?> calculatedAreaM2 = const Value.absent(),
                Value<ParcelStatus> status = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ParcelsCompanion(
                id: id,
                code: code,
                name: name,
                declaredAreaM2: declaredAreaM2,
                calculatedAreaM2: calculatedAreaM2,
                status: status,
                imagePath: imagePath,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String code,
                Value<String?> name = const Value.absent(),
                Value<double?> declaredAreaM2 = const Value.absent(),
                Value<double?> calculatedAreaM2 = const Value.absent(),
                required ParcelStatus status,
                Value<String?> imagePath = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ParcelsCompanion.insert(
                id: id,
                code: code,
                name: name,
                declaredAreaM2: declaredAreaM2,
                calculatedAreaM2: calculatedAreaM2,
                status: status,
                imagePath: imagePath,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ParcelsTable, ParcelRow>(table),
                  $$ParcelsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                parcelOwnersRefs = false,
                parcelVerticesRefs = false,
                parcelVarietiesRefs = false,
                productionEstimatesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (parcelOwnersRefs) db.parcelOwners,
                    if (parcelVerticesRefs) db.parcelVertices,
                    if (parcelVarietiesRefs) db.parcelVarieties,
                    if (productionEstimatesRefs) db.productionEstimates,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (parcelOwnersRefs)
                        await $_getPrefetchedDataByColumns<
                          ParcelRow,
                          $ParcelsTable,
                          ParcelOwnerRow,
                          $ParcelOwnersTable
                        >(
                          currentTable: table,
                          referencedTable: $$ParcelsTableReferences
                              ._parcelOwnersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ParcelsTableReferences(
                                db,
                                table,
                                p0,
                              ).parcelOwnersRefs,
                          currentColumn: 'id',
                          referencedColumn: 'parcel_id',
                          typedResults: items,
                        ),
                      if (parcelVerticesRefs)
                        await $_getPrefetchedDataByColumns<
                          ParcelRow,
                          $ParcelsTable,
                          ParcelVertexRow,
                          $ParcelVerticesTable
                        >(
                          currentTable: table,
                          referencedTable: $$ParcelsTableReferences
                              ._parcelVerticesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ParcelsTableReferences(
                                db,
                                table,
                                p0,
                              ).parcelVerticesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'parcel_id',
                          typedResults: items,
                        ),
                      if (parcelVarietiesRefs)
                        await $_getPrefetchedDataByColumns<
                          ParcelRow,
                          $ParcelsTable,
                          ParcelVarietyRow,
                          $ParcelVarietiesTable
                        >(
                          currentTable: table,
                          referencedTable: $$ParcelsTableReferences
                              ._parcelVarietiesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ParcelsTableReferences(
                                db,
                                table,
                                p0,
                              ).parcelVarietiesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'parcel_id',
                          typedResults: items,
                        ),
                      if (productionEstimatesRefs)
                        await $_getPrefetchedDataByColumns<
                          ParcelRow,
                          $ParcelsTable,
                          ProductionEstimateRow,
                          $ProductionEstimatesTable
                        >(
                          currentTable: table,
                          referencedTable: $$ParcelsTableReferences
                              ._productionEstimatesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ParcelsTableReferences(
                                db,
                                table,
                                p0,
                              ).productionEstimatesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'parcel_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ParcelsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ParcelsTable,
      ParcelRow,
      $$ParcelsTableFilterComposer,
      $$ParcelsTableOrderingComposer,
      $$ParcelsTableAnnotationComposer,
      $$ParcelsTableCreateCompanionBuilder,
      $$ParcelsTableUpdateCompanionBuilder,
      (ParcelRow, $$ParcelsTableReferences),
      ParcelRow,
      PrefetchHooks Function({
        bool parcelOwnersRefs,
        bool parcelVerticesRefs,
        bool parcelVarietiesRefs,
        bool productionEstimatesRefs,
      })
    >;
typedef $$ParcelOwnersTableCreateCompanionBuilder =
    ParcelOwnersCompanion Function({
      required String id,
      required String parcelId,
      required String farmerId,
      Value<double?> ownershipPercentage,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ParcelOwnersTableUpdateCompanionBuilder =
    ParcelOwnersCompanion Function({
      Value<String> id,
      Value<String> parcelId,
      Value<String> farmerId,
      Value<double?> ownershipPercentage,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$ParcelOwnersTableReferences
    extends BaseReferences<_$AppDatabase, $ParcelOwnersTable, ParcelOwnerRow> {
  $$ParcelOwnersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ParcelsTable _parcelIdTable(_$AppDatabase db) =>
      db.parcels.createAlias('parcel_owners__parcel_id__parcels__id');

  $$ParcelsTableProcessedTableManager get parcelId {
    final $_column = $_itemColumn<String>('parcel_id')!;

    final manager = $$ParcelsTableTableManager(
      $_db,
      $_db.parcels,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parcelIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FarmersTable _farmerIdTable(_$AppDatabase db) =>
      db.farmers.createAlias('parcel_owners__farmer_id__farmers__id');

  $$FarmersTableProcessedTableManager get farmerId {
    final $_column = $_itemColumn<String>('farmer_id')!;

    final manager = $$FarmersTableTableManager(
      $_db,
      $_db.farmers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_farmerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ParcelOwnersTableFilterComposer
    extends Composer<_$AppDatabase, $ParcelOwnersTable> {
  $$ParcelOwnersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ownershipPercentage => $composableBuilder(
    column: $table.ownershipPercentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ParcelsTableFilterComposer get parcelId {
    final $$ParcelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parcelId,
      referencedTable: $db.parcels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParcelsTableFilterComposer(
            $db: $db,
            $table: $db.parcels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FarmersTableFilterComposer get farmerId {
    final $$FarmersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.farmerId,
      referencedTable: $db.farmers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FarmersTableFilterComposer(
            $db: $db,
            $table: $db.farmers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ParcelOwnersTableOrderingComposer
    extends Composer<_$AppDatabase, $ParcelOwnersTable> {
  $$ParcelOwnersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ownershipPercentage => $composableBuilder(
    column: $table.ownershipPercentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ParcelsTableOrderingComposer get parcelId {
    final $$ParcelsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parcelId,
      referencedTable: $db.parcels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParcelsTableOrderingComposer(
            $db: $db,
            $table: $db.parcels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FarmersTableOrderingComposer get farmerId {
    final $$FarmersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.farmerId,
      referencedTable: $db.farmers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FarmersTableOrderingComposer(
            $db: $db,
            $table: $db.farmers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ParcelOwnersTableAnnotationComposer
    extends Composer<_$AppDatabase, $ParcelOwnersTable> {
  $$ParcelOwnersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get ownershipPercentage => $composableBuilder(
    column: $table.ownershipPercentage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ParcelsTableAnnotationComposer get parcelId {
    final $$ParcelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parcelId,
      referencedTable: $db.parcels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParcelsTableAnnotationComposer(
            $db: $db,
            $table: $db.parcels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FarmersTableAnnotationComposer get farmerId {
    final $$FarmersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.farmerId,
      referencedTable: $db.farmers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FarmersTableAnnotationComposer(
            $db: $db,
            $table: $db.farmers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ParcelOwnersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ParcelOwnersTable,
          ParcelOwnerRow,
          $$ParcelOwnersTableFilterComposer,
          $$ParcelOwnersTableOrderingComposer,
          $$ParcelOwnersTableAnnotationComposer,
          $$ParcelOwnersTableCreateCompanionBuilder,
          $$ParcelOwnersTableUpdateCompanionBuilder,
          (ParcelOwnerRow, $$ParcelOwnersTableReferences),
          ParcelOwnerRow,
          PrefetchHooks Function({bool parcelId, bool farmerId})
        > {
  $$ParcelOwnersTableTableManager(_$AppDatabase db, $ParcelOwnersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ParcelOwnersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ParcelOwnersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ParcelOwnersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> parcelId = const Value.absent(),
                Value<String> farmerId = const Value.absent(),
                Value<double?> ownershipPercentage = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ParcelOwnersCompanion(
                id: id,
                parcelId: parcelId,
                farmerId: farmerId,
                ownershipPercentage: ownershipPercentage,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String parcelId,
                required String farmerId,
                Value<double?> ownershipPercentage = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ParcelOwnersCompanion.insert(
                id: id,
                parcelId: parcelId,
                farmerId: farmerId,
                ownershipPercentage: ownershipPercentage,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ParcelOwnersTable, ParcelOwnerRow>(table),
                  $$ParcelOwnersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({parcelId = false, farmerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (parcelId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.parcelId,
                        referencedTable: $$ParcelOwnersTableReferences
                            ._parcelIdTable(db),
                        referencedColumn: $$ParcelOwnersTableReferences
                            ._parcelIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (farmerId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.farmerId,
                        referencedTable: $$ParcelOwnersTableReferences
                            ._farmerIdTable(db),
                        referencedColumn: $$ParcelOwnersTableReferences
                            ._farmerIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ParcelOwnersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ParcelOwnersTable,
      ParcelOwnerRow,
      $$ParcelOwnersTableFilterComposer,
      $$ParcelOwnersTableOrderingComposer,
      $$ParcelOwnersTableAnnotationComposer,
      $$ParcelOwnersTableCreateCompanionBuilder,
      $$ParcelOwnersTableUpdateCompanionBuilder,
      (ParcelOwnerRow, $$ParcelOwnersTableReferences),
      ParcelOwnerRow,
      PrefetchHooks Function({bool parcelId, bool farmerId})
    >;
typedef $$ParcelVerticesTableCreateCompanionBuilder =
    ParcelVerticesCompanion Function({
      required String id,
      required String parcelId,
      required int sequenceNumber,
      required double latitude,
      required double longitude,
      Value<double?> accuracyM,
      required VertexCaptureMethod captureMethod,
      Value<DateTime?> capturedAt,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ParcelVerticesTableUpdateCompanionBuilder =
    ParcelVerticesCompanion Function({
      Value<String> id,
      Value<String> parcelId,
      Value<int> sequenceNumber,
      Value<double> latitude,
      Value<double> longitude,
      Value<double?> accuracyM,
      Value<VertexCaptureMethod> captureMethod,
      Value<DateTime?> capturedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$ParcelVerticesTableReferences
    extends
        BaseReferences<_$AppDatabase, $ParcelVerticesTable, ParcelVertexRow> {
  $$ParcelVerticesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ParcelsTable _parcelIdTable(_$AppDatabase db) =>
      db.parcels.createAlias('parcel_vertices__parcel_id__parcels__id');

  $$ParcelsTableProcessedTableManager get parcelId {
    final $_column = $_itemColumn<String>('parcel_id')!;

    final manager = $$ParcelsTableTableManager(
      $_db,
      $_db.parcels,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parcelIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$VertexPhotosTable, List<VertexPhotoRow>>
  _vertexPhotosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.vertexPhotos,
    aliasName: 'parcel_vertices__id__vertex_photos__vertex_id',
  );

  $$VertexPhotosTableProcessedTableManager get vertexPhotosRefs {
    final manager = $$VertexPhotosTableTableManager(
      $_db,
      $_db.vertexPhotos,
    ).filter((f) => f.vertexId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_vertexPhotosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ParcelVerticesTableFilterComposer
    extends Composer<_$AppDatabase, $ParcelVerticesTable> {
  $$ParcelVerticesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sequenceNumber => $composableBuilder(
    column: $table.sequenceNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get accuracyM => $composableBuilder(
    column: $table.accuracyM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    VertexCaptureMethod,
    VertexCaptureMethod,
    String
  >
  get captureMethod => $composableBuilder(
    column: $table.captureMethod,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get capturedAt => $composableBuilder(
    column: $table.capturedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ParcelsTableFilterComposer get parcelId {
    final $$ParcelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parcelId,
      referencedTable: $db.parcels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParcelsTableFilterComposer(
            $db: $db,
            $table: $db.parcels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> vertexPhotosRefs(
    Expression<bool> Function($$VertexPhotosTableFilterComposer f) f,
  ) {
    final $$VertexPhotosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vertexPhotos,
      getReferencedColumn: (t) => t.vertexId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VertexPhotosTableFilterComposer(
            $db: $db,
            $table: $db.vertexPhotos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ParcelVerticesTableOrderingComposer
    extends Composer<_$AppDatabase, $ParcelVerticesTable> {
  $$ParcelVerticesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sequenceNumber => $composableBuilder(
    column: $table.sequenceNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get accuracyM => $composableBuilder(
    column: $table.accuracyM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get captureMethod => $composableBuilder(
    column: $table.captureMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get capturedAt => $composableBuilder(
    column: $table.capturedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ParcelsTableOrderingComposer get parcelId {
    final $$ParcelsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parcelId,
      referencedTable: $db.parcels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParcelsTableOrderingComposer(
            $db: $db,
            $table: $db.parcels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ParcelVerticesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ParcelVerticesTable> {
  $$ParcelVerticesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sequenceNumber => $composableBuilder(
    column: $table.sequenceNumber,
    builder: (column) => column,
  );

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<double> get accuracyM =>
      $composableBuilder(column: $table.accuracyM, builder: (column) => column);

  GeneratedColumnWithTypeConverter<VertexCaptureMethod, String>
  get captureMethod => $composableBuilder(
    column: $table.captureMethod,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get capturedAt => $composableBuilder(
    column: $table.capturedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ParcelsTableAnnotationComposer get parcelId {
    final $$ParcelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parcelId,
      referencedTable: $db.parcels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParcelsTableAnnotationComposer(
            $db: $db,
            $table: $db.parcels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> vertexPhotosRefs<T extends Object>(
    Expression<T> Function($$VertexPhotosTableAnnotationComposer a) f,
  ) {
    final $$VertexPhotosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vertexPhotos,
      getReferencedColumn: (t) => t.vertexId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VertexPhotosTableAnnotationComposer(
            $db: $db,
            $table: $db.vertexPhotos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ParcelVerticesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ParcelVerticesTable,
          ParcelVertexRow,
          $$ParcelVerticesTableFilterComposer,
          $$ParcelVerticesTableOrderingComposer,
          $$ParcelVerticesTableAnnotationComposer,
          $$ParcelVerticesTableCreateCompanionBuilder,
          $$ParcelVerticesTableUpdateCompanionBuilder,
          (ParcelVertexRow, $$ParcelVerticesTableReferences),
          ParcelVertexRow,
          PrefetchHooks Function({bool parcelId, bool vertexPhotosRefs})
        > {
  $$ParcelVerticesTableTableManager(
    _$AppDatabase db,
    $ParcelVerticesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ParcelVerticesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ParcelVerticesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ParcelVerticesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> parcelId = const Value.absent(),
                Value<int> sequenceNumber = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<double?> accuracyM = const Value.absent(),
                Value<VertexCaptureMethod> captureMethod = const Value.absent(),
                Value<DateTime?> capturedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ParcelVerticesCompanion(
                id: id,
                parcelId: parcelId,
                sequenceNumber: sequenceNumber,
                latitude: latitude,
                longitude: longitude,
                accuracyM: accuracyM,
                captureMethod: captureMethod,
                capturedAt: capturedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String parcelId,
                required int sequenceNumber,
                required double latitude,
                required double longitude,
                Value<double?> accuracyM = const Value.absent(),
                required VertexCaptureMethod captureMethod,
                Value<DateTime?> capturedAt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ParcelVerticesCompanion.insert(
                id: id,
                parcelId: parcelId,
                sequenceNumber: sequenceNumber,
                latitude: latitude,
                longitude: longitude,
                accuracyM: accuracyM,
                captureMethod: captureMethod,
                capturedAt: capturedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ParcelVerticesTable, ParcelVertexRow>(table),
                  $$ParcelVerticesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({parcelId = false, vertexPhotosRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (vertexPhotosRefs) db.vertexPhotos,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (parcelId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.parcelId,
                            referencedTable: $$ParcelVerticesTableReferences
                                ._parcelIdTable(db),
                            referencedColumn: $$ParcelVerticesTableReferences
                                ._parcelIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (vertexPhotosRefs)
                        await $_getPrefetchedDataByColumns<
                          ParcelVertexRow,
                          $ParcelVerticesTable,
                          VertexPhotoRow,
                          $VertexPhotosTable
                        >(
                          currentTable: table,
                          referencedTable: $$ParcelVerticesTableReferences
                              ._vertexPhotosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ParcelVerticesTableReferences(
                                db,
                                table,
                                p0,
                              ).vertexPhotosRefs,
                          currentColumn: 'id',
                          referencedColumn: 'vertex_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ParcelVerticesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ParcelVerticesTable,
      ParcelVertexRow,
      $$ParcelVerticesTableFilterComposer,
      $$ParcelVerticesTableOrderingComposer,
      $$ParcelVerticesTableAnnotationComposer,
      $$ParcelVerticesTableCreateCompanionBuilder,
      $$ParcelVerticesTableUpdateCompanionBuilder,
      (ParcelVertexRow, $$ParcelVerticesTableReferences),
      ParcelVertexRow,
      PrefetchHooks Function({bool parcelId, bool vertexPhotosRefs})
    >;
typedef $$VertexPhotosTableCreateCompanionBuilder =
    VertexPhotosCompanion Function({
      required String id,
      required String vertexId,
      required String relativePath,
      required String fileName,
      Value<String?> description,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$VertexPhotosTableUpdateCompanionBuilder =
    VertexPhotosCompanion Function({
      Value<String> id,
      Value<String> vertexId,
      Value<String> relativePath,
      Value<String> fileName,
      Value<String?> description,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$VertexPhotosTableReferences
    extends BaseReferences<_$AppDatabase, $VertexPhotosTable, VertexPhotoRow> {
  $$VertexPhotosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ParcelVerticesTable _vertexIdTable(_$AppDatabase db) => db
      .parcelVertices
      .createAlias('vertex_photos__vertex_id__parcel_vertices__id');

  $$ParcelVerticesTableProcessedTableManager get vertexId {
    final $_column = $_itemColumn<String>('vertex_id')!;

    final manager = $$ParcelVerticesTableTableManager(
      $_db,
      $_db.parcelVertices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vertexIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VertexPhotosTableFilterComposer
    extends Composer<_$AppDatabase, $VertexPhotosTable> {
  $$VertexPhotosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ParcelVerticesTableFilterComposer get vertexId {
    final $$ParcelVerticesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vertexId,
      referencedTable: $db.parcelVertices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParcelVerticesTableFilterComposer(
            $db: $db,
            $table: $db.parcelVertices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VertexPhotosTableOrderingComposer
    extends Composer<_$AppDatabase, $VertexPhotosTable> {
  $$VertexPhotosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ParcelVerticesTableOrderingComposer get vertexId {
    final $$ParcelVerticesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vertexId,
      referencedTable: $db.parcelVertices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParcelVerticesTableOrderingComposer(
            $db: $db,
            $table: $db.parcelVertices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VertexPhotosTableAnnotationComposer
    extends Composer<_$AppDatabase, $VertexPhotosTable> {
  $$VertexPhotosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ParcelVerticesTableAnnotationComposer get vertexId {
    final $$ParcelVerticesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vertexId,
      referencedTable: $db.parcelVertices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParcelVerticesTableAnnotationComposer(
            $db: $db,
            $table: $db.parcelVertices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VertexPhotosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VertexPhotosTable,
          VertexPhotoRow,
          $$VertexPhotosTableFilterComposer,
          $$VertexPhotosTableOrderingComposer,
          $$VertexPhotosTableAnnotationComposer,
          $$VertexPhotosTableCreateCompanionBuilder,
          $$VertexPhotosTableUpdateCompanionBuilder,
          (VertexPhotoRow, $$VertexPhotosTableReferences),
          VertexPhotoRow,
          PrefetchHooks Function({bool vertexId})
        > {
  $$VertexPhotosTableTableManager(_$AppDatabase db, $VertexPhotosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VertexPhotosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VertexPhotosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VertexPhotosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> vertexId = const Value.absent(),
                Value<String> relativePath = const Value.absent(),
                Value<String> fileName = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VertexPhotosCompanion(
                id: id,
                vertexId: vertexId,
                relativePath: relativePath,
                fileName: fileName,
                description: description,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String vertexId,
                required String relativePath,
                required String fileName,
                Value<String?> description = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => VertexPhotosCompanion.insert(
                id: id,
                vertexId: vertexId,
                relativePath: relativePath,
                fileName: fileName,
                description: description,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$VertexPhotosTable, VertexPhotoRow>(table),
                  $$VertexPhotosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vertexId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vertexId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.vertexId,
                        referencedTable: $$VertexPhotosTableReferences
                            ._vertexIdTable(db),
                        referencedColumn: $$VertexPhotosTableReferences
                            ._vertexIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$VertexPhotosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VertexPhotosTable,
      VertexPhotoRow,
      $$VertexPhotosTableFilterComposer,
      $$VertexPhotosTableOrderingComposer,
      $$VertexPhotosTableAnnotationComposer,
      $$VertexPhotosTableCreateCompanionBuilder,
      $$VertexPhotosTableUpdateCompanionBuilder,
      (VertexPhotoRow, $$VertexPhotosTableReferences),
      VertexPhotoRow,
      PrefetchHooks Function({bool vertexId})
    >;
typedef $$GrapeVarietiesTableCreateCompanionBuilder =
    GrapeVarietiesCompanion Function({
      required String id,
      Value<String?> code,
      required String name,
      Value<String?> category,
      Value<String?> description,
      Value<String?> aliases,
      Value<bool> active,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$GrapeVarietiesTableUpdateCompanionBuilder =
    GrapeVarietiesCompanion Function({
      Value<String> id,
      Value<String?> code,
      Value<String> name,
      Value<String?> category,
      Value<String?> description,
      Value<String?> aliases,
      Value<bool> active,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$GrapeVarietiesTableReferences
    extends
        BaseReferences<_$AppDatabase, $GrapeVarietiesTable, GrapeVarietyRow> {
  $$GrapeVarietiesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$ParcelVarietiesTable, List<ParcelVarietyRow>>
  _parcelVarietiesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.parcelVarieties,
    aliasName: 'grape_varieties__id__parcel_varieties__grape_variety_id',
  );

  $$ParcelVarietiesTableProcessedTableManager get parcelVarietiesRefs {
    final manager = $$ParcelVarietiesTableTableManager(
      $_db,
      $_db.parcelVarieties,
    ).filter((f) => f.grapeVarietyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _parcelVarietiesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ProductionEstimatesTable,
    List<ProductionEstimateRow>
  >
  _productionEstimatesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.productionEstimates,
        aliasName:
            'grape_varieties__id__production_estimates__grape_variety_id',
      );

  $$ProductionEstimatesTableProcessedTableManager get productionEstimatesRefs {
    final manager = $$ProductionEstimatesTableTableManager(
      $_db,
      $_db.productionEstimates,
    ).filter((f) => f.grapeVarietyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _productionEstimatesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GrapeVarietiesTableFilterComposer
    extends Composer<_$AppDatabase, $GrapeVarietiesTable> {
  $$GrapeVarietiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aliases => $composableBuilder(
    column: $table.aliases,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> parcelVarietiesRefs(
    Expression<bool> Function($$ParcelVarietiesTableFilterComposer f) f,
  ) {
    final $$ParcelVarietiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.parcelVarieties,
      getReferencedColumn: (t) => t.grapeVarietyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParcelVarietiesTableFilterComposer(
            $db: $db,
            $table: $db.parcelVarieties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> productionEstimatesRefs(
    Expression<bool> Function($$ProductionEstimatesTableFilterComposer f) f,
  ) {
    final $$ProductionEstimatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productionEstimates,
      getReferencedColumn: (t) => t.grapeVarietyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductionEstimatesTableFilterComposer(
            $db: $db,
            $table: $db.productionEstimates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GrapeVarietiesTableOrderingComposer
    extends Composer<_$AppDatabase, $GrapeVarietiesTable> {
  $$GrapeVarietiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aliases => $composableBuilder(
    column: $table.aliases,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GrapeVarietiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $GrapeVarietiesTable> {
  $$GrapeVarietiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get aliases =>
      $composableBuilder(column: $table.aliases, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> parcelVarietiesRefs<T extends Object>(
    Expression<T> Function($$ParcelVarietiesTableAnnotationComposer a) f,
  ) {
    final $$ParcelVarietiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.parcelVarieties,
      getReferencedColumn: (t) => t.grapeVarietyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParcelVarietiesTableAnnotationComposer(
            $db: $db,
            $table: $db.parcelVarieties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> productionEstimatesRefs<T extends Object>(
    Expression<T> Function($$ProductionEstimatesTableAnnotationComposer a) f,
  ) {
    final $$ProductionEstimatesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.productionEstimates,
          getReferencedColumn: (t) => t.grapeVarietyId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ProductionEstimatesTableAnnotationComposer(
                $db: $db,
                $table: $db.productionEstimates,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$GrapeVarietiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GrapeVarietiesTable,
          GrapeVarietyRow,
          $$GrapeVarietiesTableFilterComposer,
          $$GrapeVarietiesTableOrderingComposer,
          $$GrapeVarietiesTableAnnotationComposer,
          $$GrapeVarietiesTableCreateCompanionBuilder,
          $$GrapeVarietiesTableUpdateCompanionBuilder,
          (GrapeVarietyRow, $$GrapeVarietiesTableReferences),
          GrapeVarietyRow,
          PrefetchHooks Function({
            bool parcelVarietiesRefs,
            bool productionEstimatesRefs,
          })
        > {
  $$GrapeVarietiesTableTableManager(
    _$AppDatabase db,
    $GrapeVarietiesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GrapeVarietiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GrapeVarietiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GrapeVarietiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> aliases = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GrapeVarietiesCompanion(
                id: id,
                code: code,
                name: name,
                category: category,
                description: description,
                aliases: aliases,
                active: active,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> code = const Value.absent(),
                required String name,
                Value<String?> category = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> aliases = const Value.absent(),
                Value<bool> active = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => GrapeVarietiesCompanion.insert(
                id: id,
                code: code,
                name: name,
                category: category,
                description: description,
                aliases: aliases,
                active: active,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GrapeVarietiesTable, GrapeVarietyRow>(table),
                  $$GrapeVarietiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({parcelVarietiesRefs = false, productionEstimatesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (parcelVarietiesRefs) db.parcelVarieties,
                    if (productionEstimatesRefs) db.productionEstimates,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (parcelVarietiesRefs)
                        await $_getPrefetchedDataByColumns<
                          GrapeVarietyRow,
                          $GrapeVarietiesTable,
                          ParcelVarietyRow,
                          $ParcelVarietiesTable
                        >(
                          currentTable: table,
                          referencedTable: $$GrapeVarietiesTableReferences
                              ._parcelVarietiesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GrapeVarietiesTableReferences(
                                db,
                                table,
                                p0,
                              ).parcelVarietiesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'grape_variety_id',
                          typedResults: items,
                        ),
                      if (productionEstimatesRefs)
                        await $_getPrefetchedDataByColumns<
                          GrapeVarietyRow,
                          $GrapeVarietiesTable,
                          ProductionEstimateRow,
                          $ProductionEstimatesTable
                        >(
                          currentTable: table,
                          referencedTable: $$GrapeVarietiesTableReferences
                              ._productionEstimatesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GrapeVarietiesTableReferences(
                                db,
                                table,
                                p0,
                              ).productionEstimatesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'grape_variety_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$GrapeVarietiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GrapeVarietiesTable,
      GrapeVarietyRow,
      $$GrapeVarietiesTableFilterComposer,
      $$GrapeVarietiesTableOrderingComposer,
      $$GrapeVarietiesTableAnnotationComposer,
      $$GrapeVarietiesTableCreateCompanionBuilder,
      $$GrapeVarietiesTableUpdateCompanionBuilder,
      (GrapeVarietyRow, $$GrapeVarietiesTableReferences),
      GrapeVarietyRow,
      PrefetchHooks Function({
        bool parcelVarietiesRefs,
        bool productionEstimatesRefs,
      })
    >;
typedef $$ParcelVarietiesTableCreateCompanionBuilder =
    ParcelVarietiesCompanion Function({
      required String id,
      required String parcelId,
      required String grapeVarietyId,
      Value<double?> plantedAreaPercentage,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ParcelVarietiesTableUpdateCompanionBuilder =
    ParcelVarietiesCompanion Function({
      Value<String> id,
      Value<String> parcelId,
      Value<String> grapeVarietyId,
      Value<double?> plantedAreaPercentage,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$ParcelVarietiesTableReferences
    extends
        BaseReferences<_$AppDatabase, $ParcelVarietiesTable, ParcelVarietyRow> {
  $$ParcelVarietiesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ParcelsTable _parcelIdTable(_$AppDatabase db) =>
      db.parcels.createAlias('parcel_varieties__parcel_id__parcels__id');

  $$ParcelsTableProcessedTableManager get parcelId {
    final $_column = $_itemColumn<String>('parcel_id')!;

    final manager = $$ParcelsTableTableManager(
      $_db,
      $_db.parcels,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parcelIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $GrapeVarietiesTable _grapeVarietyIdTable(_$AppDatabase db) => db
      .grapeVarieties
      .createAlias('parcel_varieties__grape_variety_id__grape_varieties__id');

  $$GrapeVarietiesTableProcessedTableManager get grapeVarietyId {
    final $_column = $_itemColumn<String>('grape_variety_id')!;

    final manager = $$GrapeVarietiesTableTableManager(
      $_db,
      $_db.grapeVarieties,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_grapeVarietyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ParcelVarietiesTableFilterComposer
    extends Composer<_$AppDatabase, $ParcelVarietiesTable> {
  $$ParcelVarietiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get plantedAreaPercentage => $composableBuilder(
    column: $table.plantedAreaPercentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ParcelsTableFilterComposer get parcelId {
    final $$ParcelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parcelId,
      referencedTable: $db.parcels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParcelsTableFilterComposer(
            $db: $db,
            $table: $db.parcels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GrapeVarietiesTableFilterComposer get grapeVarietyId {
    final $$GrapeVarietiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.grapeVarietyId,
      referencedTable: $db.grapeVarieties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GrapeVarietiesTableFilterComposer(
            $db: $db,
            $table: $db.grapeVarieties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ParcelVarietiesTableOrderingComposer
    extends Composer<_$AppDatabase, $ParcelVarietiesTable> {
  $$ParcelVarietiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get plantedAreaPercentage => $composableBuilder(
    column: $table.plantedAreaPercentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ParcelsTableOrderingComposer get parcelId {
    final $$ParcelsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parcelId,
      referencedTable: $db.parcels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParcelsTableOrderingComposer(
            $db: $db,
            $table: $db.parcels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GrapeVarietiesTableOrderingComposer get grapeVarietyId {
    final $$GrapeVarietiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.grapeVarietyId,
      referencedTable: $db.grapeVarieties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GrapeVarietiesTableOrderingComposer(
            $db: $db,
            $table: $db.grapeVarieties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ParcelVarietiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ParcelVarietiesTable> {
  $$ParcelVarietiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get plantedAreaPercentage => $composableBuilder(
    column: $table.plantedAreaPercentage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ParcelsTableAnnotationComposer get parcelId {
    final $$ParcelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parcelId,
      referencedTable: $db.parcels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParcelsTableAnnotationComposer(
            $db: $db,
            $table: $db.parcels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GrapeVarietiesTableAnnotationComposer get grapeVarietyId {
    final $$GrapeVarietiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.grapeVarietyId,
      referencedTable: $db.grapeVarieties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GrapeVarietiesTableAnnotationComposer(
            $db: $db,
            $table: $db.grapeVarieties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ParcelVarietiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ParcelVarietiesTable,
          ParcelVarietyRow,
          $$ParcelVarietiesTableFilterComposer,
          $$ParcelVarietiesTableOrderingComposer,
          $$ParcelVarietiesTableAnnotationComposer,
          $$ParcelVarietiesTableCreateCompanionBuilder,
          $$ParcelVarietiesTableUpdateCompanionBuilder,
          (ParcelVarietyRow, $$ParcelVarietiesTableReferences),
          ParcelVarietyRow,
          PrefetchHooks Function({bool parcelId, bool grapeVarietyId})
        > {
  $$ParcelVarietiesTableTableManager(
    _$AppDatabase db,
    $ParcelVarietiesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ParcelVarietiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ParcelVarietiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ParcelVarietiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> parcelId = const Value.absent(),
                Value<String> grapeVarietyId = const Value.absent(),
                Value<double?> plantedAreaPercentage = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ParcelVarietiesCompanion(
                id: id,
                parcelId: parcelId,
                grapeVarietyId: grapeVarietyId,
                plantedAreaPercentage: plantedAreaPercentage,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String parcelId,
                required String grapeVarietyId,
                Value<double?> plantedAreaPercentage = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ParcelVarietiesCompanion.insert(
                id: id,
                parcelId: parcelId,
                grapeVarietyId: grapeVarietyId,
                plantedAreaPercentage: plantedAreaPercentage,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ParcelVarietiesTable, ParcelVarietyRow>(table),
                  $$ParcelVarietiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({parcelId = false, grapeVarietyId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (parcelId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.parcelId,
                        referencedTable: $$ParcelVarietiesTableReferences
                            ._parcelIdTable(db),
                        referencedColumn: $$ParcelVarietiesTableReferences
                            ._parcelIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (grapeVarietyId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.grapeVarietyId,
                        referencedTable: $$ParcelVarietiesTableReferences
                            ._grapeVarietyIdTable(db),
                        referencedColumn: $$ParcelVarietiesTableReferences
                            ._grapeVarietyIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ParcelVarietiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ParcelVarietiesTable,
      ParcelVarietyRow,
      $$ParcelVarietiesTableFilterComposer,
      $$ParcelVarietiesTableOrderingComposer,
      $$ParcelVarietiesTableAnnotationComposer,
      $$ParcelVarietiesTableCreateCompanionBuilder,
      $$ParcelVarietiesTableUpdateCompanionBuilder,
      (ParcelVarietyRow, $$ParcelVarietiesTableReferences),
      ParcelVarietyRow,
      PrefetchHooks Function({bool parcelId, bool grapeVarietyId})
    >;
typedef $$HarvestSeasonsTableCreateCompanionBuilder =
    HarvestSeasonsCompanion Function({
      required String id,
      Value<String?> code,
      required String name,
      Value<DateTime?> startDate,
      Value<DateTime?> endDate,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$HarvestSeasonsTableUpdateCompanionBuilder =
    HarvestSeasonsCompanion Function({
      Value<String> id,
      Value<String?> code,
      Value<String> name,
      Value<DateTime?> startDate,
      Value<DateTime?> endDate,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$HarvestSeasonsTableReferences
    extends
        BaseReferences<_$AppDatabase, $HarvestSeasonsTable, HarvestSeasonRow> {
  $$HarvestSeasonsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $ProductionEstimatesTable,
    List<ProductionEstimateRow>
  >
  _productionEstimatesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.productionEstimates,
        aliasName: 'harvest_seasons__id__production_estimates__season_id',
      );

  $$ProductionEstimatesTableProcessedTableManager get productionEstimatesRefs {
    final manager = $$ProductionEstimatesTableTableManager(
      $_db,
      $_db.productionEstimates,
    ).filter((f) => f.seasonId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _productionEstimatesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$HarvestSeasonsTableFilterComposer
    extends Composer<_$AppDatabase, $HarvestSeasonsTable> {
  $$HarvestSeasonsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> productionEstimatesRefs(
    Expression<bool> Function($$ProductionEstimatesTableFilterComposer f) f,
  ) {
    final $$ProductionEstimatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productionEstimates,
      getReferencedColumn: (t) => t.seasonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductionEstimatesTableFilterComposer(
            $db: $db,
            $table: $db.productionEstimates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HarvestSeasonsTableOrderingComposer
    extends Composer<_$AppDatabase, $HarvestSeasonsTable> {
  $$HarvestSeasonsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HarvestSeasonsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HarvestSeasonsTable> {
  $$HarvestSeasonsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> productionEstimatesRefs<T extends Object>(
    Expression<T> Function($$ProductionEstimatesTableAnnotationComposer a) f,
  ) {
    final $$ProductionEstimatesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.productionEstimates,
          getReferencedColumn: (t) => t.seasonId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ProductionEstimatesTableAnnotationComposer(
                $db: $db,
                $table: $db.productionEstimates,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$HarvestSeasonsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HarvestSeasonsTable,
          HarvestSeasonRow,
          $$HarvestSeasonsTableFilterComposer,
          $$HarvestSeasonsTableOrderingComposer,
          $$HarvestSeasonsTableAnnotationComposer,
          $$HarvestSeasonsTableCreateCompanionBuilder,
          $$HarvestSeasonsTableUpdateCompanionBuilder,
          (HarvestSeasonRow, $$HarvestSeasonsTableReferences),
          HarvestSeasonRow,
          PrefetchHooks Function({bool productionEstimatesRefs})
        > {
  $$HarvestSeasonsTableTableManager(
    _$AppDatabase db,
    $HarvestSeasonsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HarvestSeasonsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HarvestSeasonsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HarvestSeasonsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime?> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HarvestSeasonsCompanion(
                id: id,
                code: code,
                name: name,
                startDate: startDate,
                endDate: endDate,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> code = const Value.absent(),
                required String name,
                Value<DateTime?> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => HarvestSeasonsCompanion.insert(
                id: id,
                code: code,
                name: name,
                startDate: startDate,
                endDate: endDate,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$HarvestSeasonsTable, HarvestSeasonRow>(table),
                  $$HarvestSeasonsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productionEstimatesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (productionEstimatesRefs) db.productionEstimates,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (productionEstimatesRefs)
                    await $_getPrefetchedDataByColumns<
                      HarvestSeasonRow,
                      $HarvestSeasonsTable,
                      ProductionEstimateRow,
                      $ProductionEstimatesTable
                    >(
                      currentTable: table,
                      referencedTable: $$HarvestSeasonsTableReferences
                          ._productionEstimatesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$HarvestSeasonsTableReferences(
                            db,
                            table,
                            p0,
                          ).productionEstimatesRefs,
                      currentColumn: 'id',
                      referencedColumn: 'season_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$HarvestSeasonsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HarvestSeasonsTable,
      HarvestSeasonRow,
      $$HarvestSeasonsTableFilterComposer,
      $$HarvestSeasonsTableOrderingComposer,
      $$HarvestSeasonsTableAnnotationComposer,
      $$HarvestSeasonsTableCreateCompanionBuilder,
      $$HarvestSeasonsTableUpdateCompanionBuilder,
      (HarvestSeasonRow, $$HarvestSeasonsTableReferences),
      HarvestSeasonRow,
      PrefetchHooks Function({bool productionEstimatesRefs})
    >;
typedef $$MeasurementUnitsTableCreateCompanionBuilder =
    MeasurementUnitsCompanion Function({
      required String id,
      required String code,
      Value<String?> abbreviation,
      required String name,
      Value<double?> kilogramsEquivalent,
      Value<bool> active,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$MeasurementUnitsTableUpdateCompanionBuilder =
    MeasurementUnitsCompanion Function({
      Value<String> id,
      Value<String> code,
      Value<String?> abbreviation,
      Value<String> name,
      Value<double?> kilogramsEquivalent,
      Value<bool> active,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$MeasurementUnitsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MeasurementUnitsTable,
          MeasurementUnitRow
        > {
  $$MeasurementUnitsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $ProductionEstimatesTable,
    List<ProductionEstimateRow>
  >
  _productionEstimatesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.productionEstimates,
        aliasName: 'measurement_units__id__production_estimates__unit_id',
      );

  $$ProductionEstimatesTableProcessedTableManager get productionEstimatesRefs {
    final manager = $$ProductionEstimatesTableTableManager(
      $_db,
      $_db.productionEstimates,
    ).filter((f) => f.unitId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _productionEstimatesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MeasurementUnitsTableFilterComposer
    extends Composer<_$AppDatabase, $MeasurementUnitsTable> {
  $$MeasurementUnitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get abbreviation => $composableBuilder(
    column: $table.abbreviation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get kilogramsEquivalent => $composableBuilder(
    column: $table.kilogramsEquivalent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> productionEstimatesRefs(
    Expression<bool> Function($$ProductionEstimatesTableFilterComposer f) f,
  ) {
    final $$ProductionEstimatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productionEstimates,
      getReferencedColumn: (t) => t.unitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductionEstimatesTableFilterComposer(
            $db: $db,
            $table: $db.productionEstimates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MeasurementUnitsTableOrderingComposer
    extends Composer<_$AppDatabase, $MeasurementUnitsTable> {
  $$MeasurementUnitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get abbreviation => $composableBuilder(
    column: $table.abbreviation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kilogramsEquivalent => $composableBuilder(
    column: $table.kilogramsEquivalent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MeasurementUnitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MeasurementUnitsTable> {
  $$MeasurementUnitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get abbreviation => $composableBuilder(
    column: $table.abbreviation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get kilogramsEquivalent => $composableBuilder(
    column: $table.kilogramsEquivalent,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> productionEstimatesRefs<T extends Object>(
    Expression<T> Function($$ProductionEstimatesTableAnnotationComposer a) f,
  ) {
    final $$ProductionEstimatesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.productionEstimates,
          getReferencedColumn: (t) => t.unitId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ProductionEstimatesTableAnnotationComposer(
                $db: $db,
                $table: $db.productionEstimates,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$MeasurementUnitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MeasurementUnitsTable,
          MeasurementUnitRow,
          $$MeasurementUnitsTableFilterComposer,
          $$MeasurementUnitsTableOrderingComposer,
          $$MeasurementUnitsTableAnnotationComposer,
          $$MeasurementUnitsTableCreateCompanionBuilder,
          $$MeasurementUnitsTableUpdateCompanionBuilder,
          (MeasurementUnitRow, $$MeasurementUnitsTableReferences),
          MeasurementUnitRow,
          PrefetchHooks Function({bool productionEstimatesRefs})
        > {
  $$MeasurementUnitsTableTableManager(
    _$AppDatabase db,
    $MeasurementUnitsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MeasurementUnitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MeasurementUnitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MeasurementUnitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String?> abbreviation = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double?> kilogramsEquivalent = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MeasurementUnitsCompanion(
                id: id,
                code: code,
                abbreviation: abbreviation,
                name: name,
                kilogramsEquivalent: kilogramsEquivalent,
                active: active,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String code,
                Value<String?> abbreviation = const Value.absent(),
                required String name,
                Value<double?> kilogramsEquivalent = const Value.absent(),
                Value<bool> active = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => MeasurementUnitsCompanion.insert(
                id: id,
                code: code,
                abbreviation: abbreviation,
                name: name,
                kilogramsEquivalent: kilogramsEquivalent,
                active: active,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MeasurementUnitsTable, MeasurementUnitRow>(
                    table,
                  ),
                  $$MeasurementUnitsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productionEstimatesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (productionEstimatesRefs) db.productionEstimates,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (productionEstimatesRefs)
                    await $_getPrefetchedDataByColumns<
                      MeasurementUnitRow,
                      $MeasurementUnitsTable,
                      ProductionEstimateRow,
                      $ProductionEstimatesTable
                    >(
                      currentTable: table,
                      referencedTable: $$MeasurementUnitsTableReferences
                          ._productionEstimatesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$MeasurementUnitsTableReferences(
                            db,
                            table,
                            p0,
                          ).productionEstimatesRefs,
                      currentColumn: 'id',
                      referencedColumn: 'unit_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$MeasurementUnitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MeasurementUnitsTable,
      MeasurementUnitRow,
      $$MeasurementUnitsTableFilterComposer,
      $$MeasurementUnitsTableOrderingComposer,
      $$MeasurementUnitsTableAnnotationComposer,
      $$MeasurementUnitsTableCreateCompanionBuilder,
      $$MeasurementUnitsTableUpdateCompanionBuilder,
      (MeasurementUnitRow, $$MeasurementUnitsTableReferences),
      MeasurementUnitRow,
      PrefetchHooks Function({bool productionEstimatesRefs})
    >;
typedef $$ProductionEstimatesTableCreateCompanionBuilder =
    ProductionEstimatesCompanion Function({
      required String id,
      required String parcelId,
      required String seasonId,
      Value<String?> grapeVarietyId,
      required double quantity,
      required String unitId,
      required double conversionFactorKg,
      required double estimatedKg,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ProductionEstimatesTableUpdateCompanionBuilder =
    ProductionEstimatesCompanion Function({
      Value<String> id,
      Value<String> parcelId,
      Value<String> seasonId,
      Value<String?> grapeVarietyId,
      Value<double> quantity,
      Value<String> unitId,
      Value<double> conversionFactorKg,
      Value<double> estimatedKg,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$ProductionEstimatesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ProductionEstimatesTable,
          ProductionEstimateRow
        > {
  $$ProductionEstimatesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ParcelsTable _parcelIdTable(_$AppDatabase db) =>
      db.parcels.createAlias('production_estimates__parcel_id__parcels__id');

  $$ParcelsTableProcessedTableManager get parcelId {
    final $_column = $_itemColumn<String>('parcel_id')!;

    final manager = $$ParcelsTableTableManager(
      $_db,
      $_db.parcels,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parcelIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $HarvestSeasonsTable _seasonIdTable(_$AppDatabase db) => db
      .harvestSeasons
      .createAlias('production_estimates__season_id__harvest_seasons__id');

  $$HarvestSeasonsTableProcessedTableManager get seasonId {
    final $_column = $_itemColumn<String>('season_id')!;

    final manager = $$HarvestSeasonsTableTableManager(
      $_db,
      $_db.harvestSeasons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_seasonIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $GrapeVarietiesTable _grapeVarietyIdTable(_$AppDatabase db) =>
      db.grapeVarieties.createAlias(
        'production_estimates__grape_variety_id__grape_varieties__id',
      );

  $$GrapeVarietiesTableProcessedTableManager? get grapeVarietyId {
    final $_column = $_itemColumn<String>('grape_variety_id');
    if ($_column == null) return null;
    final manager = $$GrapeVarietiesTableTableManager(
      $_db,
      $_db.grapeVarieties,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_grapeVarietyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MeasurementUnitsTable _unitIdTable(_$AppDatabase db) => db
      .measurementUnits
      .createAlias('production_estimates__unit_id__measurement_units__id');

  $$MeasurementUnitsTableProcessedTableManager get unitId {
    final $_column = $_itemColumn<String>('unit_id')!;

    final manager = $$MeasurementUnitsTableTableManager(
      $_db,
      $_db.measurementUnits,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_unitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProductionEstimatesTableFilterComposer
    extends Composer<_$AppDatabase, $ProductionEstimatesTable> {
  $$ProductionEstimatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get conversionFactorKg => $composableBuilder(
    column: $table.conversionFactorKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get estimatedKg => $composableBuilder(
    column: $table.estimatedKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ParcelsTableFilterComposer get parcelId {
    final $$ParcelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parcelId,
      referencedTable: $db.parcels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParcelsTableFilterComposer(
            $db: $db,
            $table: $db.parcels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$HarvestSeasonsTableFilterComposer get seasonId {
    final $$HarvestSeasonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.seasonId,
      referencedTable: $db.harvestSeasons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HarvestSeasonsTableFilterComposer(
            $db: $db,
            $table: $db.harvestSeasons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GrapeVarietiesTableFilterComposer get grapeVarietyId {
    final $$GrapeVarietiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.grapeVarietyId,
      referencedTable: $db.grapeVarieties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GrapeVarietiesTableFilterComposer(
            $db: $db,
            $table: $db.grapeVarieties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MeasurementUnitsTableFilterComposer get unitId {
    final $$MeasurementUnitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.unitId,
      referencedTable: $db.measurementUnits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeasurementUnitsTableFilterComposer(
            $db: $db,
            $table: $db.measurementUnits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductionEstimatesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductionEstimatesTable> {
  $$ProductionEstimatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get conversionFactorKg => $composableBuilder(
    column: $table.conversionFactorKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get estimatedKg => $composableBuilder(
    column: $table.estimatedKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ParcelsTableOrderingComposer get parcelId {
    final $$ParcelsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parcelId,
      referencedTable: $db.parcels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParcelsTableOrderingComposer(
            $db: $db,
            $table: $db.parcels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$HarvestSeasonsTableOrderingComposer get seasonId {
    final $$HarvestSeasonsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.seasonId,
      referencedTable: $db.harvestSeasons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HarvestSeasonsTableOrderingComposer(
            $db: $db,
            $table: $db.harvestSeasons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GrapeVarietiesTableOrderingComposer get grapeVarietyId {
    final $$GrapeVarietiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.grapeVarietyId,
      referencedTable: $db.grapeVarieties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GrapeVarietiesTableOrderingComposer(
            $db: $db,
            $table: $db.grapeVarieties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MeasurementUnitsTableOrderingComposer get unitId {
    final $$MeasurementUnitsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.unitId,
      referencedTable: $db.measurementUnits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeasurementUnitsTableOrderingComposer(
            $db: $db,
            $table: $db.measurementUnits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductionEstimatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductionEstimatesTable> {
  $$ProductionEstimatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get conversionFactorKg => $composableBuilder(
    column: $table.conversionFactorKg,
    builder: (column) => column,
  );

  GeneratedColumn<double> get estimatedKg => $composableBuilder(
    column: $table.estimatedKg,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ParcelsTableAnnotationComposer get parcelId {
    final $$ParcelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parcelId,
      referencedTable: $db.parcels,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParcelsTableAnnotationComposer(
            $db: $db,
            $table: $db.parcels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$HarvestSeasonsTableAnnotationComposer get seasonId {
    final $$HarvestSeasonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.seasonId,
      referencedTable: $db.harvestSeasons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HarvestSeasonsTableAnnotationComposer(
            $db: $db,
            $table: $db.harvestSeasons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GrapeVarietiesTableAnnotationComposer get grapeVarietyId {
    final $$GrapeVarietiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.grapeVarietyId,
      referencedTable: $db.grapeVarieties,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GrapeVarietiesTableAnnotationComposer(
            $db: $db,
            $table: $db.grapeVarieties,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MeasurementUnitsTableAnnotationComposer get unitId {
    final $$MeasurementUnitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.unitId,
      referencedTable: $db.measurementUnits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeasurementUnitsTableAnnotationComposer(
            $db: $db,
            $table: $db.measurementUnits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductionEstimatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductionEstimatesTable,
          ProductionEstimateRow,
          $$ProductionEstimatesTableFilterComposer,
          $$ProductionEstimatesTableOrderingComposer,
          $$ProductionEstimatesTableAnnotationComposer,
          $$ProductionEstimatesTableCreateCompanionBuilder,
          $$ProductionEstimatesTableUpdateCompanionBuilder,
          (ProductionEstimateRow, $$ProductionEstimatesTableReferences),
          ProductionEstimateRow,
          PrefetchHooks Function({
            bool parcelId,
            bool seasonId,
            bool grapeVarietyId,
            bool unitId,
          })
        > {
  $$ProductionEstimatesTableTableManager(
    _$AppDatabase db,
    $ProductionEstimatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductionEstimatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductionEstimatesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ProductionEstimatesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> parcelId = const Value.absent(),
                Value<String> seasonId = const Value.absent(),
                Value<String?> grapeVarietyId = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<String> unitId = const Value.absent(),
                Value<double> conversionFactorKg = const Value.absent(),
                Value<double> estimatedKg = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductionEstimatesCompanion(
                id: id,
                parcelId: parcelId,
                seasonId: seasonId,
                grapeVarietyId: grapeVarietyId,
                quantity: quantity,
                unitId: unitId,
                conversionFactorKg: conversionFactorKg,
                estimatedKg: estimatedKg,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String parcelId,
                required String seasonId,
                Value<String?> grapeVarietyId = const Value.absent(),
                required double quantity,
                required String unitId,
                required double conversionFactorKg,
                required double estimatedKg,
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ProductionEstimatesCompanion.insert(
                id: id,
                parcelId: parcelId,
                seasonId: seasonId,
                grapeVarietyId: grapeVarietyId,
                quantity: quantity,
                unitId: unitId,
                conversionFactorKg: conversionFactorKg,
                estimatedKg: estimatedKg,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProductionEstimatesTable, ProductionEstimateRow>(
                    table,
                  ),
                  $$ProductionEstimatesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                parcelId = false,
                seasonId = false,
                grapeVarietyId = false,
                unitId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (parcelId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.parcelId,
                            referencedTable:
                                $$ProductionEstimatesTableReferences
                                    ._parcelIdTable(db),
                            referencedColumn:
                                $$ProductionEstimatesTableReferences
                                    ._parcelIdTable(db)
                                    .id,
                          ) as T;
                        }
                        if (seasonId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.seasonId,
                            referencedTable:
                                $$ProductionEstimatesTableReferences
                                    ._seasonIdTable(db),
                            referencedColumn:
                                $$ProductionEstimatesTableReferences
                                    ._seasonIdTable(db)
                                    .id,
                          ) as T;
                        }
                        if (grapeVarietyId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.grapeVarietyId,
                            referencedTable:
                                $$ProductionEstimatesTableReferences
                                    ._grapeVarietyIdTable(db),
                            referencedColumn:
                                $$ProductionEstimatesTableReferences
                                    ._grapeVarietyIdTable(db)
                                    .id,
                          ) as T;
                        }
                        if (unitId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.unitId,
                            referencedTable:
                                $$ProductionEstimatesTableReferences
                                    ._unitIdTable(db),
                            referencedColumn:
                                $$ProductionEstimatesTableReferences
                                    ._unitIdTable(db)
                                    .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$ProductionEstimatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductionEstimatesTable,
      ProductionEstimateRow,
      $$ProductionEstimatesTableFilterComposer,
      $$ProductionEstimatesTableOrderingComposer,
      $$ProductionEstimatesTableAnnotationComposer,
      $$ProductionEstimatesTableCreateCompanionBuilder,
      $$ProductionEstimatesTableUpdateCompanionBuilder,
      (ProductionEstimateRow, $$ProductionEstimatesTableReferences),
      ProductionEstimateRow,
      PrefetchHooks Function({
        bool parcelId,
        bool seasonId,
        bool grapeVarietyId,
        bool unitId,
      })
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FarmersTableTableManager get farmers =>
      $$FarmersTableTableManager(_db, _db.farmers);
  $$ParcelsTableTableManager get parcels =>
      $$ParcelsTableTableManager(_db, _db.parcels);
  $$ParcelOwnersTableTableManager get parcelOwners =>
      $$ParcelOwnersTableTableManager(_db, _db.parcelOwners);
  $$ParcelVerticesTableTableManager get parcelVertices =>
      $$ParcelVerticesTableTableManager(_db, _db.parcelVertices);
  $$VertexPhotosTableTableManager get vertexPhotos =>
      $$VertexPhotosTableTableManager(_db, _db.vertexPhotos);
  $$GrapeVarietiesTableTableManager get grapeVarieties =>
      $$GrapeVarietiesTableTableManager(_db, _db.grapeVarieties);
  $$ParcelVarietiesTableTableManager get parcelVarieties =>
      $$ParcelVarietiesTableTableManager(_db, _db.parcelVarieties);
  $$HarvestSeasonsTableTableManager get harvestSeasons =>
      $$HarvestSeasonsTableTableManager(_db, _db.harvestSeasons);
  $$MeasurementUnitsTableTableManager get measurementUnits =>
      $$MeasurementUnitsTableTableManager(_db, _db.measurementUnits);
  $$ProductionEstimatesTableTableManager get productionEstimates =>
      $$ProductionEstimatesTableTableManager(_db, _db.productionEstimates);
}
