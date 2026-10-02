// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _passwordHashMeta = const VerificationMeta(
    'passwordHash',
  );
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
    'password_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 2,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _jobTitleMeta = const VerificationMeta(
    'jobTitle',
  );
  @override
  late final GeneratedColumn<String> jobTitle = GeneratedColumn<String>(
    'job_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _salaryMeta = const VerificationMeta('salary');
  @override
  late final GeneratedColumn<double> salary = GeneratedColumn<double>(
    'salary',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isWorkerMeta = const VerificationMeta(
    'isWorker',
  );
  @override
  late final GeneratedColumn<bool> isWorker = GeneratedColumn<bool>(
    'is_worker',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_worker" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('cashier'),
  );
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
    'image',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _lastLoginMeta = const VerificationMeta(
    'lastLogin',
  );
  @override
  late final GeneratedColumn<DateTime> lastLogin = GeneratedColumn<DateTime>(
    'last_login',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isLoggedInMeta = const VerificationMeta(
    'isLoggedIn',
  );
  @override
  late final GeneratedColumn<bool> isLoggedIn = GeneratedColumn<bool>(
    'is_logged_in',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_logged_in" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    username,
    passwordHash,
    fullName,
    phone,
    jobTitle,
    salary,
    barcode,
    isWorker,
    role,
    image,
    isActive,
    lastLogin,
    isLoggedIn,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password_hash')) {
      context.handle(
        _passwordHashMeta,
        passwordHash.isAcceptableOrUnknown(
          data['password_hash']!,
          _passwordHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_passwordHashMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('job_title')) {
      context.handle(
        _jobTitleMeta,
        jobTitle.isAcceptableOrUnknown(data['job_title']!, _jobTitleMeta),
      );
    }
    if (data.containsKey('salary')) {
      context.handle(
        _salaryMeta,
        salary.isAcceptableOrUnknown(data['salary']!, _salaryMeta),
      );
    }
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
      );
    }
    if (data.containsKey('is_worker')) {
      context.handle(
        _isWorkerMeta,
        isWorker.isAcceptableOrUnknown(data['is_worker']!, _isWorkerMeta),
      );
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    }
    if (data.containsKey('image')) {
      context.handle(
        _imageMeta,
        image.isAcceptableOrUnknown(data['image']!, _imageMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('last_login')) {
      context.handle(
        _lastLoginMeta,
        lastLogin.isAcceptableOrUnknown(data['last_login']!, _lastLoginMeta),
      );
    }
    if (data.containsKey('is_logged_in')) {
      context.handle(
        _isLoggedInMeta,
        isLoggedIn.isAcceptableOrUnknown(
          data['is_logged_in']!,
          _isLoggedInMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
      passwordHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password_hash'],
      )!,
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      jobTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}job_title'],
      )!,
      salary: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}salary'],
      )!,
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      ),
      isWorker: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_worker'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      image: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      lastLogin: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_login'],
      ),
      isLoggedIn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_logged_in'],
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
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  /// رقم المستخدم
  final int id;

  /// اسم الدخول
  final String username;

  /// كلمة المرور (يفضل لاحقًا تخزينها Hash)
  final String passwordHash;

  /// الاسم الكامل
  final String fullName;

  /// Worker-specific profile fields. Non-worker accounts keep the defaults.
  final String? phone;
  final String jobTitle;
  final double salary;
  final String? barcode;
  final bool isWorker;

  /// الدور
  /// admin - manager - cashier
  final String role;

  /// صورة المستخدم
  final String? image;

  /// حالة الحساب
  final bool isActive;

  /// آخر تسجيل دخول
  final DateTime? lastLogin;
  final bool isLoggedIn;
  final DateTime createdAt;
  final DateTime updatedAt;
  const User({
    required this.id,
    required this.username,
    required this.passwordHash,
    required this.fullName,
    this.phone,
    required this.jobTitle,
    required this.salary,
    this.barcode,
    required this.isWorker,
    required this.role,
    this.image,
    required this.isActive,
    this.lastLogin,
    required this.isLoggedIn,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['password_hash'] = Variable<String>(passwordHash);
    map['full_name'] = Variable<String>(fullName);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['job_title'] = Variable<String>(jobTitle);
    map['salary'] = Variable<double>(salary);
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    map['is_worker'] = Variable<bool>(isWorker);
    map['role'] = Variable<String>(role);
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || lastLogin != null) {
      map['last_login'] = Variable<DateTime>(lastLogin);
    }
    map['is_logged_in'] = Variable<bool>(isLoggedIn);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      username: Value(username),
      passwordHash: Value(passwordHash),
      fullName: Value(fullName),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      jobTitle: Value(jobTitle),
      salary: Value(salary),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      isWorker: Value(isWorker),
      role: Value(role),
      image: image == null && nullToAbsent
          ? const Value.absent()
          : Value(image),
      isActive: Value(isActive),
      lastLogin: lastLogin == null && nullToAbsent
          ? const Value.absent()
          : Value(lastLogin),
      isLoggedIn: Value(isLoggedIn),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      passwordHash: serializer.fromJson<String>(json['passwordHash']),
      fullName: serializer.fromJson<String>(json['fullName']),
      phone: serializer.fromJson<String?>(json['phone']),
      jobTitle: serializer.fromJson<String>(json['jobTitle']),
      salary: serializer.fromJson<double>(json['salary']),
      barcode: serializer.fromJson<String?>(json['barcode']),
      isWorker: serializer.fromJson<bool>(json['isWorker']),
      role: serializer.fromJson<String>(json['role']),
      image: serializer.fromJson<String?>(json['image']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      lastLogin: serializer.fromJson<DateTime?>(json['lastLogin']),
      isLoggedIn: serializer.fromJson<bool>(json['isLoggedIn']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'passwordHash': serializer.toJson<String>(passwordHash),
      'fullName': serializer.toJson<String>(fullName),
      'phone': serializer.toJson<String?>(phone),
      'jobTitle': serializer.toJson<String>(jobTitle),
      'salary': serializer.toJson<double>(salary),
      'barcode': serializer.toJson<String?>(barcode),
      'isWorker': serializer.toJson<bool>(isWorker),
      'role': serializer.toJson<String>(role),
      'image': serializer.toJson<String?>(image),
      'isActive': serializer.toJson<bool>(isActive),
      'lastLogin': serializer.toJson<DateTime?>(lastLogin),
      'isLoggedIn': serializer.toJson<bool>(isLoggedIn),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  User copyWith({
    int? id,
    String? username,
    String? passwordHash,
    String? fullName,
    Value<String?> phone = const Value.absent(),
    String? jobTitle,
    double? salary,
    Value<String?> barcode = const Value.absent(),
    bool? isWorker,
    String? role,
    Value<String?> image = const Value.absent(),
    bool? isActive,
    Value<DateTime?> lastLogin = const Value.absent(),
    bool? isLoggedIn,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => User(
    id: id ?? this.id,
    username: username ?? this.username,
    passwordHash: passwordHash ?? this.passwordHash,
    fullName: fullName ?? this.fullName,
    phone: phone.present ? phone.value : this.phone,
    jobTitle: jobTitle ?? this.jobTitle,
    salary: salary ?? this.salary,
    barcode: barcode.present ? barcode.value : this.barcode,
    isWorker: isWorker ?? this.isWorker,
    role: role ?? this.role,
    image: image.present ? image.value : this.image,
    isActive: isActive ?? this.isActive,
    lastLogin: lastLogin.present ? lastLogin.value : this.lastLogin,
    isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      phone: data.phone.present ? data.phone.value : this.phone,
      jobTitle: data.jobTitle.present ? data.jobTitle.value : this.jobTitle,
      salary: data.salary.present ? data.salary.value : this.salary,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      isWorker: data.isWorker.present ? data.isWorker.value : this.isWorker,
      role: data.role.present ? data.role.value : this.role,
      image: data.image.present ? data.image.value : this.image,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      lastLogin: data.lastLogin.present ? data.lastLogin.value : this.lastLogin,
      isLoggedIn: data.isLoggedIn.present
          ? data.isLoggedIn.value
          : this.isLoggedIn,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('fullName: $fullName, ')
          ..write('phone: $phone, ')
          ..write('jobTitle: $jobTitle, ')
          ..write('salary: $salary, ')
          ..write('barcode: $barcode, ')
          ..write('isWorker: $isWorker, ')
          ..write('role: $role, ')
          ..write('image: $image, ')
          ..write('isActive: $isActive, ')
          ..write('lastLogin: $lastLogin, ')
          ..write('isLoggedIn: $isLoggedIn, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    username,
    passwordHash,
    fullName,
    phone,
    jobTitle,
    salary,
    barcode,
    isWorker,
    role,
    image,
    isActive,
    lastLogin,
    isLoggedIn,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.username == this.username &&
          other.passwordHash == this.passwordHash &&
          other.fullName == this.fullName &&
          other.phone == this.phone &&
          other.jobTitle == this.jobTitle &&
          other.salary == this.salary &&
          other.barcode == this.barcode &&
          other.isWorker == this.isWorker &&
          other.role == this.role &&
          other.image == this.image &&
          other.isActive == this.isActive &&
          other.lastLogin == this.lastLogin &&
          other.isLoggedIn == this.isLoggedIn &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> passwordHash;
  final Value<String> fullName;
  final Value<String?> phone;
  final Value<String> jobTitle;
  final Value<double> salary;
  final Value<String?> barcode;
  final Value<bool> isWorker;
  final Value<String> role;
  final Value<String?> image;
  final Value<bool> isActive;
  final Value<DateTime?> lastLogin;
  final Value<bool> isLoggedIn;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.fullName = const Value.absent(),
    this.phone = const Value.absent(),
    this.jobTitle = const Value.absent(),
    this.salary = const Value.absent(),
    this.barcode = const Value.absent(),
    this.isWorker = const Value.absent(),
    this.role = const Value.absent(),
    this.image = const Value.absent(),
    this.isActive = const Value.absent(),
    this.lastLogin = const Value.absent(),
    this.isLoggedIn = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required String passwordHash,
    required String fullName,
    this.phone = const Value.absent(),
    this.jobTitle = const Value.absent(),
    this.salary = const Value.absent(),
    this.barcode = const Value.absent(),
    this.isWorker = const Value.absent(),
    this.role = const Value.absent(),
    this.image = const Value.absent(),
    this.isActive = const Value.absent(),
    this.lastLogin = const Value.absent(),
    this.isLoggedIn = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : username = Value(username),
       passwordHash = Value(passwordHash),
       fullName = Value(fullName);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? passwordHash,
    Expression<String>? fullName,
    Expression<String>? phone,
    Expression<String>? jobTitle,
    Expression<double>? salary,
    Expression<String>? barcode,
    Expression<bool>? isWorker,
    Expression<String>? role,
    Expression<String>? image,
    Expression<bool>? isActive,
    Expression<DateTime>? lastLogin,
    Expression<bool>? isLoggedIn,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (fullName != null) 'full_name': fullName,
      if (phone != null) 'phone': phone,
      if (jobTitle != null) 'job_title': jobTitle,
      if (salary != null) 'salary': salary,
      if (barcode != null) 'barcode': barcode,
      if (isWorker != null) 'is_worker': isWorker,
      if (role != null) 'role': role,
      if (image != null) 'image': image,
      if (isActive != null) 'is_active': isActive,
      if (lastLogin != null) 'last_login': lastLogin,
      if (isLoggedIn != null) 'is_logged_in': isLoggedIn,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? username,
    Value<String>? passwordHash,
    Value<String>? fullName,
    Value<String?>? phone,
    Value<String>? jobTitle,
    Value<double>? salary,
    Value<String?>? barcode,
    Value<bool>? isWorker,
    Value<String>? role,
    Value<String?>? image,
    Value<bool>? isActive,
    Value<DateTime?>? lastLogin,
    Value<bool>? isLoggedIn,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      passwordHash: passwordHash ?? this.passwordHash,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      jobTitle: jobTitle ?? this.jobTitle,
      salary: salary ?? this.salary,
      barcode: barcode ?? this.barcode,
      isWorker: isWorker ?? this.isWorker,
      role: role ?? this.role,
      image: image ?? this.image,
      isActive: isActive ?? this.isActive,
      lastLogin: lastLogin ?? this.lastLogin,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (jobTitle.present) {
      map['job_title'] = Variable<String>(jobTitle.value);
    }
    if (salary.present) {
      map['salary'] = Variable<double>(salary.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (isWorker.present) {
      map['is_worker'] = Variable<bool>(isWorker.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (lastLogin.present) {
      map['last_login'] = Variable<DateTime>(lastLogin.value);
    }
    if (isLoggedIn.present) {
      map['is_logged_in'] = Variable<bool>(isLoggedIn.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('fullName: $fullName, ')
          ..write('phone: $phone, ')
          ..write('jobTitle: $jobTitle, ')
          ..write('salary: $salary, ')
          ..write('barcode: $barcode, ')
          ..write('isWorker: $isWorker, ')
          ..write('role: $role, ')
          ..write('image: $image, ')
          ..write('isActive: $isActive, ')
          ..write('lastLogin: $lastLogin, ')
          ..write('isLoggedIn: $isLoggedIn, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant("قطعة"),
  );
  static const VerificationMeta _purchasePriceMeta = const VerificationMeta(
    'purchasePrice',
  );
  @override
  late final GeneratedColumn<double> purchasePrice = GeneratedColumn<double>(
    'purchase_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cartonPriceMeta = const VerificationMeta(
    'cartonPrice',
  );
  @override
  late final GeneratedColumn<double> cartonPrice = GeneratedColumn<double>(
    'carton_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _unitsPerCartonMeta = const VerificationMeta(
    'unitsPerCarton',
  );
  @override
  late final GeneratedColumn<int> unitsPerCarton = GeneratedColumn<int>(
    'units_per_carton',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _cartonQuantityMeta = const VerificationMeta(
    'cartonQuantity',
  );
  @override
  late final GeneratedColumn<double> cartonQuantity = GeneratedColumn<double>(
    'carton_quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _stockQuantityMeta = const VerificationMeta(
    'stockQuantity',
  );
  @override
  late final GeneratedColumn<int> stockQuantity = GeneratedColumn<int>(
    'stock_quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _minStockLimitMeta = const VerificationMeta(
    'minStockLimit',
  );
  @override
  late final GeneratedColumn<int> minStockLimit = GeneratedColumn<int>(
    'min_stock_limit',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(5),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    barcode,
    category,
    unit,
    purchasePrice,
    price,
    cartonPrice,
    unitsPerCarton,
    cartonQuantity,
    stockQuantity,
    minStockLimit,
    isActive,
    imageUrl,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<Product> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
      );
    } else if (isInserting) {
      context.missing(_barcodeMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    if (data.containsKey('purchase_price')) {
      context.handle(
        _purchasePriceMeta,
        purchasePrice.isAcceptableOrUnknown(
          data['purchase_price']!,
          _purchasePriceMeta,
        ),
      );
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('carton_price')) {
      context.handle(
        _cartonPriceMeta,
        cartonPrice.isAcceptableOrUnknown(
          data['carton_price']!,
          _cartonPriceMeta,
        ),
      );
    }
    if (data.containsKey('units_per_carton')) {
      context.handle(
        _unitsPerCartonMeta,
        unitsPerCarton.isAcceptableOrUnknown(
          data['units_per_carton']!,
          _unitsPerCartonMeta,
        ),
      );
    }
    if (data.containsKey('carton_quantity')) {
      context.handle(
        _cartonQuantityMeta,
        cartonQuantity.isAcceptableOrUnknown(
          data['carton_quantity']!,
          _cartonQuantityMeta,
        ),
      );
    }
    if (data.containsKey('stock_quantity')) {
      context.handle(
        _stockQuantityMeta,
        stockQuantity.isAcceptableOrUnknown(
          data['stock_quantity']!,
          _stockQuantityMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_stockQuantityMeta);
    }
    if (data.containsKey('min_stock_limit')) {
      context.handle(
        _minStockLimitMeta,
        minStockLimit.isAcceptableOrUnknown(
          data['min_stock_limit']!,
          _minStockLimitMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      purchasePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}purchase_price'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      cartonPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carton_price'],
      )!,
      unitsPerCarton: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}units_per_carton'],
      )!,
      cartonQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carton_quantity'],
      )!,
      stockQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stock_quantity'],
      )!,
      minStockLimit: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_stock_limit'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
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
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final int id;
  final String name;
  final String barcode;
  final String category;
  final String unit;

  /// سعر شراء الوحدة. بيتخزن فعليًا (مستخدم في المبيعات/الفواتير)،
  /// وبيتزامن تلقائيًا من cartonPrice/unitsPerCarton في شاشة إدارة
  /// الأصناف.
  final double purchasePrice;

  /// سعر بيع الوحدة.
  final double price;

  /// سعر الكرتونة كاملة (المصدر الأساسي لحساب purchasePrice).
  final double cartonPrice;

  /// عدد الوحدات في الكرتونة الواحدة.
  final int unitsPerCarton;

  /// عدد الكراتين اللي اتوردت (بيانة توريد، مش بتنقص مع البيع).
  /// بيتستخدم لحساب stockQuantity تلقائيًا وقت الإضافة/التوريد:
  /// stockQuantity = cartonQuantity × unitsPerCarton.
  final double cartonQuantity;

  /// الكمية الفعلية بالوحدة المتاحة للبيع. دي اللي بتنقص مع كل عملية
  /// بيع، ومستقلة عن cartonQuantity بعد أول حساب.
  final int stockQuantity;
  final int minStockLimit;
  final bool isActive;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Product({
    required this.id,
    required this.name,
    required this.barcode,
    required this.category,
    required this.unit,
    required this.purchasePrice,
    required this.price,
    required this.cartonPrice,
    required this.unitsPerCarton,
    required this.cartonQuantity,
    required this.stockQuantity,
    required this.minStockLimit,
    required this.isActive,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['barcode'] = Variable<String>(barcode);
    map['category'] = Variable<String>(category);
    map['unit'] = Variable<String>(unit);
    map['purchase_price'] = Variable<double>(purchasePrice);
    map['price'] = Variable<double>(price);
    map['carton_price'] = Variable<double>(cartonPrice);
    map['units_per_carton'] = Variable<int>(unitsPerCarton);
    map['carton_quantity'] = Variable<double>(cartonQuantity);
    map['stock_quantity'] = Variable<int>(stockQuantity);
    map['min_stock_limit'] = Variable<int>(minStockLimit);
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      name: Value(name),
      barcode: Value(barcode),
      category: Value(category),
      unit: Value(unit),
      purchasePrice: Value(purchasePrice),
      price: Value(price),
      cartonPrice: Value(cartonPrice),
      unitsPerCarton: Value(unitsPerCarton),
      cartonQuantity: Value(cartonQuantity),
      stockQuantity: Value(stockQuantity),
      minStockLimit: Value(minStockLimit),
      isActive: Value(isActive),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Product.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      barcode: serializer.fromJson<String>(json['barcode']),
      category: serializer.fromJson<String>(json['category']),
      unit: serializer.fromJson<String>(json['unit']),
      purchasePrice: serializer.fromJson<double>(json['purchasePrice']),
      price: serializer.fromJson<double>(json['price']),
      cartonPrice: serializer.fromJson<double>(json['cartonPrice']),
      unitsPerCarton: serializer.fromJson<int>(json['unitsPerCarton']),
      cartonQuantity: serializer.fromJson<double>(json['cartonQuantity']),
      stockQuantity: serializer.fromJson<int>(json['stockQuantity']),
      minStockLimit: serializer.fromJson<int>(json['minStockLimit']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'barcode': serializer.toJson<String>(barcode),
      'category': serializer.toJson<String>(category),
      'unit': serializer.toJson<String>(unit),
      'purchasePrice': serializer.toJson<double>(purchasePrice),
      'price': serializer.toJson<double>(price),
      'cartonPrice': serializer.toJson<double>(cartonPrice),
      'unitsPerCarton': serializer.toJson<int>(unitsPerCarton),
      'cartonQuantity': serializer.toJson<double>(cartonQuantity),
      'stockQuantity': serializer.toJson<int>(stockQuantity),
      'minStockLimit': serializer.toJson<int>(minStockLimit),
      'isActive': serializer.toJson<bool>(isActive),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Product copyWith({
    int? id,
    String? name,
    String? barcode,
    String? category,
    String? unit,
    double? purchasePrice,
    double? price,
    double? cartonPrice,
    int? unitsPerCarton,
    double? cartonQuantity,
    int? stockQuantity,
    int? minStockLimit,
    bool? isActive,
    Value<String?> imageUrl = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Product(
    id: id ?? this.id,
    name: name ?? this.name,
    barcode: barcode ?? this.barcode,
    category: category ?? this.category,
    unit: unit ?? this.unit,
    purchasePrice: purchasePrice ?? this.purchasePrice,
    price: price ?? this.price,
    cartonPrice: cartonPrice ?? this.cartonPrice,
    unitsPerCarton: unitsPerCarton ?? this.unitsPerCarton,
    cartonQuantity: cartonQuantity ?? this.cartonQuantity,
    stockQuantity: stockQuantity ?? this.stockQuantity,
    minStockLimit: minStockLimit ?? this.minStockLimit,
    isActive: isActive ?? this.isActive,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      category: data.category.present ? data.category.value : this.category,
      unit: data.unit.present ? data.unit.value : this.unit,
      purchasePrice: data.purchasePrice.present
          ? data.purchasePrice.value
          : this.purchasePrice,
      price: data.price.present ? data.price.value : this.price,
      cartonPrice: data.cartonPrice.present
          ? data.cartonPrice.value
          : this.cartonPrice,
      unitsPerCarton: data.unitsPerCarton.present
          ? data.unitsPerCarton.value
          : this.unitsPerCarton,
      cartonQuantity: data.cartonQuantity.present
          ? data.cartonQuantity.value
          : this.cartonQuantity,
      stockQuantity: data.stockQuantity.present
          ? data.stockQuantity.value
          : this.stockQuantity,
      minStockLimit: data.minStockLimit.present
          ? data.minStockLimit.value
          : this.minStockLimit,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('barcode: $barcode, ')
          ..write('category: $category, ')
          ..write('unit: $unit, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('price: $price, ')
          ..write('cartonPrice: $cartonPrice, ')
          ..write('unitsPerCarton: $unitsPerCarton, ')
          ..write('cartonQuantity: $cartonQuantity, ')
          ..write('stockQuantity: $stockQuantity, ')
          ..write('minStockLimit: $minStockLimit, ')
          ..write('isActive: $isActive, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    barcode,
    category,
    unit,
    purchasePrice,
    price,
    cartonPrice,
    unitsPerCarton,
    cartonQuantity,
    stockQuantity,
    minStockLimit,
    isActive,
    imageUrl,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.name == this.name &&
          other.barcode == this.barcode &&
          other.category == this.category &&
          other.unit == this.unit &&
          other.purchasePrice == this.purchasePrice &&
          other.price == this.price &&
          other.cartonPrice == this.cartonPrice &&
          other.unitsPerCarton == this.unitsPerCarton &&
          other.cartonQuantity == this.cartonQuantity &&
          other.stockQuantity == this.stockQuantity &&
          other.minStockLimit == this.minStockLimit &&
          other.isActive == this.isActive &&
          other.imageUrl == this.imageUrl &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> barcode;
  final Value<String> category;
  final Value<String> unit;
  final Value<double> purchasePrice;
  final Value<double> price;
  final Value<double> cartonPrice;
  final Value<int> unitsPerCarton;
  final Value<double> cartonQuantity;
  final Value<int> stockQuantity;
  final Value<int> minStockLimit;
  final Value<bool> isActive;
  final Value<String?> imageUrl;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.barcode = const Value.absent(),
    this.category = const Value.absent(),
    this.unit = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.price = const Value.absent(),
    this.cartonPrice = const Value.absent(),
    this.unitsPerCarton = const Value.absent(),
    this.cartonQuantity = const Value.absent(),
    this.stockQuantity = const Value.absent(),
    this.minStockLimit = const Value.absent(),
    this.isActive = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String barcode,
    required String category,
    this.unit = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    required double price,
    this.cartonPrice = const Value.absent(),
    this.unitsPerCarton = const Value.absent(),
    this.cartonQuantity = const Value.absent(),
    required int stockQuantity,
    this.minStockLimit = const Value.absent(),
    this.isActive = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name),
       barcode = Value(barcode),
       category = Value(category),
       price = Value(price),
       stockQuantity = Value(stockQuantity);
  static Insertable<Product> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? barcode,
    Expression<String>? category,
    Expression<String>? unit,
    Expression<double>? purchasePrice,
    Expression<double>? price,
    Expression<double>? cartonPrice,
    Expression<int>? unitsPerCarton,
    Expression<double>? cartonQuantity,
    Expression<int>? stockQuantity,
    Expression<int>? minStockLimit,
    Expression<bool>? isActive,
    Expression<String>? imageUrl,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (barcode != null) 'barcode': barcode,
      if (category != null) 'category': category,
      if (unit != null) 'unit': unit,
      if (purchasePrice != null) 'purchase_price': purchasePrice,
      if (price != null) 'price': price,
      if (cartonPrice != null) 'carton_price': cartonPrice,
      if (unitsPerCarton != null) 'units_per_carton': unitsPerCarton,
      if (cartonQuantity != null) 'carton_quantity': cartonQuantity,
      if (stockQuantity != null) 'stock_quantity': stockQuantity,
      if (minStockLimit != null) 'min_stock_limit': minStockLimit,
      if (isActive != null) 'is_active': isActive,
      if (imageUrl != null) 'image_url': imageUrl,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ProductsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? barcode,
    Value<String>? category,
    Value<String>? unit,
    Value<double>? purchasePrice,
    Value<double>? price,
    Value<double>? cartonPrice,
    Value<int>? unitsPerCarton,
    Value<double>? cartonQuantity,
    Value<int>? stockQuantity,
    Value<int>? minStockLimit,
    Value<bool>? isActive,
    Value<String?>? imageUrl,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      barcode: barcode ?? this.barcode,
      category: category ?? this.category,
      unit: unit ?? this.unit,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      price: price ?? this.price,
      cartonPrice: cartonPrice ?? this.cartonPrice,
      unitsPerCarton: unitsPerCarton ?? this.unitsPerCarton,
      cartonQuantity: cartonQuantity ?? this.cartonQuantity,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      minStockLimit: minStockLimit ?? this.minStockLimit,
      isActive: isActive ?? this.isActive,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (purchasePrice.present) {
      map['purchase_price'] = Variable<double>(purchasePrice.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (cartonPrice.present) {
      map['carton_price'] = Variable<double>(cartonPrice.value);
    }
    if (unitsPerCarton.present) {
      map['units_per_carton'] = Variable<int>(unitsPerCarton.value);
    }
    if (cartonQuantity.present) {
      map['carton_quantity'] = Variable<double>(cartonQuantity.value);
    }
    if (stockQuantity.present) {
      map['stock_quantity'] = Variable<int>(stockQuantity.value);
    }
    if (minStockLimit.present) {
      map['min_stock_limit'] = Variable<int>(minStockLimit.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('barcode: $barcode, ')
          ..write('category: $category, ')
          ..write('unit: $unit, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('price: $price, ')
          ..write('cartonPrice: $cartonPrice, ')
          ..write('unitsPerCarton: $unitsPerCarton, ')
          ..write('cartonQuantity: $cartonQuantity, ')
          ..write('stockQuantity: $stockQuantity, ')
          ..write('minStockLimit: $minStockLimit, ')
          ..write('isActive: $isActive, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, Customer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _totalDebtMeta = const VerificationMeta(
    'totalDebt',
  );
  @override
  late final GeneratedColumn<double> totalDebt = GeneratedColumn<double>(
    'total_debt',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    phone,
    address,
    totalDebt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Customer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('total_debt')) {
      context.handle(
        _totalDebtMeta,
        totalDebt.isAcceptableOrUnknown(data['total_debt']!, _totalDebtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Customer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Customer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      totalDebt: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_debt'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class Customer extends DataClass implements Insertable<Customer> {
  final int id;

  /// اسم العميل
  final String name;

  /// رقم التليفون (اختياري - لكن لو اتسجل، بيبقى فريد عشان نقدر ندور بيه على العميل)
  final String? phone;

  /// عنوان العميل (اختياري)
  final String address;

  /// إجمالي المديونية الحالية على العميل (مجموع remainingAmount بتاع فواتيره)
  final double totalDebt;

  /// تاريخ إضافة العميل
  final DateTime createdAt;
  const Customer({
    required this.id,
    required this.name,
    this.phone,
    required this.address,
    required this.totalDebt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['address'] = Variable<String>(address);
    map['total_debt'] = Variable<double>(totalDebt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      name: Value(name),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      address: Value(address),
      totalDebt: Value(totalDebt),
      createdAt: Value(createdAt),
    );
  }

  factory Customer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Customer(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      address: serializer.fromJson<String>(json['address']),
      totalDebt: serializer.fromJson<double>(json['totalDebt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'address': serializer.toJson<String>(address),
      'totalDebt': serializer.toJson<double>(totalDebt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Customer copyWith({
    int? id,
    String? name,
    Value<String?> phone = const Value.absent(),
    String? address,
    double? totalDebt,
    DateTime? createdAt,
  }) => Customer(
    id: id ?? this.id,
    name: name ?? this.name,
    phone: phone.present ? phone.value : this.phone,
    address: address ?? this.address,
    totalDebt: totalDebt ?? this.totalDebt,
    createdAt: createdAt ?? this.createdAt,
  );
  Customer copyWithCompanion(CustomersCompanion data) {
    return Customer(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      totalDebt: data.totalDebt.present ? data.totalDebt.value : this.totalDebt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('totalDebt: $totalDebt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, phone, address, totalDebt, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.totalDebt == this.totalDebt &&
          other.createdAt == this.createdAt);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> phone;
  final Value<String> address;
  final Value<double> totalDebt;
  final Value<DateTime> createdAt;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.totalDebt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CustomersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.totalDebt = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Customer> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<double>? totalDebt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (totalDebt != null) 'total_debt': totalDebt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CustomersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? phone,
    Value<String>? address,
    Value<double>? totalDebt,
    Value<DateTime>? createdAt,
  }) {
    return CustomersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      totalDebt: totalDebt ?? this.totalDebt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (totalDebt.present) {
      map['total_debt'] = Variable<double>(totalDebt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('totalDebt: $totalDebt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $InvoicesTable extends Invoices with TableInfo<$InvoicesTable, Invoice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _invoiceNumberMeta = const VerificationMeta(
    'invoiceNumber',
  );
  @override
  late final GeneratedColumn<String> invoiceNumber = GeneratedColumn<String>(
    'invoice_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES customers (id)',
    ),
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountMeta = const VerificationMeta(
    'discount',
  );
  @override
  late final GeneratedColumn<double> discount = GeneratedColumn<double>(
    'discount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _taxMeta = const VerificationMeta('tax');
  @override
  late final GeneratedColumn<double> tax = GeneratedColumn<double>(
    'tax',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _netAmountMeta = const VerificationMeta(
    'netAmount',
  );
  @override
  late final GeneratedColumn<double> netAmount = GeneratedColumn<double>(
    'net_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profitMeta = const VerificationMeta('profit');
  @override
  late final GeneratedColumn<double> profit = GeneratedColumn<double>(
    'profit',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _paidAmountMeta = const VerificationMeta(
    'paidAmount',
  );
  @override
  late final GeneratedColumn<double> paidAmount = GeneratedColumn<double>(
    'paid_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _remainingAmountMeta = const VerificationMeta(
    'remainingAmount',
  );
  @override
  late final GeneratedColumn<double> remainingAmount = GeneratedColumn<double>(
    'remaining_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('cash'),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('completed'),
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    invoiceNumber,
    userId,
    customerId,
    totalAmount,
    discount,
    tax,
    netAmount,
    profit,
    paidAmount,
    remainingAmount,
    paymentMethod,
    status,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoices';
  @override
  VerificationContext validateIntegrity(
    Insertable<Invoice> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('invoice_number')) {
      context.handle(
        _invoiceNumberMeta,
        invoiceNumber.isAcceptableOrUnknown(
          data['invoice_number']!,
          _invoiceNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_invoiceNumberMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('discount')) {
      context.handle(
        _discountMeta,
        discount.isAcceptableOrUnknown(data['discount']!, _discountMeta),
      );
    }
    if (data.containsKey('tax')) {
      context.handle(
        _taxMeta,
        tax.isAcceptableOrUnknown(data['tax']!, _taxMeta),
      );
    }
    if (data.containsKey('net_amount')) {
      context.handle(
        _netAmountMeta,
        netAmount.isAcceptableOrUnknown(data['net_amount']!, _netAmountMeta),
      );
    } else if (isInserting) {
      context.missing(_netAmountMeta);
    }
    if (data.containsKey('profit')) {
      context.handle(
        _profitMeta,
        profit.isAcceptableOrUnknown(data['profit']!, _profitMeta),
      );
    }
    if (data.containsKey('paid_amount')) {
      context.handle(
        _paidAmountMeta,
        paidAmount.isAcceptableOrUnknown(data['paid_amount']!, _paidAmountMeta),
      );
    }
    if (data.containsKey('remaining_amount')) {
      context.handle(
        _remainingAmountMeta,
        remainingAmount.isAcceptableOrUnknown(
          data['remaining_amount']!,
          _remainingAmountMeta,
        ),
      );
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Invoice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Invoice(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      invoiceNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_number'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}customer_id'],
      ),
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
      discount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount'],
      )!,
      tax: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax'],
      )!,
      netAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}net_amount'],
      )!,
      profit: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}profit'],
      )!,
      paidAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}paid_amount'],
      )!,
      remainingAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}remaining_amount'],
      )!,
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $InvoicesTable createAlias(String alias) {
    return $InvoicesTable(attachedDatabase, alias);
  }
}

class Invoice extends DataClass implements Insertable<Invoice> {
  /// رقم الفاتورة الداخلي
  final int id;

  /// رقم الفاتورة الظاهر للمستخدم
  final String invoiceNumber;

  /// الكاشير
  final int userId;

  /// العميل (اختياري - بيتسجل غالبًا مع فواتير الآجل)
  final int? customerId;

  /// إجمالي المنتجات قبل الخصم
  final double totalAmount;

  /// الخصم
  final double discount;

  /// الضريبة
  final double tax;

  /// صافي الفاتورة
  final double netAmount;

  /// إجمالي ربح الفاتورة
  final double profit;

  /// المبلغ المدفوع
  final double paidAmount;

  /// المبلغ المتبقي
  final double remainingAmount;

  /// طريقة الدفع
  final String paymentMethod;

  /// الحالة
  final String status;

  /// تاريخ إنشاء الفاتورة
  final DateTime createdAt;
  const Invoice({
    required this.id,
    required this.invoiceNumber,
    required this.userId,
    this.customerId,
    required this.totalAmount,
    required this.discount,
    required this.tax,
    required this.netAmount,
    required this.profit,
    required this.paidAmount,
    required this.remainingAmount,
    required this.paymentMethod,
    required this.status,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['invoice_number'] = Variable<String>(invoiceNumber);
    map['user_id'] = Variable<int>(userId);
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<int>(customerId);
    }
    map['total_amount'] = Variable<double>(totalAmount);
    map['discount'] = Variable<double>(discount);
    map['tax'] = Variable<double>(tax);
    map['net_amount'] = Variable<double>(netAmount);
    map['profit'] = Variable<double>(profit);
    map['paid_amount'] = Variable<double>(paidAmount);
    map['remaining_amount'] = Variable<double>(remainingAmount);
    map['payment_method'] = Variable<String>(paymentMethod);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  InvoicesCompanion toCompanion(bool nullToAbsent) {
    return InvoicesCompanion(
      id: Value(id),
      invoiceNumber: Value(invoiceNumber),
      userId: Value(userId),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      totalAmount: Value(totalAmount),
      discount: Value(discount),
      tax: Value(tax),
      netAmount: Value(netAmount),
      profit: Value(profit),
      paidAmount: Value(paidAmount),
      remainingAmount: Value(remainingAmount),
      paymentMethod: Value(paymentMethod),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory Invoice.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Invoice(
      id: serializer.fromJson<int>(json['id']),
      invoiceNumber: serializer.fromJson<String>(json['invoiceNumber']),
      userId: serializer.fromJson<int>(json['userId']),
      customerId: serializer.fromJson<int?>(json['customerId']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      discount: serializer.fromJson<double>(json['discount']),
      tax: serializer.fromJson<double>(json['tax']),
      netAmount: serializer.fromJson<double>(json['netAmount']),
      profit: serializer.fromJson<double>(json['profit']),
      paidAmount: serializer.fromJson<double>(json['paidAmount']),
      remainingAmount: serializer.fromJson<double>(json['remainingAmount']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'invoiceNumber': serializer.toJson<String>(invoiceNumber),
      'userId': serializer.toJson<int>(userId),
      'customerId': serializer.toJson<int?>(customerId),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'discount': serializer.toJson<double>(discount),
      'tax': serializer.toJson<double>(tax),
      'netAmount': serializer.toJson<double>(netAmount),
      'profit': serializer.toJson<double>(profit),
      'paidAmount': serializer.toJson<double>(paidAmount),
      'remainingAmount': serializer.toJson<double>(remainingAmount),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Invoice copyWith({
    int? id,
    String? invoiceNumber,
    int? userId,
    Value<int?> customerId = const Value.absent(),
    double? totalAmount,
    double? discount,
    double? tax,
    double? netAmount,
    double? profit,
    double? paidAmount,
    double? remainingAmount,
    String? paymentMethod,
    String? status,
    DateTime? createdAt,
  }) => Invoice(
    id: id ?? this.id,
    invoiceNumber: invoiceNumber ?? this.invoiceNumber,
    userId: userId ?? this.userId,
    customerId: customerId.present ? customerId.value : this.customerId,
    totalAmount: totalAmount ?? this.totalAmount,
    discount: discount ?? this.discount,
    tax: tax ?? this.tax,
    netAmount: netAmount ?? this.netAmount,
    profit: profit ?? this.profit,
    paidAmount: paidAmount ?? this.paidAmount,
    remainingAmount: remainingAmount ?? this.remainingAmount,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
  );
  Invoice copyWithCompanion(InvoicesCompanion data) {
    return Invoice(
      id: data.id.present ? data.id.value : this.id,
      invoiceNumber: data.invoiceNumber.present
          ? data.invoiceNumber.value
          : this.invoiceNumber,
      userId: data.userId.present ? data.userId.value : this.userId,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      discount: data.discount.present ? data.discount.value : this.discount,
      tax: data.tax.present ? data.tax.value : this.tax,
      netAmount: data.netAmount.present ? data.netAmount.value : this.netAmount,
      profit: data.profit.present ? data.profit.value : this.profit,
      paidAmount: data.paidAmount.present
          ? data.paidAmount.value
          : this.paidAmount,
      remainingAmount: data.remainingAmount.present
          ? data.remainingAmount.value
          : this.remainingAmount,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Invoice(')
          ..write('id: $id, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('userId: $userId, ')
          ..write('customerId: $customerId, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('discount: $discount, ')
          ..write('tax: $tax, ')
          ..write('netAmount: $netAmount, ')
          ..write('profit: $profit, ')
          ..write('paidAmount: $paidAmount, ')
          ..write('remainingAmount: $remainingAmount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    invoiceNumber,
    userId,
    customerId,
    totalAmount,
    discount,
    tax,
    netAmount,
    profit,
    paidAmount,
    remainingAmount,
    paymentMethod,
    status,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Invoice &&
          other.id == this.id &&
          other.invoiceNumber == this.invoiceNumber &&
          other.userId == this.userId &&
          other.customerId == this.customerId &&
          other.totalAmount == this.totalAmount &&
          other.discount == this.discount &&
          other.tax == this.tax &&
          other.netAmount == this.netAmount &&
          other.profit == this.profit &&
          other.paidAmount == this.paidAmount &&
          other.remainingAmount == this.remainingAmount &&
          other.paymentMethod == this.paymentMethod &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class InvoicesCompanion extends UpdateCompanion<Invoice> {
  final Value<int> id;
  final Value<String> invoiceNumber;
  final Value<int> userId;
  final Value<int?> customerId;
  final Value<double> totalAmount;
  final Value<double> discount;
  final Value<double> tax;
  final Value<double> netAmount;
  final Value<double> profit;
  final Value<double> paidAmount;
  final Value<double> remainingAmount;
  final Value<String> paymentMethod;
  final Value<String> status;
  final Value<DateTime> createdAt;
  const InvoicesCompanion({
    this.id = const Value.absent(),
    this.invoiceNumber = const Value.absent(),
    this.userId = const Value.absent(),
    this.customerId = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.discount = const Value.absent(),
    this.tax = const Value.absent(),
    this.netAmount = const Value.absent(),
    this.profit = const Value.absent(),
    this.paidAmount = const Value.absent(),
    this.remainingAmount = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  InvoicesCompanion.insert({
    this.id = const Value.absent(),
    required String invoiceNumber,
    required int userId,
    this.customerId = const Value.absent(),
    required double totalAmount,
    this.discount = const Value.absent(),
    this.tax = const Value.absent(),
    required double netAmount,
    this.profit = const Value.absent(),
    this.paidAmount = const Value.absent(),
    this.remainingAmount = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : invoiceNumber = Value(invoiceNumber),
       userId = Value(userId),
       totalAmount = Value(totalAmount),
       netAmount = Value(netAmount);
  static Insertable<Invoice> custom({
    Expression<int>? id,
    Expression<String>? invoiceNumber,
    Expression<int>? userId,
    Expression<int>? customerId,
    Expression<double>? totalAmount,
    Expression<double>? discount,
    Expression<double>? tax,
    Expression<double>? netAmount,
    Expression<double>? profit,
    Expression<double>? paidAmount,
    Expression<double>? remainingAmount,
    Expression<String>? paymentMethod,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceNumber != null) 'invoice_number': invoiceNumber,
      if (userId != null) 'user_id': userId,
      if (customerId != null) 'customer_id': customerId,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (discount != null) 'discount': discount,
      if (tax != null) 'tax': tax,
      if (netAmount != null) 'net_amount': netAmount,
      if (profit != null) 'profit': profit,
      if (paidAmount != null) 'paid_amount': paidAmount,
      if (remainingAmount != null) 'remaining_amount': remainingAmount,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  InvoicesCompanion copyWith({
    Value<int>? id,
    Value<String>? invoiceNumber,
    Value<int>? userId,
    Value<int?>? customerId,
    Value<double>? totalAmount,
    Value<double>? discount,
    Value<double>? tax,
    Value<double>? netAmount,
    Value<double>? profit,
    Value<double>? paidAmount,
    Value<double>? remainingAmount,
    Value<String>? paymentMethod,
    Value<String>? status,
    Value<DateTime>? createdAt,
  }) {
    return InvoicesCompanion(
      id: id ?? this.id,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      userId: userId ?? this.userId,
      customerId: customerId ?? this.customerId,
      totalAmount: totalAmount ?? this.totalAmount,
      discount: discount ?? this.discount,
      tax: tax ?? this.tax,
      netAmount: netAmount ?? this.netAmount,
      profit: profit ?? this.profit,
      paidAmount: paidAmount ?? this.paidAmount,
      remainingAmount: remainingAmount ?? this.remainingAmount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (invoiceNumber.present) {
      map['invoice_number'] = Variable<String>(invoiceNumber.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (discount.present) {
      map['discount'] = Variable<double>(discount.value);
    }
    if (tax.present) {
      map['tax'] = Variable<double>(tax.value);
    }
    if (netAmount.present) {
      map['net_amount'] = Variable<double>(netAmount.value);
    }
    if (profit.present) {
      map['profit'] = Variable<double>(profit.value);
    }
    if (paidAmount.present) {
      map['paid_amount'] = Variable<double>(paidAmount.value);
    }
    if (remainingAmount.present) {
      map['remaining_amount'] = Variable<double>(remainingAmount.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoicesCompanion(')
          ..write('id: $id, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('userId: $userId, ')
          ..write('customerId: $customerId, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('discount: $discount, ')
          ..write('tax: $tax, ')
          ..write('netAmount: $netAmount, ')
          ..write('profit: $profit, ')
          ..write('paidAmount: $paidAmount, ')
          ..write('remainingAmount: $remainingAmount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $InvoiceItemsTable extends InvoiceItems
    with TableInfo<$InvoiceItemsTable, InvoiceItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoiceItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<int> invoiceId = GeneratedColumn<int>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES invoices (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id)',
    ),
  );
  static const VerificationMeta _productNameMeta = const VerificationMeta(
    'productName',
  );
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
    'product_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    false,
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
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _purchasePriceMeta = const VerificationMeta(
    'purchasePrice',
  );
  @override
  late final GeneratedColumn<double> purchasePrice = GeneratedColumn<double>(
    'purchase_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
    'unit_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalPriceMeta = const VerificationMeta(
    'totalPrice',
  );
  @override
  late final GeneratedColumn<double> totalPrice = GeneratedColumn<double>(
    'total_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profitMeta = const VerificationMeta('profit');
  @override
  late final GeneratedColumn<double> profit = GeneratedColumn<double>(
    'profit',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    invoiceId,
    productId,
    productName,
    barcode,
    category,
    unit,
    purchasePrice,
    unitPrice,
    quantity,
    totalPrice,
    profit,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoice_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<InvoiceItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('product_name')) {
      context.handle(
        _productNameMeta,
        productName.isAcceptableOrUnknown(
          data['product_name']!,
          _productNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
      );
    } else if (isInserting) {
      context.missing(_barcodeMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('purchase_price')) {
      context.handle(
        _purchasePriceMeta,
        purchasePrice.isAcceptableOrUnknown(
          data['purchase_price']!,
          _purchasePriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchasePriceMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('total_price')) {
      context.handle(
        _totalPriceMeta,
        totalPrice.isAcceptableOrUnknown(data['total_price']!, _totalPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_totalPriceMeta);
    }
    if (data.containsKey('profit')) {
      context.handle(
        _profitMeta,
        profit.isAcceptableOrUnknown(data['profit']!, _profitMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvoiceItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvoiceItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}invoice_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      productName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_name'],
      )!,
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      purchasePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}purchase_price'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_price'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      totalPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_price'],
      )!,
      profit: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}profit'],
      )!,
    );
  }

  @override
  $InvoiceItemsTable createAlias(String alias) {
    return $InvoiceItemsTable(attachedDatabase, alias);
  }
}

class InvoiceItem extends DataClass implements Insertable<InvoiceItem> {
  final int id;
  final int invoiceId;
  final int productId;
  final String productName;
  final String barcode;

  /// أضف هذا العمود
  final String category;
  final String unit;
  final double purchasePrice;
  final double unitPrice;
  final int quantity;
  final double totalPrice;

  /// إجمالي ربح الصنف
  final double profit;
  const InvoiceItem({
    required this.id,
    required this.invoiceId,
    required this.productId,
    required this.productName,
    required this.barcode,
    required this.category,
    required this.unit,
    required this.purchasePrice,
    required this.unitPrice,
    required this.quantity,
    required this.totalPrice,
    required this.profit,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['invoice_id'] = Variable<int>(invoiceId);
    map['product_id'] = Variable<int>(productId);
    map['product_name'] = Variable<String>(productName);
    map['barcode'] = Variable<String>(barcode);
    map['category'] = Variable<String>(category);
    map['unit'] = Variable<String>(unit);
    map['purchase_price'] = Variable<double>(purchasePrice);
    map['unit_price'] = Variable<double>(unitPrice);
    map['quantity'] = Variable<int>(quantity);
    map['total_price'] = Variable<double>(totalPrice);
    map['profit'] = Variable<double>(profit);
    return map;
  }

  InvoiceItemsCompanion toCompanion(bool nullToAbsent) {
    return InvoiceItemsCompanion(
      id: Value(id),
      invoiceId: Value(invoiceId),
      productId: Value(productId),
      productName: Value(productName),
      barcode: Value(barcode),
      category: Value(category),
      unit: Value(unit),
      purchasePrice: Value(purchasePrice),
      unitPrice: Value(unitPrice),
      quantity: Value(quantity),
      totalPrice: Value(totalPrice),
      profit: Value(profit),
    );
  }

  factory InvoiceItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvoiceItem(
      id: serializer.fromJson<int>(json['id']),
      invoiceId: serializer.fromJson<int>(json['invoiceId']),
      productId: serializer.fromJson<int>(json['productId']),
      productName: serializer.fromJson<String>(json['productName']),
      barcode: serializer.fromJson<String>(json['barcode']),
      category: serializer.fromJson<String>(json['category']),
      unit: serializer.fromJson<String>(json['unit']),
      purchasePrice: serializer.fromJson<double>(json['purchasePrice']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      quantity: serializer.fromJson<int>(json['quantity']),
      totalPrice: serializer.fromJson<double>(json['totalPrice']),
      profit: serializer.fromJson<double>(json['profit']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'invoiceId': serializer.toJson<int>(invoiceId),
      'productId': serializer.toJson<int>(productId),
      'productName': serializer.toJson<String>(productName),
      'barcode': serializer.toJson<String>(barcode),
      'category': serializer.toJson<String>(category),
      'unit': serializer.toJson<String>(unit),
      'purchasePrice': serializer.toJson<double>(purchasePrice),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'quantity': serializer.toJson<int>(quantity),
      'totalPrice': serializer.toJson<double>(totalPrice),
      'profit': serializer.toJson<double>(profit),
    };
  }

  InvoiceItem copyWith({
    int? id,
    int? invoiceId,
    int? productId,
    String? productName,
    String? barcode,
    String? category,
    String? unit,
    double? purchasePrice,
    double? unitPrice,
    int? quantity,
    double? totalPrice,
    double? profit,
  }) => InvoiceItem(
    id: id ?? this.id,
    invoiceId: invoiceId ?? this.invoiceId,
    productId: productId ?? this.productId,
    productName: productName ?? this.productName,
    barcode: barcode ?? this.barcode,
    category: category ?? this.category,
    unit: unit ?? this.unit,
    purchasePrice: purchasePrice ?? this.purchasePrice,
    unitPrice: unitPrice ?? this.unitPrice,
    quantity: quantity ?? this.quantity,
    totalPrice: totalPrice ?? this.totalPrice,
    profit: profit ?? this.profit,
  );
  InvoiceItem copyWithCompanion(InvoiceItemsCompanion data) {
    return InvoiceItem(
      id: data.id.present ? data.id.value : this.id,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      productId: data.productId.present ? data.productId.value : this.productId,
      productName: data.productName.present
          ? data.productName.value
          : this.productName,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      category: data.category.present ? data.category.value : this.category,
      unit: data.unit.present ? data.unit.value : this.unit,
      purchasePrice: data.purchasePrice.present
          ? data.purchasePrice.value
          : this.purchasePrice,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      totalPrice: data.totalPrice.present
          ? data.totalPrice.value
          : this.totalPrice,
      profit: data.profit.present ? data.profit.value : this.profit,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceItem(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('barcode: $barcode, ')
          ..write('category: $category, ')
          ..write('unit: $unit, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('quantity: $quantity, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('profit: $profit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    invoiceId,
    productId,
    productName,
    barcode,
    category,
    unit,
    purchasePrice,
    unitPrice,
    quantity,
    totalPrice,
    profit,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvoiceItem &&
          other.id == this.id &&
          other.invoiceId == this.invoiceId &&
          other.productId == this.productId &&
          other.productName == this.productName &&
          other.barcode == this.barcode &&
          other.category == this.category &&
          other.unit == this.unit &&
          other.purchasePrice == this.purchasePrice &&
          other.unitPrice == this.unitPrice &&
          other.quantity == this.quantity &&
          other.totalPrice == this.totalPrice &&
          other.profit == this.profit);
}

class InvoiceItemsCompanion extends UpdateCompanion<InvoiceItem> {
  final Value<int> id;
  final Value<int> invoiceId;
  final Value<int> productId;
  final Value<String> productName;
  final Value<String> barcode;
  final Value<String> category;
  final Value<String> unit;
  final Value<double> purchasePrice;
  final Value<double> unitPrice;
  final Value<int> quantity;
  final Value<double> totalPrice;
  final Value<double> profit;
  const InvoiceItemsCompanion({
    this.id = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.productId = const Value.absent(),
    this.productName = const Value.absent(),
    this.barcode = const Value.absent(),
    this.category = const Value.absent(),
    this.unit = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.quantity = const Value.absent(),
    this.totalPrice = const Value.absent(),
    this.profit = const Value.absent(),
  });
  InvoiceItemsCompanion.insert({
    this.id = const Value.absent(),
    required int invoiceId,
    required int productId,
    required String productName,
    required String barcode,
    required String category,
    required String unit,
    required double purchasePrice,
    required double unitPrice,
    required int quantity,
    required double totalPrice,
    this.profit = const Value.absent(),
  }) : invoiceId = Value(invoiceId),
       productId = Value(productId),
       productName = Value(productName),
       barcode = Value(barcode),
       category = Value(category),
       unit = Value(unit),
       purchasePrice = Value(purchasePrice),
       unitPrice = Value(unitPrice),
       quantity = Value(quantity),
       totalPrice = Value(totalPrice);
  static Insertable<InvoiceItem> custom({
    Expression<int>? id,
    Expression<int>? invoiceId,
    Expression<int>? productId,
    Expression<String>? productName,
    Expression<String>? barcode,
    Expression<String>? category,
    Expression<String>? unit,
    Expression<double>? purchasePrice,
    Expression<double>? unitPrice,
    Expression<int>? quantity,
    Expression<double>? totalPrice,
    Expression<double>? profit,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (productId != null) 'product_id': productId,
      if (productName != null) 'product_name': productName,
      if (barcode != null) 'barcode': barcode,
      if (category != null) 'category': category,
      if (unit != null) 'unit': unit,
      if (purchasePrice != null) 'purchase_price': purchasePrice,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (quantity != null) 'quantity': quantity,
      if (totalPrice != null) 'total_price': totalPrice,
      if (profit != null) 'profit': profit,
    });
  }

  InvoiceItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? invoiceId,
    Value<int>? productId,
    Value<String>? productName,
    Value<String>? barcode,
    Value<String>? category,
    Value<String>? unit,
    Value<double>? purchasePrice,
    Value<double>? unitPrice,
    Value<int>? quantity,
    Value<double>? totalPrice,
    Value<double>? profit,
  }) {
    return InvoiceItemsCompanion(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      barcode: barcode ?? this.barcode,
      category: category ?? this.category,
      unit: unit ?? this.unit,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      unitPrice: unitPrice ?? this.unitPrice,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
      profit: profit ?? this.profit,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<int>(invoiceId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (purchasePrice.present) {
      map['purchase_price'] = Variable<double>(purchasePrice.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (totalPrice.present) {
      map['total_price'] = Variable<double>(totalPrice.value);
    }
    if (profit.present) {
      map['profit'] = Variable<double>(profit.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceItemsCompanion(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('barcode: $barcode, ')
          ..write('category: $category, ')
          ..write('unit: $unit, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('quantity: $quantity, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('profit: $profit')
          ..write(')'))
        .toString();
  }
}

class $StockMovementsTable extends StockMovements
    with TableInfo<$StockMovementsTable, StockMovement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockMovementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id)',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    userId,
    quantity,
    type,
    note,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stock_movements';
  @override
  VerificationContext validateIntegrity(
    Insertable<StockMovement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockMovement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockMovement(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $StockMovementsTable createAlias(String alias) {
    return $StockMovementsTable(attachedDatabase, alias);
  }
}

class StockMovement extends DataClass implements Insertable<StockMovement> {
  final int id;

  /// المنتج
  final int productId;

  /// المستخدم الذي قام بالحركة
  final int userId;

  /// كمية الحركة
  final int quantity;

  /// نوع الحركة
  /// purchase
  /// sale
  /// adjustment
  /// damaged
  /// return
  final String type;

  /// ملاحظات
  final String? note;

  /// تاريخ الحركة
  final DateTime createdAt;
  const StockMovement({
    required this.id,
    required this.productId,
    required this.userId,
    required this.quantity,
    required this.type,
    this.note,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    map['user_id'] = Variable<int>(userId);
    map['quantity'] = Variable<int>(quantity);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  StockMovementsCompanion toCompanion(bool nullToAbsent) {
    return StockMovementsCompanion(
      id: Value(id),
      productId: Value(productId),
      userId: Value(userId),
      quantity: Value(quantity),
      type: Value(type),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
    );
  }

  factory StockMovement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockMovement(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      userId: serializer.fromJson<int>(json['userId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      type: serializer.fromJson<String>(json['type']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'userId': serializer.toJson<int>(userId),
      'quantity': serializer.toJson<int>(quantity),
      'type': serializer.toJson<String>(type),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  StockMovement copyWith({
    int? id,
    int? productId,
    int? userId,
    int? quantity,
    String? type,
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
  }) => StockMovement(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    userId: userId ?? this.userId,
    quantity: quantity ?? this.quantity,
    type: type ?? this.type,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
  );
  StockMovement copyWithCompanion(StockMovementsCompanion data) {
    return StockMovement(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      userId: data.userId.present ? data.userId.value : this.userId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      type: data.type.present ? data.type.value : this.type,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockMovement(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('userId: $userId, ')
          ..write('quantity: $quantity, ')
          ..write('type: $type, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, productId, userId, quantity, type, note, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockMovement &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.userId == this.userId &&
          other.quantity == this.quantity &&
          other.type == this.type &&
          other.note == this.note &&
          other.createdAt == this.createdAt);
}

class StockMovementsCompanion extends UpdateCompanion<StockMovement> {
  final Value<int> id;
  final Value<int> productId;
  final Value<int> userId;
  final Value<int> quantity;
  final Value<String> type;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  const StockMovementsCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.userId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.type = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  StockMovementsCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    required int userId,
    required int quantity,
    required String type,
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : productId = Value(productId),
       userId = Value(userId),
       quantity = Value(quantity),
       type = Value(type);
  static Insertable<StockMovement> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<int>? userId,
    Expression<int>? quantity,
    Expression<String>? type,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (userId != null) 'user_id': userId,
      if (quantity != null) 'quantity': quantity,
      if (type != null) 'type': type,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  StockMovementsCompanion copyWith({
    Value<int>? id,
    Value<int>? productId,
    Value<int>? userId,
    Value<int>? quantity,
    Value<String>? type,
    Value<String?>? note,
    Value<DateTime>? createdAt,
  }) {
    return StockMovementsCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      userId: userId ?? this.userId,
      quantity: quantity ?? this.quantity,
      type: type ?? this.type,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockMovementsCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('userId: $userId, ')
          ..write('quantity: $quantity, ')
          ..write('type: $type, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SuppliersTable extends Suppliers
    with TableInfo<$SuppliersTable, Supplier> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SuppliersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, phone, address, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'suppliers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Supplier> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Supplier map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Supplier(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SuppliersTable createAlias(String alias) {
    return $SuppliersTable(attachedDatabase, alias);
  }
}

class Supplier extends DataClass implements Insertable<Supplier> {
  final int id;
  final String name;
  final String? phone;
  final String? address;
  final DateTime createdAt;
  const Supplier({
    required this.id,
    required this.name,
    this.phone,
    this.address,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SuppliersCompanion toCompanion(bool nullToAbsent) {
    return SuppliersCompanion(
      id: Value(id),
      name: Value(name),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      createdAt: Value(createdAt),
    );
  }

  factory Supplier.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Supplier(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      address: serializer.fromJson<String?>(json['address']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'address': serializer.toJson<String?>(address),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Supplier copyWith({
    int? id,
    String? name,
    Value<String?> phone = const Value.absent(),
    Value<String?> address = const Value.absent(),
    DateTime? createdAt,
  }) => Supplier(
    id: id ?? this.id,
    name: name ?? this.name,
    phone: phone.present ? phone.value : this.phone,
    address: address.present ? address.value : this.address,
    createdAt: createdAt ?? this.createdAt,
  );
  Supplier copyWithCompanion(SuppliersCompanion data) {
    return Supplier(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Supplier(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, phone, address, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Supplier &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.createdAt == this.createdAt);
}

class SuppliersCompanion extends UpdateCompanion<Supplier> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> phone;
  final Value<String?> address;
  final Value<DateTime> createdAt;
  const SuppliersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SuppliersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Supplier> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SuppliersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? phone,
    Value<String?>? address,
    Value<DateTime>? createdAt,
  }) {
    return SuppliersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SuppliersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PurchasesTable extends Purchases
    with TableInfo<$PurchasesTable, Purchase> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchasesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _supplierIdMeta = const VerificationMeta(
    'supplierId',
  );
  @override
  late final GeneratedColumn<int> supplierId = GeneratedColumn<int>(
    'supplier_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES suppliers (id)',
    ),
  );
  static const VerificationMeta _invoiceNumberMeta = const VerificationMeta(
    'invoiceNumber',
  );
  @override
  late final GeneratedColumn<String> invoiceNumber = GeneratedColumn<String>(
    'invoice_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountMeta = const VerificationMeta(
    'discount',
  );
  @override
  late final GeneratedColumn<double> discount = GeneratedColumn<double>(
    'discount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _taxMeta = const VerificationMeta('tax');
  @override
  late final GeneratedColumn<double> tax = GeneratedColumn<double>(
    'tax',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _netTotalMeta = const VerificationMeta(
    'netTotal',
  );
  @override
  late final GeneratedColumn<double> netTotal = GeneratedColumn<double>(
    'net_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    supplierId,
    invoiceNumber,
    total,
    discount,
    tax,
    netTotal,
    paymentMethod,
    dueDate,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchases';
  @override
  VerificationContext validateIntegrity(
    Insertable<Purchase> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
        _supplierIdMeta,
        supplierId.isAcceptableOrUnknown(data['supplier_id']!, _supplierIdMeta),
      );
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    if (data.containsKey('invoice_number')) {
      context.handle(
        _invoiceNumberMeta,
        invoiceNumber.isAcceptableOrUnknown(
          data['invoice_number']!,
          _invoiceNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_invoiceNumberMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('discount')) {
      context.handle(
        _discountMeta,
        discount.isAcceptableOrUnknown(data['discount']!, _discountMeta),
      );
    }
    if (data.containsKey('tax')) {
      context.handle(
        _taxMeta,
        tax.isAcceptableOrUnknown(data['tax']!, _taxMeta),
      );
    }
    if (data.containsKey('net_total')) {
      context.handle(
        _netTotalMeta,
        netTotal.isAcceptableOrUnknown(data['net_total']!, _netTotalMeta),
      );
    } else if (isInserting) {
      context.missing(_netTotalMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentMethodMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Purchase map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Purchase(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      supplierId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}supplier_id'],
      )!,
      invoiceNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_number'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total'],
      )!,
      discount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount'],
      )!,
      tax: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax'],
      )!,
      netTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}net_total'],
      )!,
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PurchasesTable createAlias(String alias) {
    return $PurchasesTable(attachedDatabase, alias);
  }
}

class Purchase extends DataClass implements Insertable<Purchase> {
  final int id;
  final int supplierId;
  final String invoiceNumber;
  final double total;
  final double discount;
  final double tax;
  final double netTotal;
  final String paymentMethod;
  final DateTime? dueDate;
  final DateTime createdAt;
  const Purchase({
    required this.id,
    required this.supplierId,
    required this.invoiceNumber,
    required this.total,
    required this.discount,
    required this.tax,
    required this.netTotal,
    required this.paymentMethod,
    this.dueDate,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['supplier_id'] = Variable<int>(supplierId);
    map['invoice_number'] = Variable<String>(invoiceNumber);
    map['total'] = Variable<double>(total);
    map['discount'] = Variable<double>(discount);
    map['tax'] = Variable<double>(tax);
    map['net_total'] = Variable<double>(netTotal);
    map['payment_method'] = Variable<String>(paymentMethod);
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PurchasesCompanion toCompanion(bool nullToAbsent) {
    return PurchasesCompanion(
      id: Value(id),
      supplierId: Value(supplierId),
      invoiceNumber: Value(invoiceNumber),
      total: Value(total),
      discount: Value(discount),
      tax: Value(tax),
      netTotal: Value(netTotal),
      paymentMethod: Value(paymentMethod),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      createdAt: Value(createdAt),
    );
  }

  factory Purchase.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Purchase(
      id: serializer.fromJson<int>(json['id']),
      supplierId: serializer.fromJson<int>(json['supplierId']),
      invoiceNumber: serializer.fromJson<String>(json['invoiceNumber']),
      total: serializer.fromJson<double>(json['total']),
      discount: serializer.fromJson<double>(json['discount']),
      tax: serializer.fromJson<double>(json['tax']),
      netTotal: serializer.fromJson<double>(json['netTotal']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'supplierId': serializer.toJson<int>(supplierId),
      'invoiceNumber': serializer.toJson<String>(invoiceNumber),
      'total': serializer.toJson<double>(total),
      'discount': serializer.toJson<double>(discount),
      'tax': serializer.toJson<double>(tax),
      'netTotal': serializer.toJson<double>(netTotal),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Purchase copyWith({
    int? id,
    int? supplierId,
    String? invoiceNumber,
    double? total,
    double? discount,
    double? tax,
    double? netTotal,
    String? paymentMethod,
    Value<DateTime?> dueDate = const Value.absent(),
    DateTime? createdAt,
  }) => Purchase(
    id: id ?? this.id,
    supplierId: supplierId ?? this.supplierId,
    invoiceNumber: invoiceNumber ?? this.invoiceNumber,
    total: total ?? this.total,
    discount: discount ?? this.discount,
    tax: tax ?? this.tax,
    netTotal: netTotal ?? this.netTotal,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    dueDate: dueDate.present ? dueDate.value : this.dueDate,
    createdAt: createdAt ?? this.createdAt,
  );
  Purchase copyWithCompanion(PurchasesCompanion data) {
    return Purchase(
      id: data.id.present ? data.id.value : this.id,
      supplierId: data.supplierId.present
          ? data.supplierId.value
          : this.supplierId,
      invoiceNumber: data.invoiceNumber.present
          ? data.invoiceNumber.value
          : this.invoiceNumber,
      total: data.total.present ? data.total.value : this.total,
      discount: data.discount.present ? data.discount.value : this.discount,
      tax: data.tax.present ? data.tax.value : this.tax,
      netTotal: data.netTotal.present ? data.netTotal.value : this.netTotal,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Purchase(')
          ..write('id: $id, ')
          ..write('supplierId: $supplierId, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('total: $total, ')
          ..write('discount: $discount, ')
          ..write('tax: $tax, ')
          ..write('netTotal: $netTotal, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('dueDate: $dueDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    supplierId,
    invoiceNumber,
    total,
    discount,
    tax,
    netTotal,
    paymentMethod,
    dueDate,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Purchase &&
          other.id == this.id &&
          other.supplierId == this.supplierId &&
          other.invoiceNumber == this.invoiceNumber &&
          other.total == this.total &&
          other.discount == this.discount &&
          other.tax == this.tax &&
          other.netTotal == this.netTotal &&
          other.paymentMethod == this.paymentMethod &&
          other.dueDate == this.dueDate &&
          other.createdAt == this.createdAt);
}

class PurchasesCompanion extends UpdateCompanion<Purchase> {
  final Value<int> id;
  final Value<int> supplierId;
  final Value<String> invoiceNumber;
  final Value<double> total;
  final Value<double> discount;
  final Value<double> tax;
  final Value<double> netTotal;
  final Value<String> paymentMethod;
  final Value<DateTime?> dueDate;
  final Value<DateTime> createdAt;
  const PurchasesCompanion({
    this.id = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.invoiceNumber = const Value.absent(),
    this.total = const Value.absent(),
    this.discount = const Value.absent(),
    this.tax = const Value.absent(),
    this.netTotal = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PurchasesCompanion.insert({
    this.id = const Value.absent(),
    required int supplierId,
    required String invoiceNumber,
    required double total,
    this.discount = const Value.absent(),
    this.tax = const Value.absent(),
    required double netTotal,
    required String paymentMethod,
    this.dueDate = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : supplierId = Value(supplierId),
       invoiceNumber = Value(invoiceNumber),
       total = Value(total),
       netTotal = Value(netTotal),
       paymentMethod = Value(paymentMethod);
  static Insertable<Purchase> custom({
    Expression<int>? id,
    Expression<int>? supplierId,
    Expression<String>? invoiceNumber,
    Expression<double>? total,
    Expression<double>? discount,
    Expression<double>? tax,
    Expression<double>? netTotal,
    Expression<String>? paymentMethod,
    Expression<DateTime>? dueDate,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (supplierId != null) 'supplier_id': supplierId,
      if (invoiceNumber != null) 'invoice_number': invoiceNumber,
      if (total != null) 'total': total,
      if (discount != null) 'discount': discount,
      if (tax != null) 'tax': tax,
      if (netTotal != null) 'net_total': netTotal,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (dueDate != null) 'due_date': dueDate,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PurchasesCompanion copyWith({
    Value<int>? id,
    Value<int>? supplierId,
    Value<String>? invoiceNumber,
    Value<double>? total,
    Value<double>? discount,
    Value<double>? tax,
    Value<double>? netTotal,
    Value<String>? paymentMethod,
    Value<DateTime?>? dueDate,
    Value<DateTime>? createdAt,
  }) {
    return PurchasesCompanion(
      id: id ?? this.id,
      supplierId: supplierId ?? this.supplierId,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      total: total ?? this.total,
      discount: discount ?? this.discount,
      tax: tax ?? this.tax,
      netTotal: netTotal ?? this.netTotal,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<int>(supplierId.value);
    }
    if (invoiceNumber.present) {
      map['invoice_number'] = Variable<String>(invoiceNumber.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (discount.present) {
      map['discount'] = Variable<double>(discount.value);
    }
    if (tax.present) {
      map['tax'] = Variable<double>(tax.value);
    }
    if (netTotal.present) {
      map['net_total'] = Variable<double>(netTotal.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchasesCompanion(')
          ..write('id: $id, ')
          ..write('supplierId: $supplierId, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('total: $total, ')
          ..write('discount: $discount, ')
          ..write('tax: $tax, ')
          ..write('netTotal: $netTotal, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('dueDate: $dueDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PurchaseItemsTable extends PurchaseItems
    with TableInfo<$PurchaseItemsTable, PurchaseItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchaseItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _purchaseIdMeta = const VerificationMeta(
    'purchaseId',
  );
  @override
  late final GeneratedColumn<int> purchaseId = GeneratedColumn<int>(
    'purchase_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES purchases (id)',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id)',
    ),
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cartonQuantityMeta = const VerificationMeta(
    'cartonQuantity',
  );
  @override
  late final GeneratedColumn<double> cartonQuantity = GeneratedColumn<double>(
    'carton_quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _unitsPerCartonMeta = const VerificationMeta(
    'unitsPerCarton',
  );
  @override
  late final GeneratedColumn<int> unitsPerCarton = GeneratedColumn<int>(
    'units_per_carton',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _purchasePriceMeta = const VerificationMeta(
    'purchasePrice',
  );
  @override
  late final GeneratedColumn<double> purchasePrice = GeneratedColumn<double>(
    'purchase_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _salePriceMeta = const VerificationMeta(
    'salePrice',
  );
  @override
  late final GeneratedColumn<double> salePrice = GeneratedColumn<double>(
    'sale_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    purchaseId,
    productId,
    quantity,
    cartonQuantity,
    unitsPerCarton,
    purchasePrice,
    salePrice,
    total,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchase_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<PurchaseItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('purchase_id')) {
      context.handle(
        _purchaseIdMeta,
        purchaseId.isAcceptableOrUnknown(data['purchase_id']!, _purchaseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_purchaseIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('carton_quantity')) {
      context.handle(
        _cartonQuantityMeta,
        cartonQuantity.isAcceptableOrUnknown(
          data['carton_quantity']!,
          _cartonQuantityMeta,
        ),
      );
    }
    if (data.containsKey('units_per_carton')) {
      context.handle(
        _unitsPerCartonMeta,
        unitsPerCarton.isAcceptableOrUnknown(
          data['units_per_carton']!,
          _unitsPerCartonMeta,
        ),
      );
    }
    if (data.containsKey('purchase_price')) {
      context.handle(
        _purchasePriceMeta,
        purchasePrice.isAcceptableOrUnknown(
          data['purchase_price']!,
          _purchasePriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchasePriceMeta);
    }
    if (data.containsKey('sale_price')) {
      context.handle(
        _salePriceMeta,
        salePrice.isAcceptableOrUnknown(data['sale_price']!, _salePriceMeta),
      );
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PurchaseItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      purchaseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}purchase_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      cartonQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carton_quantity'],
      )!,
      unitsPerCarton: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}units_per_carton'],
      )!,
      purchasePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}purchase_price'],
      )!,
      salePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sale_price'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total'],
      )!,
    );
  }

  @override
  $PurchaseItemsTable createAlias(String alias) {
    return $PurchaseItemsTable(attachedDatabase, alias);
  }
}

class PurchaseItem extends DataClass implements Insertable<PurchaseItem> {
  final int id;
  final int purchaseId;
  final int productId;
  final int quantity;
  final double cartonQuantity;
  final int unitsPerCarton;
  final double purchasePrice;
  final double salePrice;
  final double total;
  const PurchaseItem({
    required this.id,
    required this.purchaseId,
    required this.productId,
    required this.quantity,
    required this.cartonQuantity,
    required this.unitsPerCarton,
    required this.purchasePrice,
    required this.salePrice,
    required this.total,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['purchase_id'] = Variable<int>(purchaseId);
    map['product_id'] = Variable<int>(productId);
    map['quantity'] = Variable<int>(quantity);
    map['carton_quantity'] = Variable<double>(cartonQuantity);
    map['units_per_carton'] = Variable<int>(unitsPerCarton);
    map['purchase_price'] = Variable<double>(purchasePrice);
    map['sale_price'] = Variable<double>(salePrice);
    map['total'] = Variable<double>(total);
    return map;
  }

  PurchaseItemsCompanion toCompanion(bool nullToAbsent) {
    return PurchaseItemsCompanion(
      id: Value(id),
      purchaseId: Value(purchaseId),
      productId: Value(productId),
      quantity: Value(quantity),
      cartonQuantity: Value(cartonQuantity),
      unitsPerCarton: Value(unitsPerCarton),
      purchasePrice: Value(purchasePrice),
      salePrice: Value(salePrice),
      total: Value(total),
    );
  }

  factory PurchaseItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseItem(
      id: serializer.fromJson<int>(json['id']),
      purchaseId: serializer.fromJson<int>(json['purchaseId']),
      productId: serializer.fromJson<int>(json['productId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      cartonQuantity: serializer.fromJson<double>(json['cartonQuantity']),
      unitsPerCarton: serializer.fromJson<int>(json['unitsPerCarton']),
      purchasePrice: serializer.fromJson<double>(json['purchasePrice']),
      salePrice: serializer.fromJson<double>(json['salePrice']),
      total: serializer.fromJson<double>(json['total']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'purchaseId': serializer.toJson<int>(purchaseId),
      'productId': serializer.toJson<int>(productId),
      'quantity': serializer.toJson<int>(quantity),
      'cartonQuantity': serializer.toJson<double>(cartonQuantity),
      'unitsPerCarton': serializer.toJson<int>(unitsPerCarton),
      'purchasePrice': serializer.toJson<double>(purchasePrice),
      'salePrice': serializer.toJson<double>(salePrice),
      'total': serializer.toJson<double>(total),
    };
  }

  PurchaseItem copyWith({
    int? id,
    int? purchaseId,
    int? productId,
    int? quantity,
    double? cartonQuantity,
    int? unitsPerCarton,
    double? purchasePrice,
    double? salePrice,
    double? total,
  }) => PurchaseItem(
    id: id ?? this.id,
    purchaseId: purchaseId ?? this.purchaseId,
    productId: productId ?? this.productId,
    quantity: quantity ?? this.quantity,
    cartonQuantity: cartonQuantity ?? this.cartonQuantity,
    unitsPerCarton: unitsPerCarton ?? this.unitsPerCarton,
    purchasePrice: purchasePrice ?? this.purchasePrice,
    salePrice: salePrice ?? this.salePrice,
    total: total ?? this.total,
  );
  PurchaseItem copyWithCompanion(PurchaseItemsCompanion data) {
    return PurchaseItem(
      id: data.id.present ? data.id.value : this.id,
      purchaseId: data.purchaseId.present
          ? data.purchaseId.value
          : this.purchaseId,
      productId: data.productId.present ? data.productId.value : this.productId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      cartonQuantity: data.cartonQuantity.present
          ? data.cartonQuantity.value
          : this.cartonQuantity,
      unitsPerCarton: data.unitsPerCarton.present
          ? data.unitsPerCarton.value
          : this.unitsPerCarton,
      purchasePrice: data.purchasePrice.present
          ? data.purchasePrice.value
          : this.purchasePrice,
      salePrice: data.salePrice.present ? data.salePrice.value : this.salePrice,
      total: data.total.present ? data.total.value : this.total,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseItem(')
          ..write('id: $id, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('cartonQuantity: $cartonQuantity, ')
          ..write('unitsPerCarton: $unitsPerCarton, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('salePrice: $salePrice, ')
          ..write('total: $total')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    purchaseId,
    productId,
    quantity,
    cartonQuantity,
    unitsPerCarton,
    purchasePrice,
    salePrice,
    total,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseItem &&
          other.id == this.id &&
          other.purchaseId == this.purchaseId &&
          other.productId == this.productId &&
          other.quantity == this.quantity &&
          other.cartonQuantity == this.cartonQuantity &&
          other.unitsPerCarton == this.unitsPerCarton &&
          other.purchasePrice == this.purchasePrice &&
          other.salePrice == this.salePrice &&
          other.total == this.total);
}

class PurchaseItemsCompanion extends UpdateCompanion<PurchaseItem> {
  final Value<int> id;
  final Value<int> purchaseId;
  final Value<int> productId;
  final Value<int> quantity;
  final Value<double> cartonQuantity;
  final Value<int> unitsPerCarton;
  final Value<double> purchasePrice;
  final Value<double> salePrice;
  final Value<double> total;
  const PurchaseItemsCompanion({
    this.id = const Value.absent(),
    this.purchaseId = const Value.absent(),
    this.productId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.cartonQuantity = const Value.absent(),
    this.unitsPerCarton = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.salePrice = const Value.absent(),
    this.total = const Value.absent(),
  });
  PurchaseItemsCompanion.insert({
    this.id = const Value.absent(),
    required int purchaseId,
    required int productId,
    required int quantity,
    this.cartonQuantity = const Value.absent(),
    this.unitsPerCarton = const Value.absent(),
    required double purchasePrice,
    this.salePrice = const Value.absent(),
    required double total,
  }) : purchaseId = Value(purchaseId),
       productId = Value(productId),
       quantity = Value(quantity),
       purchasePrice = Value(purchasePrice),
       total = Value(total);
  static Insertable<PurchaseItem> custom({
    Expression<int>? id,
    Expression<int>? purchaseId,
    Expression<int>? productId,
    Expression<int>? quantity,
    Expression<double>? cartonQuantity,
    Expression<int>? unitsPerCarton,
    Expression<double>? purchasePrice,
    Expression<double>? salePrice,
    Expression<double>? total,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (purchaseId != null) 'purchase_id': purchaseId,
      if (productId != null) 'product_id': productId,
      if (quantity != null) 'quantity': quantity,
      if (cartonQuantity != null) 'carton_quantity': cartonQuantity,
      if (unitsPerCarton != null) 'units_per_carton': unitsPerCarton,
      if (purchasePrice != null) 'purchase_price': purchasePrice,
      if (salePrice != null) 'sale_price': salePrice,
      if (total != null) 'total': total,
    });
  }

  PurchaseItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? purchaseId,
    Value<int>? productId,
    Value<int>? quantity,
    Value<double>? cartonQuantity,
    Value<int>? unitsPerCarton,
    Value<double>? purchasePrice,
    Value<double>? salePrice,
    Value<double>? total,
  }) {
    return PurchaseItemsCompanion(
      id: id ?? this.id,
      purchaseId: purchaseId ?? this.purchaseId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      cartonQuantity: cartonQuantity ?? this.cartonQuantity,
      unitsPerCarton: unitsPerCarton ?? this.unitsPerCarton,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      salePrice: salePrice ?? this.salePrice,
      total: total ?? this.total,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (purchaseId.present) {
      map['purchase_id'] = Variable<int>(purchaseId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (cartonQuantity.present) {
      map['carton_quantity'] = Variable<double>(cartonQuantity.value);
    }
    if (unitsPerCarton.present) {
      map['units_per_carton'] = Variable<int>(unitsPerCarton.value);
    }
    if (purchasePrice.present) {
      map['purchase_price'] = Variable<double>(purchasePrice.value);
    }
    if (salePrice.present) {
      map['sale_price'] = Variable<double>(salePrice.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseItemsCompanion(')
          ..write('id: $id, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('cartonQuantity: $cartonQuantity, ')
          ..write('unitsPerCarton: $unitsPerCarton, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('salePrice: $salePrice, ')
          ..write('total: $total')
          ..write(')'))
        .toString();
  }
}

class $PurchasePaymentsTable extends PurchasePayments
    with TableInfo<$PurchasePaymentsTable, PurchasePayment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchasePaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _purchaseIdMeta = const VerificationMeta(
    'purchaseId',
  );
  @override
  late final GeneratedColumn<int> purchaseId = GeneratedColumn<int>(
    'purchase_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES purchases (id)',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('cash'),
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    purchaseId,
    amount,
    paymentMethod,
    createdAt,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchase_payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<PurchasePayment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('purchase_id')) {
      context.handle(
        _purchaseIdMeta,
        purchaseId.isAcceptableOrUnknown(data['purchase_id']!, _purchaseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_purchaseIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PurchasePayment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchasePayment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      purchaseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}purchase_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $PurchasePaymentsTable createAlias(String alias) {
    return $PurchasePaymentsTable(attachedDatabase, alias);
  }
}

class PurchasePayment extends DataClass implements Insertable<PurchasePayment> {
  final int id;
  final int purchaseId;
  final double amount;
  final String paymentMethod;
  final DateTime createdAt;
  final String? note;
  const PurchasePayment({
    required this.id,
    required this.purchaseId,
    required this.amount,
    required this.paymentMethod,
    required this.createdAt,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['purchase_id'] = Variable<int>(purchaseId);
    map['amount'] = Variable<double>(amount);
    map['payment_method'] = Variable<String>(paymentMethod);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  PurchasePaymentsCompanion toCompanion(bool nullToAbsent) {
    return PurchasePaymentsCompanion(
      id: Value(id),
      purchaseId: Value(purchaseId),
      amount: Value(amount),
      paymentMethod: Value(paymentMethod),
      createdAt: Value(createdAt),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory PurchasePayment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchasePayment(
      id: serializer.fromJson<int>(json['id']),
      purchaseId: serializer.fromJson<int>(json['purchaseId']),
      amount: serializer.fromJson<double>(json['amount']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'purchaseId': serializer.toJson<int>(purchaseId),
      'amount': serializer.toJson<double>(amount),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'note': serializer.toJson<String?>(note),
    };
  }

  PurchasePayment copyWith({
    int? id,
    int? purchaseId,
    double? amount,
    String? paymentMethod,
    DateTime? createdAt,
    Value<String?> note = const Value.absent(),
  }) => PurchasePayment(
    id: id ?? this.id,
    purchaseId: purchaseId ?? this.purchaseId,
    amount: amount ?? this.amount,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    createdAt: createdAt ?? this.createdAt,
    note: note.present ? note.value : this.note,
  );
  PurchasePayment copyWithCompanion(PurchasePaymentsCompanion data) {
    return PurchasePayment(
      id: data.id.present ? data.id.value : this.id,
      purchaseId: data.purchaseId.present
          ? data.purchaseId.value
          : this.purchaseId,
      amount: data.amount.present ? data.amount.value : this.amount,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchasePayment(')
          ..write('id: $id, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('amount: $amount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('createdAt: $createdAt, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, purchaseId, amount, paymentMethod, createdAt, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchasePayment &&
          other.id == this.id &&
          other.purchaseId == this.purchaseId &&
          other.amount == this.amount &&
          other.paymentMethod == this.paymentMethod &&
          other.createdAt == this.createdAt &&
          other.note == this.note);
}

class PurchasePaymentsCompanion extends UpdateCompanion<PurchasePayment> {
  final Value<int> id;
  final Value<int> purchaseId;
  final Value<double> amount;
  final Value<String> paymentMethod;
  final Value<DateTime> createdAt;
  final Value<String?> note;
  const PurchasePaymentsCompanion({
    this.id = const Value.absent(),
    this.purchaseId = const Value.absent(),
    this.amount = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.note = const Value.absent(),
  });
  PurchasePaymentsCompanion.insert({
    this.id = const Value.absent(),
    required int purchaseId,
    required double amount,
    this.paymentMethod = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.note = const Value.absent(),
  }) : purchaseId = Value(purchaseId),
       amount = Value(amount);
  static Insertable<PurchasePayment> custom({
    Expression<int>? id,
    Expression<int>? purchaseId,
    Expression<double>? amount,
    Expression<String>? paymentMethod,
    Expression<DateTime>? createdAt,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (purchaseId != null) 'purchase_id': purchaseId,
      if (amount != null) 'amount': amount,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (createdAt != null) 'created_at': createdAt,
      if (note != null) 'note': note,
    });
  }

  PurchasePaymentsCompanion copyWith({
    Value<int>? id,
    Value<int>? purchaseId,
    Value<double>? amount,
    Value<String>? paymentMethod,
    Value<DateTime>? createdAt,
    Value<String?>? note,
  }) {
    return PurchasePaymentsCompanion(
      id: id ?? this.id,
      purchaseId: purchaseId ?? this.purchaseId,
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      createdAt: createdAt ?? this.createdAt,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (purchaseId.present) {
      map['purchase_id'] = Variable<int>(purchaseId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchasePaymentsCompanion(')
          ..write('id: $id, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('amount: $amount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('createdAt: $createdAt, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $PaymentAccountsTable extends PaymentAccounts
    with TableInfo<$PaymentAccountsTable, PaymentAccount> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentAccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 2,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _providerMeta = const VerificationMeta(
    'provider',
  );
  @override
  late final GeneratedColumn<String> provider = GeneratedColumn<String>(
    'provider',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _referenceMeta = const VerificationMeta(
    'reference',
  );
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
    'reference',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    name,
    provider,
    reference,
    isActive,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payment_accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<PaymentAccount> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('provider')) {
      context.handle(
        _providerMeta,
        provider.isAcceptableOrUnknown(data['provider']!, _providerMeta),
      );
    }
    if (data.containsKey('reference')) {
      context.handle(
        _referenceMeta,
        reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaymentAccount map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentAccount(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      provider: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provider'],
      ),
      reference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PaymentAccountsTable createAlias(String alias) {
    return $PaymentAccountsTable(attachedDatabase, alias);
  }
}

class PaymentAccount extends DataClass implements Insertable<PaymentAccount> {
  final int id;

  /// Supported values are wallet and visa.
  final String type;
  final String name;
  final String? provider;

  /// Wallet phone or a safe terminal/reference label; never a full card number.
  final String? reference;
  final bool isActive;
  final DateTime createdAt;
  const PaymentAccount({
    required this.id,
    required this.type,
    required this.name,
    this.provider,
    this.reference,
    required this.isActive,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type'] = Variable<String>(type);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || provider != null) {
      map['provider'] = Variable<String>(provider);
    }
    if (!nullToAbsent || reference != null) {
      map['reference'] = Variable<String>(reference);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PaymentAccountsCompanion toCompanion(bool nullToAbsent) {
    return PaymentAccountsCompanion(
      id: Value(id),
      type: Value(type),
      name: Value(name),
      provider: provider == null && nullToAbsent
          ? const Value.absent()
          : Value(provider),
      reference: reference == null && nullToAbsent
          ? const Value.absent()
          : Value(reference),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory PaymentAccount.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentAccount(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      name: serializer.fromJson<String>(json['name']),
      provider: serializer.fromJson<String?>(json['provider']),
      reference: serializer.fromJson<String?>(json['reference']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(type),
      'name': serializer.toJson<String>(name),
      'provider': serializer.toJson<String?>(provider),
      'reference': serializer.toJson<String?>(reference),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PaymentAccount copyWith({
    int? id,
    String? type,
    String? name,
    Value<String?> provider = const Value.absent(),
    Value<String?> reference = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
  }) => PaymentAccount(
    id: id ?? this.id,
    type: type ?? this.type,
    name: name ?? this.name,
    provider: provider.present ? provider.value : this.provider,
    reference: reference.present ? reference.value : this.reference,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
  );
  PaymentAccount copyWithCompanion(PaymentAccountsCompanion data) {
    return PaymentAccount(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      name: data.name.present ? data.name.value : this.name,
      provider: data.provider.present ? data.provider.value : this.provider,
      reference: data.reference.present ? data.reference.value : this.reference,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentAccount(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('provider: $provider, ')
          ..write('reference: $reference, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, type, name, provider, reference, isActive, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentAccount &&
          other.id == this.id &&
          other.type == this.type &&
          other.name == this.name &&
          other.provider == this.provider &&
          other.reference == this.reference &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class PaymentAccountsCompanion extends UpdateCompanion<PaymentAccount> {
  final Value<int> id;
  final Value<String> type;
  final Value<String> name;
  final Value<String?> provider;
  final Value<String?> reference;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  const PaymentAccountsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.name = const Value.absent(),
    this.provider = const Value.absent(),
    this.reference = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PaymentAccountsCompanion.insert({
    this.id = const Value.absent(),
    required String type,
    required String name,
    this.provider = const Value.absent(),
    this.reference = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : type = Value(type),
       name = Value(name);
  static Insertable<PaymentAccount> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<String>? name,
    Expression<String>? provider,
    Expression<String>? reference,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (name != null) 'name': name,
      if (provider != null) 'provider': provider,
      if (reference != null) 'reference': reference,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PaymentAccountsCompanion copyWith({
    Value<int>? id,
    Value<String>? type,
    Value<String>? name,
    Value<String?>? provider,
    Value<String?>? reference,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
  }) {
    return PaymentAccountsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      provider: provider ?? this.provider,
      reference: reference ?? this.reference,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (provider.present) {
      map['provider'] = Variable<String>(provider.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentAccountsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('provider: $provider, ')
          ..write('reference: $reference, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses with TableInfo<$ExpensesTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
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
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
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
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('paid'),
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('cash'),
  );
  static const VerificationMeta _paymentAccountIdMeta = const VerificationMeta(
    'paymentAccountId',
  );
  @override
  late final GeneratedColumn<int> paymentAccountId = GeneratedColumn<int>(
    'payment_account_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES payment_accounts (id)',
    ),
  );
  static const VerificationMeta _expenseDateMeta = const VerificationMeta(
    'expenseDate',
  );
  @override
  late final GeneratedColumn<DateTime> expenseDate = GeneratedColumn<DateTime>(
    'expense_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    category,
    amount,
    notes,
    status,
    paymentMethod,
    paymentAccountId,
    expenseDate,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<Expense> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    }
    if (data.containsKey('payment_account_id')) {
      context.handle(
        _paymentAccountIdMeta,
        paymentAccountId.isAcceptableOrUnknown(
          data['payment_account_id']!,
          _paymentAccountIdMeta,
        ),
      );
    }
    if (data.containsKey('expense_date')) {
      context.handle(
        _expenseDateMeta,
        expenseDate.isAcceptableOrUnknown(
          data['expense_date']!,
          _expenseDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_expenseDateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      )!,
      paymentAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}payment_account_id'],
      ),
      expenseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expense_date'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }
}

class Expense extends DataClass implements Insertable<Expense> {
  final int id;
  final String title;
  final String category;
  final double amount;
  final String? notes;
  final String status;

  /// cash, credit, or payment-account id represented by paymentAccountId.
  final String paymentMethod;
  final int? paymentAccountId;
  final DateTime expenseDate;
  final DateTime createdAt;
  const Expense({
    required this.id,
    required this.title,
    required this.category,
    required this.amount,
    this.notes,
    required this.status,
    required this.paymentMethod,
    this.paymentAccountId,
    required this.expenseDate,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['category'] = Variable<String>(category);
    map['amount'] = Variable<double>(amount);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['status'] = Variable<String>(status);
    map['payment_method'] = Variable<String>(paymentMethod);
    if (!nullToAbsent || paymentAccountId != null) {
      map['payment_account_id'] = Variable<int>(paymentAccountId);
    }
    map['expense_date'] = Variable<DateTime>(expenseDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      title: Value(title),
      category: Value(category),
      amount: Value(amount),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      status: Value(status),
      paymentMethod: Value(paymentMethod),
      paymentAccountId: paymentAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentAccountId),
      expenseDate: Value(expenseDate),
      createdAt: Value(createdAt),
    );
  }

  factory Expense.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Expense(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      category: serializer.fromJson<String>(json['category']),
      amount: serializer.fromJson<double>(json['amount']),
      notes: serializer.fromJson<String?>(json['notes']),
      status: serializer.fromJson<String>(json['status']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      paymentAccountId: serializer.fromJson<int?>(json['paymentAccountId']),
      expenseDate: serializer.fromJson<DateTime>(json['expenseDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'category': serializer.toJson<String>(category),
      'amount': serializer.toJson<double>(amount),
      'notes': serializer.toJson<String?>(notes),
      'status': serializer.toJson<String>(status),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'paymentAccountId': serializer.toJson<int?>(paymentAccountId),
      'expenseDate': serializer.toJson<DateTime>(expenseDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Expense copyWith({
    int? id,
    String? title,
    String? category,
    double? amount,
    Value<String?> notes = const Value.absent(),
    String? status,
    String? paymentMethod,
    Value<int?> paymentAccountId = const Value.absent(),
    DateTime? expenseDate,
    DateTime? createdAt,
  }) => Expense(
    id: id ?? this.id,
    title: title ?? this.title,
    category: category ?? this.category,
    amount: amount ?? this.amount,
    notes: notes.present ? notes.value : this.notes,
    status: status ?? this.status,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    paymentAccountId: paymentAccountId.present
        ? paymentAccountId.value
        : this.paymentAccountId,
    expenseDate: expenseDate ?? this.expenseDate,
    createdAt: createdAt ?? this.createdAt,
  );
  Expense copyWithCompanion(ExpensesCompanion data) {
    return Expense(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      category: data.category.present ? data.category.value : this.category,
      amount: data.amount.present ? data.amount.value : this.amount,
      notes: data.notes.present ? data.notes.value : this.notes,
      status: data.status.present ? data.status.value : this.status,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      paymentAccountId: data.paymentAccountId.present
          ? data.paymentAccountId.value
          : this.paymentAccountId,
      expenseDate: data.expenseDate.present
          ? data.expenseDate.value
          : this.expenseDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Expense(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('paymentAccountId: $paymentAccountId, ')
          ..write('expenseDate: $expenseDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    category,
    amount,
    notes,
    status,
    paymentMethod,
    paymentAccountId,
    expenseDate,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expense &&
          other.id == this.id &&
          other.title == this.title &&
          other.category == this.category &&
          other.amount == this.amount &&
          other.notes == this.notes &&
          other.status == this.status &&
          other.paymentMethod == this.paymentMethod &&
          other.paymentAccountId == this.paymentAccountId &&
          other.expenseDate == this.expenseDate &&
          other.createdAt == this.createdAt);
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> category;
  final Value<double> amount;
  final Value<String?> notes;
  final Value<String> status;
  final Value<String> paymentMethod;
  final Value<int?> paymentAccountId;
  final Value<DateTime> expenseDate;
  final Value<DateTime> createdAt;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.category = const Value.absent(),
    this.amount = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.paymentAccountId = const Value.absent(),
    this.expenseDate = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ExpensesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String category,
    required double amount,
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.paymentAccountId = const Value.absent(),
    required DateTime expenseDate,
    this.createdAt = const Value.absent(),
  }) : title = Value(title),
       category = Value(category),
       amount = Value(amount),
       expenseDate = Value(expenseDate);
  static Insertable<Expense> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? category,
    Expression<double>? amount,
    Expression<String>? notes,
    Expression<String>? status,
    Expression<String>? paymentMethod,
    Expression<int>? paymentAccountId,
    Expression<DateTime>? expenseDate,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (category != null) 'category': category,
      if (amount != null) 'amount': amount,
      if (notes != null) 'notes': notes,
      if (status != null) 'status': status,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (paymentAccountId != null) 'payment_account_id': paymentAccountId,
      if (expenseDate != null) 'expense_date': expenseDate,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ExpensesCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? category,
    Value<double>? amount,
    Value<String?>? notes,
    Value<String>? status,
    Value<String>? paymentMethod,
    Value<int?>? paymentAccountId,
    Value<DateTime>? expenseDate,
    Value<DateTime>? createdAt,
  }) {
    return ExpensesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentAccountId: paymentAccountId ?? this.paymentAccountId,
      expenseDate: expenseDate ?? this.expenseDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (paymentAccountId.present) {
      map['payment_account_id'] = Variable<int>(paymentAccountId.value);
    }
    if (expenseDate.present) {
      map['expense_date'] = Variable<DateTime>(expenseDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('paymentAccountId: $paymentAccountId, ')
          ..write('expenseDate: $expenseDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DailyClosingsTable extends DailyClosings
    with TableInfo<$DailyClosingsTable, DailyClosing> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyClosingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _totalSalesMeta = const VerificationMeta(
    'totalSales',
  );
  @override
  late final GeneratedColumn<double> totalSales = GeneratedColumn<double>(
    'total_sales',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalPurchasesMeta = const VerificationMeta(
    'totalPurchases',
  );
  @override
  late final GeneratedColumn<double> totalPurchases = GeneratedColumn<double>(
    'total_purchases',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalExpensesMeta = const VerificationMeta(
    'totalExpenses',
  );
  @override
  late final GeneratedColumn<double> totalExpenses = GeneratedColumn<double>(
    'total_expenses',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _cashBalanceMeta = const VerificationMeta(
    'cashBalance',
  );
  @override
  late final GeneratedColumn<double> cashBalance = GeneratedColumn<double>(
    'cash_balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _posBalanceMeta = const VerificationMeta(
    'posBalance',
  );
  @override
  late final GeneratedColumn<double> posBalance = GeneratedColumn<double>(
    'pos_balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _walletBalanceMeta = const VerificationMeta(
    'walletBalance',
  );
  @override
  late final GeneratedColumn<double> walletBalance = GeneratedColumn<double>(
    'wallet_balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _expectedBalanceMeta = const VerificationMeta(
    'expectedBalance',
  );
  @override
  late final GeneratedColumn<double> expectedBalance = GeneratedColumn<double>(
    'expected_balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _differenceMeta = const VerificationMeta(
    'difference',
  );
  @override
  late final GeneratedColumn<double> difference = GeneratedColumn<double>(
    'difference',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userNameMeta = const VerificationMeta(
    'userName',
  );
  @override
  late final GeneratedColumn<String> userName = GeneratedColumn<String>(
    'user_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isClosedMeta = const VerificationMeta(
    'isClosed',
  );
  @override
  late final GeneratedColumn<bool> isClosed = GeneratedColumn<bool>(
    'is_closed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_closed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    totalSales,
    totalPurchases,
    totalExpenses,
    cashBalance,
    posBalance,
    walletBalance,
    expectedBalance,
    difference,
    note,
    userName,
    isClosed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_closings';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyClosing> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('total_sales')) {
      context.handle(
        _totalSalesMeta,
        totalSales.isAcceptableOrUnknown(data['total_sales']!, _totalSalesMeta),
      );
    }
    if (data.containsKey('total_purchases')) {
      context.handle(
        _totalPurchasesMeta,
        totalPurchases.isAcceptableOrUnknown(
          data['total_purchases']!,
          _totalPurchasesMeta,
        ),
      );
    }
    if (data.containsKey('total_expenses')) {
      context.handle(
        _totalExpensesMeta,
        totalExpenses.isAcceptableOrUnknown(
          data['total_expenses']!,
          _totalExpensesMeta,
        ),
      );
    }
    if (data.containsKey('cash_balance')) {
      context.handle(
        _cashBalanceMeta,
        cashBalance.isAcceptableOrUnknown(
          data['cash_balance']!,
          _cashBalanceMeta,
        ),
      );
    }
    if (data.containsKey('pos_balance')) {
      context.handle(
        _posBalanceMeta,
        posBalance.isAcceptableOrUnknown(data['pos_balance']!, _posBalanceMeta),
      );
    }
    if (data.containsKey('wallet_balance')) {
      context.handle(
        _walletBalanceMeta,
        walletBalance.isAcceptableOrUnknown(
          data['wallet_balance']!,
          _walletBalanceMeta,
        ),
      );
    }
    if (data.containsKey('expected_balance')) {
      context.handle(
        _expectedBalanceMeta,
        expectedBalance.isAcceptableOrUnknown(
          data['expected_balance']!,
          _expectedBalanceMeta,
        ),
      );
    }
    if (data.containsKey('difference')) {
      context.handle(
        _differenceMeta,
        difference.isAcceptableOrUnknown(data['difference']!, _differenceMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('user_name')) {
      context.handle(
        _userNameMeta,
        userName.isAcceptableOrUnknown(data['user_name']!, _userNameMeta),
      );
    }
    if (data.containsKey('is_closed')) {
      context.handle(
        _isClosedMeta,
        isClosed.isAcceptableOrUnknown(data['is_closed']!, _isClosedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyClosing map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyClosing(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      totalSales: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_sales'],
      )!,
      totalPurchases: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_purchases'],
      )!,
      totalExpenses: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_expenses'],
      )!,
      cashBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cash_balance'],
      )!,
      posBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pos_balance'],
      )!,
      walletBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}wallet_balance'],
      )!,
      expectedBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}expected_balance'],
      )!,
      difference: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}difference'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      userName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_name'],
      ),
      isClosed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_closed'],
      )!,
    );
  }

  @override
  $DailyClosingsTable createAlias(String alias) {
    return $DailyClosingsTable(attachedDatabase, alias);
  }
}

class DailyClosing extends DataClass implements Insertable<DailyClosing> {
  final int id;

  /// Normalized local calendar day (00:00:00), unique by design.
  final DateTime date;
  final double totalSales;
  final double totalPurchases;
  final double totalExpenses;
  final double cashBalance;
  final double posBalance;
  final double walletBalance;
  final double expectedBalance;
  final double difference;
  final String? note;
  final String? userName;
  final bool isClosed;
  const DailyClosing({
    required this.id,
    required this.date,
    required this.totalSales,
    required this.totalPurchases,
    required this.totalExpenses,
    required this.cashBalance,
    required this.posBalance,
    required this.walletBalance,
    required this.expectedBalance,
    required this.difference,
    this.note,
    this.userName,
    required this.isClosed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['total_sales'] = Variable<double>(totalSales);
    map['total_purchases'] = Variable<double>(totalPurchases);
    map['total_expenses'] = Variable<double>(totalExpenses);
    map['cash_balance'] = Variable<double>(cashBalance);
    map['pos_balance'] = Variable<double>(posBalance);
    map['wallet_balance'] = Variable<double>(walletBalance);
    map['expected_balance'] = Variable<double>(expectedBalance);
    map['difference'] = Variable<double>(difference);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || userName != null) {
      map['user_name'] = Variable<String>(userName);
    }
    map['is_closed'] = Variable<bool>(isClosed);
    return map;
  }

  DailyClosingsCompanion toCompanion(bool nullToAbsent) {
    return DailyClosingsCompanion(
      id: Value(id),
      date: Value(date),
      totalSales: Value(totalSales),
      totalPurchases: Value(totalPurchases),
      totalExpenses: Value(totalExpenses),
      cashBalance: Value(cashBalance),
      posBalance: Value(posBalance),
      walletBalance: Value(walletBalance),
      expectedBalance: Value(expectedBalance),
      difference: Value(difference),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      userName: userName == null && nullToAbsent
          ? const Value.absent()
          : Value(userName),
      isClosed: Value(isClosed),
    );
  }

  factory DailyClosing.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyClosing(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      totalSales: serializer.fromJson<double>(json['totalSales']),
      totalPurchases: serializer.fromJson<double>(json['totalPurchases']),
      totalExpenses: serializer.fromJson<double>(json['totalExpenses']),
      cashBalance: serializer.fromJson<double>(json['cashBalance']),
      posBalance: serializer.fromJson<double>(json['posBalance']),
      walletBalance: serializer.fromJson<double>(json['walletBalance']),
      expectedBalance: serializer.fromJson<double>(json['expectedBalance']),
      difference: serializer.fromJson<double>(json['difference']),
      note: serializer.fromJson<String?>(json['note']),
      userName: serializer.fromJson<String?>(json['userName']),
      isClosed: serializer.fromJson<bool>(json['isClosed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'totalSales': serializer.toJson<double>(totalSales),
      'totalPurchases': serializer.toJson<double>(totalPurchases),
      'totalExpenses': serializer.toJson<double>(totalExpenses),
      'cashBalance': serializer.toJson<double>(cashBalance),
      'posBalance': serializer.toJson<double>(posBalance),
      'walletBalance': serializer.toJson<double>(walletBalance),
      'expectedBalance': serializer.toJson<double>(expectedBalance),
      'difference': serializer.toJson<double>(difference),
      'note': serializer.toJson<String?>(note),
      'userName': serializer.toJson<String?>(userName),
      'isClosed': serializer.toJson<bool>(isClosed),
    };
  }

  DailyClosing copyWith({
    int? id,
    DateTime? date,
    double? totalSales,
    double? totalPurchases,
    double? totalExpenses,
    double? cashBalance,
    double? posBalance,
    double? walletBalance,
    double? expectedBalance,
    double? difference,
    Value<String?> note = const Value.absent(),
    Value<String?> userName = const Value.absent(),
    bool? isClosed,
  }) => DailyClosing(
    id: id ?? this.id,
    date: date ?? this.date,
    totalSales: totalSales ?? this.totalSales,
    totalPurchases: totalPurchases ?? this.totalPurchases,
    totalExpenses: totalExpenses ?? this.totalExpenses,
    cashBalance: cashBalance ?? this.cashBalance,
    posBalance: posBalance ?? this.posBalance,
    walletBalance: walletBalance ?? this.walletBalance,
    expectedBalance: expectedBalance ?? this.expectedBalance,
    difference: difference ?? this.difference,
    note: note.present ? note.value : this.note,
    userName: userName.present ? userName.value : this.userName,
    isClosed: isClosed ?? this.isClosed,
  );
  DailyClosing copyWithCompanion(DailyClosingsCompanion data) {
    return DailyClosing(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      totalSales: data.totalSales.present
          ? data.totalSales.value
          : this.totalSales,
      totalPurchases: data.totalPurchases.present
          ? data.totalPurchases.value
          : this.totalPurchases,
      totalExpenses: data.totalExpenses.present
          ? data.totalExpenses.value
          : this.totalExpenses,
      cashBalance: data.cashBalance.present
          ? data.cashBalance.value
          : this.cashBalance,
      posBalance: data.posBalance.present
          ? data.posBalance.value
          : this.posBalance,
      walletBalance: data.walletBalance.present
          ? data.walletBalance.value
          : this.walletBalance,
      expectedBalance: data.expectedBalance.present
          ? data.expectedBalance.value
          : this.expectedBalance,
      difference: data.difference.present
          ? data.difference.value
          : this.difference,
      note: data.note.present ? data.note.value : this.note,
      userName: data.userName.present ? data.userName.value : this.userName,
      isClosed: data.isClosed.present ? data.isClosed.value : this.isClosed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyClosing(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('totalSales: $totalSales, ')
          ..write('totalPurchases: $totalPurchases, ')
          ..write('totalExpenses: $totalExpenses, ')
          ..write('cashBalance: $cashBalance, ')
          ..write('posBalance: $posBalance, ')
          ..write('walletBalance: $walletBalance, ')
          ..write('expectedBalance: $expectedBalance, ')
          ..write('difference: $difference, ')
          ..write('note: $note, ')
          ..write('userName: $userName, ')
          ..write('isClosed: $isClosed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    date,
    totalSales,
    totalPurchases,
    totalExpenses,
    cashBalance,
    posBalance,
    walletBalance,
    expectedBalance,
    difference,
    note,
    userName,
    isClosed,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyClosing &&
          other.id == this.id &&
          other.date == this.date &&
          other.totalSales == this.totalSales &&
          other.totalPurchases == this.totalPurchases &&
          other.totalExpenses == this.totalExpenses &&
          other.cashBalance == this.cashBalance &&
          other.posBalance == this.posBalance &&
          other.walletBalance == this.walletBalance &&
          other.expectedBalance == this.expectedBalance &&
          other.difference == this.difference &&
          other.note == this.note &&
          other.userName == this.userName &&
          other.isClosed == this.isClosed);
}

class DailyClosingsCompanion extends UpdateCompanion<DailyClosing> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<double> totalSales;
  final Value<double> totalPurchases;
  final Value<double> totalExpenses;
  final Value<double> cashBalance;
  final Value<double> posBalance;
  final Value<double> walletBalance;
  final Value<double> expectedBalance;
  final Value<double> difference;
  final Value<String?> note;
  final Value<String?> userName;
  final Value<bool> isClosed;
  const DailyClosingsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.totalSales = const Value.absent(),
    this.totalPurchases = const Value.absent(),
    this.totalExpenses = const Value.absent(),
    this.cashBalance = const Value.absent(),
    this.posBalance = const Value.absent(),
    this.walletBalance = const Value.absent(),
    this.expectedBalance = const Value.absent(),
    this.difference = const Value.absent(),
    this.note = const Value.absent(),
    this.userName = const Value.absent(),
    this.isClosed = const Value.absent(),
  });
  DailyClosingsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    this.totalSales = const Value.absent(),
    this.totalPurchases = const Value.absent(),
    this.totalExpenses = const Value.absent(),
    this.cashBalance = const Value.absent(),
    this.posBalance = const Value.absent(),
    this.walletBalance = const Value.absent(),
    this.expectedBalance = const Value.absent(),
    this.difference = const Value.absent(),
    this.note = const Value.absent(),
    this.userName = const Value.absent(),
    this.isClosed = const Value.absent(),
  }) : date = Value(date);
  static Insertable<DailyClosing> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<double>? totalSales,
    Expression<double>? totalPurchases,
    Expression<double>? totalExpenses,
    Expression<double>? cashBalance,
    Expression<double>? posBalance,
    Expression<double>? walletBalance,
    Expression<double>? expectedBalance,
    Expression<double>? difference,
    Expression<String>? note,
    Expression<String>? userName,
    Expression<bool>? isClosed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (totalSales != null) 'total_sales': totalSales,
      if (totalPurchases != null) 'total_purchases': totalPurchases,
      if (totalExpenses != null) 'total_expenses': totalExpenses,
      if (cashBalance != null) 'cash_balance': cashBalance,
      if (posBalance != null) 'pos_balance': posBalance,
      if (walletBalance != null) 'wallet_balance': walletBalance,
      if (expectedBalance != null) 'expected_balance': expectedBalance,
      if (difference != null) 'difference': difference,
      if (note != null) 'note': note,
      if (userName != null) 'user_name': userName,
      if (isClosed != null) 'is_closed': isClosed,
    });
  }

  DailyClosingsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<double>? totalSales,
    Value<double>? totalPurchases,
    Value<double>? totalExpenses,
    Value<double>? cashBalance,
    Value<double>? posBalance,
    Value<double>? walletBalance,
    Value<double>? expectedBalance,
    Value<double>? difference,
    Value<String?>? note,
    Value<String?>? userName,
    Value<bool>? isClosed,
  }) {
    return DailyClosingsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      totalSales: totalSales ?? this.totalSales,
      totalPurchases: totalPurchases ?? this.totalPurchases,
      totalExpenses: totalExpenses ?? this.totalExpenses,
      cashBalance: cashBalance ?? this.cashBalance,
      posBalance: posBalance ?? this.posBalance,
      walletBalance: walletBalance ?? this.walletBalance,
      expectedBalance: expectedBalance ?? this.expectedBalance,
      difference: difference ?? this.difference,
      note: note ?? this.note,
      userName: userName ?? this.userName,
      isClosed: isClosed ?? this.isClosed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (totalSales.present) {
      map['total_sales'] = Variable<double>(totalSales.value);
    }
    if (totalPurchases.present) {
      map['total_purchases'] = Variable<double>(totalPurchases.value);
    }
    if (totalExpenses.present) {
      map['total_expenses'] = Variable<double>(totalExpenses.value);
    }
    if (cashBalance.present) {
      map['cash_balance'] = Variable<double>(cashBalance.value);
    }
    if (posBalance.present) {
      map['pos_balance'] = Variable<double>(posBalance.value);
    }
    if (walletBalance.present) {
      map['wallet_balance'] = Variable<double>(walletBalance.value);
    }
    if (expectedBalance.present) {
      map['expected_balance'] = Variable<double>(expectedBalance.value);
    }
    if (difference.present) {
      map['difference'] = Variable<double>(difference.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    if (isClosed.present) {
      map['is_closed'] = Variable<bool>(isClosed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyClosingsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('totalSales: $totalSales, ')
          ..write('totalPurchases: $totalPurchases, ')
          ..write('totalExpenses: $totalExpenses, ')
          ..write('cashBalance: $cashBalance, ')
          ..write('posBalance: $posBalance, ')
          ..write('walletBalance: $walletBalance, ')
          ..write('expectedBalance: $expectedBalance, ')
          ..write('difference: $difference, ')
          ..write('note: $note, ')
          ..write('userName: $userName, ')
          ..write('isClosed: $isClosed')
          ..write(')'))
        .toString();
  }
}

class $DebtPaymentsTable extends DebtPayments
    with TableInfo<$DebtPaymentsTable, DebtPayment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DebtPaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<int> invoiceId = GeneratedColumn<int>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES invoices (id)',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentAccountIdMeta = const VerificationMeta(
    'paymentAccountId',
  );
  @override
  late final GeneratedColumn<int> paymentAccountId = GeneratedColumn<int>(
    'payment_account_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES payment_accounts (id)',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    invoiceId,
    amount,
    paymentMethod,
    paymentAccountId,
    userId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'debt_payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<DebtPayment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentMethodMeta);
    }
    if (data.containsKey('payment_account_id')) {
      context.handle(
        _paymentAccountIdMeta,
        paymentAccountId.isAcceptableOrUnknown(
          data['payment_account_id']!,
          _paymentAccountIdMeta,
        ),
      );
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DebtPayment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DebtPayment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}invoice_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      )!,
      paymentAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}payment_account_id'],
      ),
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $DebtPaymentsTable createAlias(String alias) {
    return $DebtPaymentsTable(attachedDatabase, alias);
  }
}

class DebtPayment extends DataClass implements Insertable<DebtPayment> {
  final int id;
  final int invoiceId;
  final double amount;
  final String paymentMethod;
  final int? paymentAccountId;
  final int userId;
  final DateTime createdAt;
  const DebtPayment({
    required this.id,
    required this.invoiceId,
    required this.amount,
    required this.paymentMethod,
    this.paymentAccountId,
    required this.userId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['invoice_id'] = Variable<int>(invoiceId);
    map['amount'] = Variable<double>(amount);
    map['payment_method'] = Variable<String>(paymentMethod);
    if (!nullToAbsent || paymentAccountId != null) {
      map['payment_account_id'] = Variable<int>(paymentAccountId);
    }
    map['user_id'] = Variable<int>(userId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DebtPaymentsCompanion toCompanion(bool nullToAbsent) {
    return DebtPaymentsCompanion(
      id: Value(id),
      invoiceId: Value(invoiceId),
      amount: Value(amount),
      paymentMethod: Value(paymentMethod),
      paymentAccountId: paymentAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentAccountId),
      userId: Value(userId),
      createdAt: Value(createdAt),
    );
  }

  factory DebtPayment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DebtPayment(
      id: serializer.fromJson<int>(json['id']),
      invoiceId: serializer.fromJson<int>(json['invoiceId']),
      amount: serializer.fromJson<double>(json['amount']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      paymentAccountId: serializer.fromJson<int?>(json['paymentAccountId']),
      userId: serializer.fromJson<int>(json['userId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'invoiceId': serializer.toJson<int>(invoiceId),
      'amount': serializer.toJson<double>(amount),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'paymentAccountId': serializer.toJson<int?>(paymentAccountId),
      'userId': serializer.toJson<int>(userId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DebtPayment copyWith({
    int? id,
    int? invoiceId,
    double? amount,
    String? paymentMethod,
    Value<int?> paymentAccountId = const Value.absent(),
    int? userId,
    DateTime? createdAt,
  }) => DebtPayment(
    id: id ?? this.id,
    invoiceId: invoiceId ?? this.invoiceId,
    amount: amount ?? this.amount,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    paymentAccountId: paymentAccountId.present
        ? paymentAccountId.value
        : this.paymentAccountId,
    userId: userId ?? this.userId,
    createdAt: createdAt ?? this.createdAt,
  );
  DebtPayment copyWithCompanion(DebtPaymentsCompanion data) {
    return DebtPayment(
      id: data.id.present ? data.id.value : this.id,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      amount: data.amount.present ? data.amount.value : this.amount,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      paymentAccountId: data.paymentAccountId.present
          ? data.paymentAccountId.value
          : this.paymentAccountId,
      userId: data.userId.present ? data.userId.value : this.userId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DebtPayment(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('amount: $amount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('paymentAccountId: $paymentAccountId, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    invoiceId,
    amount,
    paymentMethod,
    paymentAccountId,
    userId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DebtPayment &&
          other.id == this.id &&
          other.invoiceId == this.invoiceId &&
          other.amount == this.amount &&
          other.paymentMethod == this.paymentMethod &&
          other.paymentAccountId == this.paymentAccountId &&
          other.userId == this.userId &&
          other.createdAt == this.createdAt);
}

class DebtPaymentsCompanion extends UpdateCompanion<DebtPayment> {
  final Value<int> id;
  final Value<int> invoiceId;
  final Value<double> amount;
  final Value<String> paymentMethod;
  final Value<int?> paymentAccountId;
  final Value<int> userId;
  final Value<DateTime> createdAt;
  const DebtPaymentsCompanion({
    this.id = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.amount = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.paymentAccountId = const Value.absent(),
    this.userId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DebtPaymentsCompanion.insert({
    this.id = const Value.absent(),
    required int invoiceId,
    required double amount,
    required String paymentMethod,
    this.paymentAccountId = const Value.absent(),
    required int userId,
    this.createdAt = const Value.absent(),
  }) : invoiceId = Value(invoiceId),
       amount = Value(amount),
       paymentMethod = Value(paymentMethod),
       userId = Value(userId);
  static Insertable<DebtPayment> custom({
    Expression<int>? id,
    Expression<int>? invoiceId,
    Expression<double>? amount,
    Expression<String>? paymentMethod,
    Expression<int>? paymentAccountId,
    Expression<int>? userId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (amount != null) 'amount': amount,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (paymentAccountId != null) 'payment_account_id': paymentAccountId,
      if (userId != null) 'user_id': userId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DebtPaymentsCompanion copyWith({
    Value<int>? id,
    Value<int>? invoiceId,
    Value<double>? amount,
    Value<String>? paymentMethod,
    Value<int?>? paymentAccountId,
    Value<int>? userId,
    Value<DateTime>? createdAt,
  }) {
    return DebtPaymentsCompanion(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentAccountId: paymentAccountId ?? this.paymentAccountId,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<int>(invoiceId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (paymentAccountId.present) {
      map['payment_account_id'] = Variable<int>(paymentAccountId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DebtPaymentsCompanion(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('amount: $amount, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('paymentAccountId: $paymentAccountId, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _initialCashBalanceMeta =
      const VerificationMeta('initialCashBalance');
  @override
  late final GeneratedColumn<double> initialCashBalance =
      GeneratedColumn<double>(
        'initial_cash_balance',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, initialCashBalance, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('initial_cash_balance')) {
      context.handle(
        _initialCashBalanceMeta,
        initialCashBalance.isAcceptableOrUnknown(
          data['initial_cash_balance']!,
          _initialCashBalanceMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      initialCashBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}initial_cash_balance'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final int id;
  final double initialCashBalance;
  final DateTime createdAt;
  const AppSetting({
    required this.id,
    required this.initialCashBalance,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['initial_cash_balance'] = Variable<double>(initialCashBalance);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      initialCashBalance: Value(initialCashBalance),
      createdAt: Value(createdAt),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      id: serializer.fromJson<int>(json['id']),
      initialCashBalance: serializer.fromJson<double>(
        json['initialCashBalance'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'initialCashBalance': serializer.toJson<double>(initialCashBalance),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AppSetting copyWith({
    int? id,
    double? initialCashBalance,
    DateTime? createdAt,
  }) => AppSetting(
    id: id ?? this.id,
    initialCashBalance: initialCashBalance ?? this.initialCashBalance,
    createdAt: createdAt ?? this.createdAt,
  );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      id: data.id.present ? data.id.value : this.id,
      initialCashBalance: data.initialCashBalance.present
          ? data.initialCashBalance.value
          : this.initialCashBalance,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('id: $id, ')
          ..write('initialCashBalance: $initialCashBalance, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, initialCashBalance, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.id == this.id &&
          other.initialCashBalance == this.initialCashBalance &&
          other.createdAt == this.createdAt);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<int> id;
  final Value<double> initialCashBalance;
  final Value<DateTime> createdAt;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.initialCashBalance = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.initialCashBalance = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  static Insertable<AppSetting> custom({
    Expression<int>? id,
    Expression<double>? initialCashBalance,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (initialCashBalance != null)
        'initial_cash_balance': initialCashBalance,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AppSettingsCompanion copyWith({
    Value<int>? id,
    Value<double>? initialCashBalance,
    Value<DateTime>? createdAt,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      initialCashBalance: initialCashBalance ?? this.initialCashBalance,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (initialCashBalance.present) {
      map['initial_cash_balance'] = Variable<double>(initialCashBalance.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('initialCashBalance: $initialCashBalance, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $WorkerAdvancesTable extends WorkerAdvances
    with TableInfo<$WorkerAdvancesTable, WorkerAdvance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkerAdvancesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _workerIdMeta = const VerificationMeta(
    'workerId',
  );
  @override
  late final GeneratedColumn<int> workerId = GeneratedColumn<int>(
    'worker_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    workerId,
    amount,
    reason,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'worker_advances';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkerAdvance> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('worker_id')) {
      context.handle(
        _workerIdMeta,
        workerId.isAcceptableOrUnknown(data['worker_id']!, _workerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_workerIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkerAdvance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkerAdvance(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      workerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}worker_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $WorkerAdvancesTable createAlias(String alias) {
    return $WorkerAdvancesTable(attachedDatabase, alias);
  }
}

class WorkerAdvance extends DataClass implements Insertable<WorkerAdvance> {
  final int id;
  final int workerId;
  final double amount;
  final String? reason;
  final DateTime createdAt;
  const WorkerAdvance({
    required this.id,
    required this.workerId,
    required this.amount,
    this.reason,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['worker_id'] = Variable<int>(workerId);
    map['amount'] = Variable<double>(amount);
    if (!nullToAbsent || reason != null) {
      map['reason'] = Variable<String>(reason);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  WorkerAdvancesCompanion toCompanion(bool nullToAbsent) {
    return WorkerAdvancesCompanion(
      id: Value(id),
      workerId: Value(workerId),
      amount: Value(amount),
      reason: reason == null && nullToAbsent
          ? const Value.absent()
          : Value(reason),
      createdAt: Value(createdAt),
    );
  }

  factory WorkerAdvance.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkerAdvance(
      id: serializer.fromJson<int>(json['id']),
      workerId: serializer.fromJson<int>(json['workerId']),
      amount: serializer.fromJson<double>(json['amount']),
      reason: serializer.fromJson<String?>(json['reason']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'workerId': serializer.toJson<int>(workerId),
      'amount': serializer.toJson<double>(amount),
      'reason': serializer.toJson<String?>(reason),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  WorkerAdvance copyWith({
    int? id,
    int? workerId,
    double? amount,
    Value<String?> reason = const Value.absent(),
    DateTime? createdAt,
  }) => WorkerAdvance(
    id: id ?? this.id,
    workerId: workerId ?? this.workerId,
    amount: amount ?? this.amount,
    reason: reason.present ? reason.value : this.reason,
    createdAt: createdAt ?? this.createdAt,
  );
  WorkerAdvance copyWithCompanion(WorkerAdvancesCompanion data) {
    return WorkerAdvance(
      id: data.id.present ? data.id.value : this.id,
      workerId: data.workerId.present ? data.workerId.value : this.workerId,
      amount: data.amount.present ? data.amount.value : this.amount,
      reason: data.reason.present ? data.reason.value : this.reason,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkerAdvance(')
          ..write('id: $id, ')
          ..write('workerId: $workerId, ')
          ..write('amount: $amount, ')
          ..write('reason: $reason, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, workerId, amount, reason, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkerAdvance &&
          other.id == this.id &&
          other.workerId == this.workerId &&
          other.amount == this.amount &&
          other.reason == this.reason &&
          other.createdAt == this.createdAt);
}

class WorkerAdvancesCompanion extends UpdateCompanion<WorkerAdvance> {
  final Value<int> id;
  final Value<int> workerId;
  final Value<double> amount;
  final Value<String?> reason;
  final Value<DateTime> createdAt;
  const WorkerAdvancesCompanion({
    this.id = const Value.absent(),
    this.workerId = const Value.absent(),
    this.amount = const Value.absent(),
    this.reason = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  WorkerAdvancesCompanion.insert({
    this.id = const Value.absent(),
    required int workerId,
    required double amount,
    this.reason = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : workerId = Value(workerId),
       amount = Value(amount);
  static Insertable<WorkerAdvance> custom({
    Expression<int>? id,
    Expression<int>? workerId,
    Expression<double>? amount,
    Expression<String>? reason,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workerId != null) 'worker_id': workerId,
      if (amount != null) 'amount': amount,
      if (reason != null) 'reason': reason,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  WorkerAdvancesCompanion copyWith({
    Value<int>? id,
    Value<int>? workerId,
    Value<double>? amount,
    Value<String?>? reason,
    Value<DateTime>? createdAt,
  }) {
    return WorkerAdvancesCompanion(
      id: id ?? this.id,
      workerId: workerId ?? this.workerId,
      amount: amount ?? this.amount,
      reason: reason ?? this.reason,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (workerId.present) {
      map['worker_id'] = Variable<int>(workerId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkerAdvancesCompanion(')
          ..write('id: $id, ')
          ..write('workerId: $workerId, ')
          ..write('amount: $amount, ')
          ..write('reason: $reason, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $WorkerProductIssuesTable extends WorkerProductIssues
    with TableInfo<$WorkerProductIssuesTable, WorkerProductIssue> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkerProductIssuesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _workerIdMeta = const VerificationMeta(
    'workerId',
  );
  @override
  late final GeneratedColumn<int> workerId = GeneratedColumn<int>(
    'worker_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productNameMeta = const VerificationMeta(
    'productName',
  );
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
    'product_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
    'unit_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    workerId,
    productId,
    productName,
    barcode,
    quantity,
    unitPrice,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'worker_product_issues';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkerProductIssue> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('worker_id')) {
      context.handle(
        _workerIdMeta,
        workerId.isAcceptableOrUnknown(data['worker_id']!, _workerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_workerIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('product_name')) {
      context.handle(
        _productNameMeta,
        productName.isAcceptableOrUnknown(
          data['product_name']!,
          _productNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
      );
    } else if (isInserting) {
      context.missing(_barcodeMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkerProductIssue map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkerProductIssue(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      workerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}worker_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      productName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_name'],
      )!,
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_price'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $WorkerProductIssuesTable createAlias(String alias) {
    return $WorkerProductIssuesTable(attachedDatabase, alias);
  }
}

class WorkerProductIssue extends DataClass
    implements Insertable<WorkerProductIssue> {
  final int id;
  final int workerId;

  /// Product identity snapshot: history remains readable if the catalog item changes.
  final int productId;
  final String productName;
  final String barcode;
  final int quantity;

  /// Selling price captured when the product was issued.
  final double unitPrice;
  final DateTime createdAt;
  const WorkerProductIssue({
    required this.id,
    required this.workerId,
    required this.productId,
    required this.productName,
    required this.barcode,
    required this.quantity,
    required this.unitPrice,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['worker_id'] = Variable<int>(workerId);
    map['product_id'] = Variable<int>(productId);
    map['product_name'] = Variable<String>(productName);
    map['barcode'] = Variable<String>(barcode);
    map['quantity'] = Variable<int>(quantity);
    map['unit_price'] = Variable<double>(unitPrice);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  WorkerProductIssuesCompanion toCompanion(bool nullToAbsent) {
    return WorkerProductIssuesCompanion(
      id: Value(id),
      workerId: Value(workerId),
      productId: Value(productId),
      productName: Value(productName),
      barcode: Value(barcode),
      quantity: Value(quantity),
      unitPrice: Value(unitPrice),
      createdAt: Value(createdAt),
    );
  }

  factory WorkerProductIssue.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkerProductIssue(
      id: serializer.fromJson<int>(json['id']),
      workerId: serializer.fromJson<int>(json['workerId']),
      productId: serializer.fromJson<int>(json['productId']),
      productName: serializer.fromJson<String>(json['productName']),
      barcode: serializer.fromJson<String>(json['barcode']),
      quantity: serializer.fromJson<int>(json['quantity']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'workerId': serializer.toJson<int>(workerId),
      'productId': serializer.toJson<int>(productId),
      'productName': serializer.toJson<String>(productName),
      'barcode': serializer.toJson<String>(barcode),
      'quantity': serializer.toJson<int>(quantity),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  WorkerProductIssue copyWith({
    int? id,
    int? workerId,
    int? productId,
    String? productName,
    String? barcode,
    int? quantity,
    double? unitPrice,
    DateTime? createdAt,
  }) => WorkerProductIssue(
    id: id ?? this.id,
    workerId: workerId ?? this.workerId,
    productId: productId ?? this.productId,
    productName: productName ?? this.productName,
    barcode: barcode ?? this.barcode,
    quantity: quantity ?? this.quantity,
    unitPrice: unitPrice ?? this.unitPrice,
    createdAt: createdAt ?? this.createdAt,
  );
  WorkerProductIssue copyWithCompanion(WorkerProductIssuesCompanion data) {
    return WorkerProductIssue(
      id: data.id.present ? data.id.value : this.id,
      workerId: data.workerId.present ? data.workerId.value : this.workerId,
      productId: data.productId.present ? data.productId.value : this.productId,
      productName: data.productName.present
          ? data.productName.value
          : this.productName,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkerProductIssue(')
          ..write('id: $id, ')
          ..write('workerId: $workerId, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('barcode: $barcode, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    workerId,
    productId,
    productName,
    barcode,
    quantity,
    unitPrice,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkerProductIssue &&
          other.id == this.id &&
          other.workerId == this.workerId &&
          other.productId == this.productId &&
          other.productName == this.productName &&
          other.barcode == this.barcode &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice &&
          other.createdAt == this.createdAt);
}

class WorkerProductIssuesCompanion extends UpdateCompanion<WorkerProductIssue> {
  final Value<int> id;
  final Value<int> workerId;
  final Value<int> productId;
  final Value<String> productName;
  final Value<String> barcode;
  final Value<int> quantity;
  final Value<double> unitPrice;
  final Value<DateTime> createdAt;
  const WorkerProductIssuesCompanion({
    this.id = const Value.absent(),
    this.workerId = const Value.absent(),
    this.productId = const Value.absent(),
    this.productName = const Value.absent(),
    this.barcode = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  WorkerProductIssuesCompanion.insert({
    this.id = const Value.absent(),
    required int workerId,
    required int productId,
    required String productName,
    required String barcode,
    this.quantity = const Value.absent(),
    required double unitPrice,
    this.createdAt = const Value.absent(),
  }) : workerId = Value(workerId),
       productId = Value(productId),
       productName = Value(productName),
       barcode = Value(barcode),
       unitPrice = Value(unitPrice);
  static Insertable<WorkerProductIssue> custom({
    Expression<int>? id,
    Expression<int>? workerId,
    Expression<int>? productId,
    Expression<String>? productName,
    Expression<String>? barcode,
    Expression<int>? quantity,
    Expression<double>? unitPrice,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workerId != null) 'worker_id': workerId,
      if (productId != null) 'product_id': productId,
      if (productName != null) 'product_name': productName,
      if (barcode != null) 'barcode': barcode,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  WorkerProductIssuesCompanion copyWith({
    Value<int>? id,
    Value<int>? workerId,
    Value<int>? productId,
    Value<String>? productName,
    Value<String>? barcode,
    Value<int>? quantity,
    Value<double>? unitPrice,
    Value<DateTime>? createdAt,
  }) {
    return WorkerProductIssuesCompanion(
      id: id ?? this.id,
      workerId: workerId ?? this.workerId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      barcode: barcode ?? this.barcode,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (workerId.present) {
      map['worker_id'] = Variable<int>(workerId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkerProductIssuesCompanion(')
          ..write('id: $id, ')
          ..write('workerId: $workerId, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('barcode: $barcode, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PaymentAccountTransactionsTable extends PaymentAccountTransactions
    with
        TableInfo<$PaymentAccountTransactionsTable, PaymentAccountTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentAccountTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<int> accountId = GeneratedColumn<int>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES payment_accounts (id)',
    ),
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<int> invoiceId = GeneratedColumn<int>(
    'invoice_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES invoices (id)',
    ),
  );
  static const VerificationMeta _invoiceNumberMeta = const VerificationMeta(
    'invoiceNumber',
  );
  @override
  late final GeneratedColumn<String> invoiceNumber = GeneratedColumn<String>(
    'invoice_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accountId,
    invoiceId,
    invoiceNumber,
    userId,
    kind,
    amount,
    note,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payment_account_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<PaymentAccountTransaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    }
    if (data.containsKey('invoice_number')) {
      context.handle(
        _invoiceNumberMeta,
        invoiceNumber.isAcceptableOrUnknown(
          data['invoice_number']!,
          _invoiceNumberMeta,
        ),
      );
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaymentAccountTransaction map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentAccountTransaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}account_id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}invoice_id'],
      ),
      invoiceNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_number'],
      ),
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PaymentAccountTransactionsTable createAlias(String alias) {
    return $PaymentAccountTransactionsTable(attachedDatabase, alias);
  }
}

class PaymentAccountTransaction extends DataClass
    implements Insertable<PaymentAccountTransaction> {
  final int id;
  final int accountId;
  final int? invoiceId;
  final String? invoiceNumber;
  final int userId;

  /// sale/opening_balance/deposit increase the account balance;
  /// refund/withdrawal decrease it. Entries are immutable ledger movements.
  final String kind;

  /// Always stored as a positive amount; kind determines the balance sign.
  final double amount;
  final String? note;
  final DateTime createdAt;
  const PaymentAccountTransaction({
    required this.id,
    required this.accountId,
    this.invoiceId,
    this.invoiceNumber,
    required this.userId,
    required this.kind,
    required this.amount,
    this.note,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['account_id'] = Variable<int>(accountId);
    if (!nullToAbsent || invoiceId != null) {
      map['invoice_id'] = Variable<int>(invoiceId);
    }
    if (!nullToAbsent || invoiceNumber != null) {
      map['invoice_number'] = Variable<String>(invoiceNumber);
    }
    map['user_id'] = Variable<int>(userId);
    map['kind'] = Variable<String>(kind);
    map['amount'] = Variable<double>(amount);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PaymentAccountTransactionsCompanion toCompanion(bool nullToAbsent) {
    return PaymentAccountTransactionsCompanion(
      id: Value(id),
      accountId: Value(accountId),
      invoiceId: invoiceId == null && nullToAbsent
          ? const Value.absent()
          : Value(invoiceId),
      invoiceNumber: invoiceNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(invoiceNumber),
      userId: Value(userId),
      kind: Value(kind),
      amount: Value(amount),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
    );
  }

  factory PaymentAccountTransaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentAccountTransaction(
      id: serializer.fromJson<int>(json['id']),
      accountId: serializer.fromJson<int>(json['accountId']),
      invoiceId: serializer.fromJson<int?>(json['invoiceId']),
      invoiceNumber: serializer.fromJson<String?>(json['invoiceNumber']),
      userId: serializer.fromJson<int>(json['userId']),
      kind: serializer.fromJson<String>(json['kind']),
      amount: serializer.fromJson<double>(json['amount']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'accountId': serializer.toJson<int>(accountId),
      'invoiceId': serializer.toJson<int?>(invoiceId),
      'invoiceNumber': serializer.toJson<String?>(invoiceNumber),
      'userId': serializer.toJson<int>(userId),
      'kind': serializer.toJson<String>(kind),
      'amount': serializer.toJson<double>(amount),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PaymentAccountTransaction copyWith({
    int? id,
    int? accountId,
    Value<int?> invoiceId = const Value.absent(),
    Value<String?> invoiceNumber = const Value.absent(),
    int? userId,
    String? kind,
    double? amount,
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
  }) => PaymentAccountTransaction(
    id: id ?? this.id,
    accountId: accountId ?? this.accountId,
    invoiceId: invoiceId.present ? invoiceId.value : this.invoiceId,
    invoiceNumber: invoiceNumber.present
        ? invoiceNumber.value
        : this.invoiceNumber,
    userId: userId ?? this.userId,
    kind: kind ?? this.kind,
    amount: amount ?? this.amount,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
  );
  PaymentAccountTransaction copyWithCompanion(
    PaymentAccountTransactionsCompanion data,
  ) {
    return PaymentAccountTransaction(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      invoiceNumber: data.invoiceNumber.present
          ? data.invoiceNumber.value
          : this.invoiceNumber,
      userId: data.userId.present ? data.userId.value : this.userId,
      kind: data.kind.present ? data.kind.value : this.kind,
      amount: data.amount.present ? data.amount.value : this.amount,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentAccountTransaction(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('userId: $userId, ')
          ..write('kind: $kind, ')
          ..write('amount: $amount, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    accountId,
    invoiceId,
    invoiceNumber,
    userId,
    kind,
    amount,
    note,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentAccountTransaction &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.invoiceId == this.invoiceId &&
          other.invoiceNumber == this.invoiceNumber &&
          other.userId == this.userId &&
          other.kind == this.kind &&
          other.amount == this.amount &&
          other.note == this.note &&
          other.createdAt == this.createdAt);
}

class PaymentAccountTransactionsCompanion
    extends UpdateCompanion<PaymentAccountTransaction> {
  final Value<int> id;
  final Value<int> accountId;
  final Value<int?> invoiceId;
  final Value<String?> invoiceNumber;
  final Value<int> userId;
  final Value<String> kind;
  final Value<double> amount;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  const PaymentAccountTransactionsCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.invoiceNumber = const Value.absent(),
    this.userId = const Value.absent(),
    this.kind = const Value.absent(),
    this.amount = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PaymentAccountTransactionsCompanion.insert({
    this.id = const Value.absent(),
    required int accountId,
    this.invoiceId = const Value.absent(),
    this.invoiceNumber = const Value.absent(),
    required int userId,
    required String kind,
    required double amount,
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : accountId = Value(accountId),
       userId = Value(userId),
       kind = Value(kind),
       amount = Value(amount);
  static Insertable<PaymentAccountTransaction> custom({
    Expression<int>? id,
    Expression<int>? accountId,
    Expression<int>? invoiceId,
    Expression<String>? invoiceNumber,
    Expression<int>? userId,
    Expression<String>? kind,
    Expression<double>? amount,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (invoiceNumber != null) 'invoice_number': invoiceNumber,
      if (userId != null) 'user_id': userId,
      if (kind != null) 'kind': kind,
      if (amount != null) 'amount': amount,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PaymentAccountTransactionsCompanion copyWith({
    Value<int>? id,
    Value<int>? accountId,
    Value<int?>? invoiceId,
    Value<String?>? invoiceNumber,
    Value<int>? userId,
    Value<String>? kind,
    Value<double>? amount,
    Value<String?>? note,
    Value<DateTime>? createdAt,
  }) {
    return PaymentAccountTransactionsCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      invoiceId: invoiceId ?? this.invoiceId,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      userId: userId ?? this.userId,
      kind: kind ?? this.kind,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<int>(invoiceId.value);
    }
    if (invoiceNumber.present) {
      map['invoice_number'] = Variable<String>(invoiceNumber.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentAccountTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('userId: $userId, ')
          ..write('kind: $kind, ')
          ..write('amount: $amount, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $InvoicesTable invoices = $InvoicesTable(this);
  late final $InvoiceItemsTable invoiceItems = $InvoiceItemsTable(this);
  late final $StockMovementsTable stockMovements = $StockMovementsTable(this);
  late final $SuppliersTable suppliers = $SuppliersTable(this);
  late final $PurchasesTable purchases = $PurchasesTable(this);
  late final $PurchaseItemsTable purchaseItems = $PurchaseItemsTable(this);
  late final $PurchasePaymentsTable purchasePayments = $PurchasePaymentsTable(
    this,
  );
  late final $PaymentAccountsTable paymentAccounts = $PaymentAccountsTable(
    this,
  );
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $DailyClosingsTable dailyClosings = $DailyClosingsTable(this);
  late final $DebtPaymentsTable debtPayments = $DebtPaymentsTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $WorkerAdvancesTable workerAdvances = $WorkerAdvancesTable(this);
  late final $WorkerProductIssuesTable workerProductIssues =
      $WorkerProductIssuesTable(this);
  late final $PaymentAccountTransactionsTable paymentAccountTransactions =
      $PaymentAccountTransactionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    products,
    customers,
    invoices,
    invoiceItems,
    stockMovements,
    suppliers,
    purchases,
    purchaseItems,
    purchasePayments,
    paymentAccounts,
    expenses,
    dailyClosings,
    debtPayments,
    appSettings,
    workerAdvances,
    workerProductIssues,
    paymentAccountTransactions,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'invoices',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('invoice_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('worker_advances', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('worker_product_issues', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      required String username,
      required String passwordHash,
      required String fullName,
      Value<String?> phone,
      Value<String> jobTitle,
      Value<double> salary,
      Value<String?> barcode,
      Value<bool> isWorker,
      Value<String> role,
      Value<String?> image,
      Value<bool> isActive,
      Value<DateTime?> lastLogin,
      Value<bool> isLoggedIn,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      Value<String> username,
      Value<String> passwordHash,
      Value<String> fullName,
      Value<String?> phone,
      Value<String> jobTitle,
      Value<double> salary,
      Value<String?> barcode,
      Value<bool> isWorker,
      Value<String> role,
      Value<String?> image,
      Value<bool> isActive,
      Value<DateTime?> lastLogin,
      Value<bool> isLoggedIn,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$InvoicesTable, List<Invoice>> _invoicesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.invoices,
    aliasName: $_aliasNameGenerator(db.users.id, db.invoices.userId),
  );

  $$InvoicesTableProcessedTableManager get invoicesRefs {
    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoicesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StockMovementsTable, List<StockMovement>>
  _stockMovementsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.stockMovements,
    aliasName: $_aliasNameGenerator(db.users.id, db.stockMovements.userId),
  );

  $$StockMovementsTableProcessedTableManager get stockMovementsRefs {
    final manager = $$StockMovementsTableTableManager(
      $_db,
      $_db.stockMovements,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_stockMovementsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DebtPaymentsTable, List<DebtPayment>>
  _debtPaymentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.debtPayments,
    aliasName: $_aliasNameGenerator(db.users.id, db.debtPayments.userId),
  );

  $$DebtPaymentsTableProcessedTableManager get debtPaymentsRefs {
    final manager = $$DebtPaymentsTableTableManager(
      $_db,
      $_db.debtPayments,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_debtPaymentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WorkerAdvancesTable, List<WorkerAdvance>>
  _workerAdvancesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.workerAdvances,
    aliasName: $_aliasNameGenerator(db.users.id, db.workerAdvances.workerId),
  );

  $$WorkerAdvancesTableProcessedTableManager get workerAdvancesRefs {
    final manager = $$WorkerAdvancesTableTableManager(
      $_db,
      $_db.workerAdvances,
    ).filter((f) => f.workerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_workerAdvancesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $WorkerProductIssuesTable,
    List<WorkerProductIssue>
  >
  _workerProductIssuesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.workerProductIssues,
        aliasName: $_aliasNameGenerator(
          db.users.id,
          db.workerProductIssues.workerId,
        ),
      );

  $$WorkerProductIssuesTableProcessedTableManager get workerProductIssuesRefs {
    final manager = $$WorkerProductIssuesTableTableManager(
      $_db,
      $_db.workerProductIssues,
    ).filter((f) => f.workerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _workerProductIssuesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $PaymentAccountTransactionsTable,
    List<PaymentAccountTransaction>
  >
  _paymentAccountTransactionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.paymentAccountTransactions,
        aliasName: $_aliasNameGenerator(
          db.users.id,
          db.paymentAccountTransactions.userId,
        ),
      );

  $$PaymentAccountTransactionsTableProcessedTableManager
  get paymentAccountTransactionsRefs {
    final manager = $$PaymentAccountTransactionsTableTableManager(
      $_db,
      $_db.paymentAccountTransactions,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _paymentAccountTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jobTitle => $composableBuilder(
    column: $table.jobTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get salary => $composableBuilder(
    column: $table.salary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isWorker => $composableBuilder(
    column: $table.isWorker,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastLogin => $composableBuilder(
    column: $table.lastLogin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isLoggedIn => $composableBuilder(
    column: $table.isLoggedIn,
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

  Expression<bool> invoicesRefs(
    Expression<bool> Function($$InvoicesTableFilterComposer f) f,
  ) {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> stockMovementsRefs(
    Expression<bool> Function($$StockMovementsTableFilterComposer f) f,
  ) {
    final $$StockMovementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockMovements,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StockMovementsTableFilterComposer(
            $db: $db,
            $table: $db.stockMovements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> debtPaymentsRefs(
    Expression<bool> Function($$DebtPaymentsTableFilterComposer f) f,
  ) {
    final $$DebtPaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.debtPayments,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DebtPaymentsTableFilterComposer(
            $db: $db,
            $table: $db.debtPayments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> workerAdvancesRefs(
    Expression<bool> Function($$WorkerAdvancesTableFilterComposer f) f,
  ) {
    final $$WorkerAdvancesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workerAdvances,
      getReferencedColumn: (t) => t.workerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkerAdvancesTableFilterComposer(
            $db: $db,
            $table: $db.workerAdvances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> workerProductIssuesRefs(
    Expression<bool> Function($$WorkerProductIssuesTableFilterComposer f) f,
  ) {
    final $$WorkerProductIssuesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workerProductIssues,
      getReferencedColumn: (t) => t.workerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkerProductIssuesTableFilterComposer(
            $db: $db,
            $table: $db.workerProductIssues,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> paymentAccountTransactionsRefs(
    Expression<bool> Function($$PaymentAccountTransactionsTableFilterComposer f)
    f,
  ) {
    final $$PaymentAccountTransactionsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.paymentAccountTransactions,
          getReferencedColumn: (t) => t.userId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PaymentAccountTransactionsTableFilterComposer(
                $db: $db,
                $table: $db.paymentAccountTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jobTitle => $composableBuilder(
    column: $table.jobTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get salary => $composableBuilder(
    column: $table.salary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isWorker => $composableBuilder(
    column: $table.isWorker,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastLogin => $composableBuilder(
    column: $table.lastLogin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isLoggedIn => $composableBuilder(
    column: $table.isLoggedIn,
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

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get jobTitle =>
      $composableBuilder(column: $table.jobTitle, builder: (column) => column);

  GeneratedColumn<double> get salary =>
      $composableBuilder(column: $table.salary, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<bool> get isWorker =>
      $composableBuilder(column: $table.isWorker, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get lastLogin =>
      $composableBuilder(column: $table.lastLogin, builder: (column) => column);

  GeneratedColumn<bool> get isLoggedIn => $composableBuilder(
    column: $table.isLoggedIn,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> invoicesRefs<T extends Object>(
    Expression<T> Function($$InvoicesTableAnnotationComposer a) f,
  ) {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> stockMovementsRefs<T extends Object>(
    Expression<T> Function($$StockMovementsTableAnnotationComposer a) f,
  ) {
    final $$StockMovementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockMovements,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StockMovementsTableAnnotationComposer(
            $db: $db,
            $table: $db.stockMovements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> debtPaymentsRefs<T extends Object>(
    Expression<T> Function($$DebtPaymentsTableAnnotationComposer a) f,
  ) {
    final $$DebtPaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.debtPayments,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DebtPaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.debtPayments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> workerAdvancesRefs<T extends Object>(
    Expression<T> Function($$WorkerAdvancesTableAnnotationComposer a) f,
  ) {
    final $$WorkerAdvancesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workerAdvances,
      getReferencedColumn: (t) => t.workerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkerAdvancesTableAnnotationComposer(
            $db: $db,
            $table: $db.workerAdvances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> workerProductIssuesRefs<T extends Object>(
    Expression<T> Function($$WorkerProductIssuesTableAnnotationComposer a) f,
  ) {
    final $$WorkerProductIssuesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.workerProductIssues,
          getReferencedColumn: (t) => t.workerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WorkerProductIssuesTableAnnotationComposer(
                $db: $db,
                $table: $db.workerProductIssues,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> paymentAccountTransactionsRefs<T extends Object>(
    Expression<T> Function(
      $$PaymentAccountTransactionsTableAnnotationComposer a,
    )
    f,
  ) {
    final $$PaymentAccountTransactionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.paymentAccountTransactions,
          getReferencedColumn: (t) => t.userId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PaymentAccountTransactionsTableAnnotationComposer(
                $db: $db,
                $table: $db.paymentAccountTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, $$UsersTableReferences),
          User,
          PrefetchHooks Function({
            bool invoicesRefs,
            bool stockMovementsRefs,
            bool debtPaymentsRefs,
            bool workerAdvancesRefs,
            bool workerProductIssuesRefs,
            bool paymentAccountTransactionsRefs,
          })
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> passwordHash = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String> jobTitle = const Value.absent(),
                Value<double> salary = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<bool> isWorker = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String?> image = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime?> lastLogin = const Value.absent(),
                Value<bool> isLoggedIn = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                username: username,
                passwordHash: passwordHash,
                fullName: fullName,
                phone: phone,
                jobTitle: jobTitle,
                salary: salary,
                barcode: barcode,
                isWorker: isWorker,
                role: role,
                image: image,
                isActive: isActive,
                lastLogin: lastLogin,
                isLoggedIn: isLoggedIn,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String username,
                required String passwordHash,
                required String fullName,
                Value<String?> phone = const Value.absent(),
                Value<String> jobTitle = const Value.absent(),
                Value<double> salary = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<bool> isWorker = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String?> image = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime?> lastLogin = const Value.absent(),
                Value<bool> isLoggedIn = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                username: username,
                passwordHash: passwordHash,
                fullName: fullName,
                phone: phone,
                jobTitle: jobTitle,
                salary: salary,
                barcode: barcode,
                isWorker: isWorker,
                role: role,
                image: image,
                isActive: isActive,
                lastLogin: lastLogin,
                isLoggedIn: isLoggedIn,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$UsersTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                invoicesRefs = false,
                stockMovementsRefs = false,
                debtPaymentsRefs = false,
                workerAdvancesRefs = false,
                workerProductIssuesRefs = false,
                paymentAccountTransactionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (invoicesRefs) db.invoices,
                    if (stockMovementsRefs) db.stockMovements,
                    if (debtPaymentsRefs) db.debtPayments,
                    if (workerAdvancesRefs) db.workerAdvances,
                    if (workerProductIssuesRefs) db.workerProductIssues,
                    if (paymentAccountTransactionsRefs)
                      db.paymentAccountTransactions,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (invoicesRefs)
                        await $_getPrefetchedData<User, $UsersTable, Invoice>(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._invoicesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).invoicesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (stockMovementsRefs)
                        await $_getPrefetchedData<
                          User,
                          $UsersTable,
                          StockMovement
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._stockMovementsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).stockMovementsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (debtPaymentsRefs)
                        await $_getPrefetchedData<
                          User,
                          $UsersTable,
                          DebtPayment
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._debtPaymentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).debtPaymentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (workerAdvancesRefs)
                        await $_getPrefetchedData<
                          User,
                          $UsersTable,
                          WorkerAdvance
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._workerAdvancesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).workerAdvancesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.workerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (workerProductIssuesRefs)
                        await $_getPrefetchedData<
                          User,
                          $UsersTable,
                          WorkerProductIssue
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._workerProductIssuesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).workerProductIssuesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.workerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (paymentAccountTransactionsRefs)
                        await $_getPrefetchedData<
                          User,
                          $UsersTable,
                          PaymentAccountTransaction
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._paymentAccountTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentAccountTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, $$UsersTableReferences),
      User,
      PrefetchHooks Function({
        bool invoicesRefs,
        bool stockMovementsRefs,
        bool debtPaymentsRefs,
        bool workerAdvancesRefs,
        bool workerProductIssuesRefs,
        bool paymentAccountTransactionsRefs,
      })
    >;
typedef $$ProductsTableCreateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      required String name,
      required String barcode,
      required String category,
      Value<String> unit,
      Value<double> purchasePrice,
      required double price,
      Value<double> cartonPrice,
      Value<int> unitsPerCarton,
      Value<double> cartonQuantity,
      required int stockQuantity,
      Value<int> minStockLimit,
      Value<bool> isActive,
      Value<String?> imageUrl,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$ProductsTableUpdateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> barcode,
      Value<String> category,
      Value<String> unit,
      Value<double> purchasePrice,
      Value<double> price,
      Value<double> cartonPrice,
      Value<int> unitsPerCarton,
      Value<double> cartonQuantity,
      Value<int> stockQuantity,
      Value<int> minStockLimit,
      Value<bool> isActive,
      Value<String?> imageUrl,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$ProductsTableReferences
    extends BaseReferences<_$AppDatabase, $ProductsTable, Product> {
  $$ProductsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$InvoiceItemsTable, List<InvoiceItem>>
  _invoiceItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.invoiceItems,
    aliasName: $_aliasNameGenerator(db.products.id, db.invoiceItems.productId),
  );

  $$InvoiceItemsTableProcessedTableManager get invoiceItemsRefs {
    final manager = $$InvoiceItemsTableTableManager(
      $_db,
      $_db.invoiceItems,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoiceItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StockMovementsTable, List<StockMovement>>
  _stockMovementsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.stockMovements,
    aliasName: $_aliasNameGenerator(
      db.products.id,
      db.stockMovements.productId,
    ),
  );

  $$StockMovementsTableProcessedTableManager get stockMovementsRefs {
    final manager = $$StockMovementsTableTableManager(
      $_db,
      $_db.stockMovements,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_stockMovementsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PurchaseItemsTable, List<PurchaseItem>>
  _purchaseItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.purchaseItems,
    aliasName: $_aliasNameGenerator(db.products.id, db.purchaseItems.productId),
  );

  $$PurchaseItemsTableProcessedTableManager get purchaseItemsRefs {
    final manager = $$PurchaseItemsTableTableManager(
      $_db,
      $_db.purchaseItems,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_purchaseItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cartonPrice => $composableBuilder(
    column: $table.cartonPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unitsPerCarton => $composableBuilder(
    column: $table.unitsPerCarton,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cartonQuantity => $composableBuilder(
    column: $table.cartonQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stockQuantity => $composableBuilder(
    column: $table.stockQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minStockLimit => $composableBuilder(
    column: $table.minStockLimit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
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

  Expression<bool> invoiceItemsRefs(
    Expression<bool> Function($$InvoiceItemsTableFilterComposer f) f,
  ) {
    final $$InvoiceItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoiceItems,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceItemsTableFilterComposer(
            $db: $db,
            $table: $db.invoiceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> stockMovementsRefs(
    Expression<bool> Function($$StockMovementsTableFilterComposer f) f,
  ) {
    final $$StockMovementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockMovements,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StockMovementsTableFilterComposer(
            $db: $db,
            $table: $db.stockMovements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> purchaseItemsRefs(
    Expression<bool> Function($$PurchaseItemsTableFilterComposer f) f,
  ) {
    final $$PurchaseItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseItems,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseItemsTableFilterComposer(
            $db: $db,
            $table: $db.purchaseItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cartonPrice => $composableBuilder(
    column: $table.cartonPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unitsPerCarton => $composableBuilder(
    column: $table.unitsPerCarton,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cartonQuantity => $composableBuilder(
    column: $table.cartonQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stockQuantity => $composableBuilder(
    column: $table.stockQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minStockLimit => $composableBuilder(
    column: $table.minStockLimit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
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

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<double> get cartonPrice => $composableBuilder(
    column: $table.cartonPrice,
    builder: (column) => column,
  );

  GeneratedColumn<int> get unitsPerCarton => $composableBuilder(
    column: $table.unitsPerCarton,
    builder: (column) => column,
  );

  GeneratedColumn<double> get cartonQuantity => $composableBuilder(
    column: $table.cartonQuantity,
    builder: (column) => column,
  );

  GeneratedColumn<int> get stockQuantity => $composableBuilder(
    column: $table.stockQuantity,
    builder: (column) => column,
  );

  GeneratedColumn<int> get minStockLimit => $composableBuilder(
    column: $table.minStockLimit,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> invoiceItemsRefs<T extends Object>(
    Expression<T> Function($$InvoiceItemsTableAnnotationComposer a) f,
  ) {
    final $$InvoiceItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoiceItems,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.invoiceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> stockMovementsRefs<T extends Object>(
    Expression<T> Function($$StockMovementsTableAnnotationComposer a) f,
  ) {
    final $$StockMovementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockMovements,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StockMovementsTableAnnotationComposer(
            $db: $db,
            $table: $db.stockMovements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> purchaseItemsRefs<T extends Object>(
    Expression<T> Function($$PurchaseItemsTableAnnotationComposer a) f,
  ) {
    final $$PurchaseItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseItems,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.purchaseItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          Product,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (Product, $$ProductsTableReferences),
          Product,
          PrefetchHooks Function({
            bool invoiceItemsRefs,
            bool stockMovementsRefs,
            bool purchaseItemsRefs,
          })
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> barcode = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<double> purchasePrice = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<double> cartonPrice = const Value.absent(),
                Value<int> unitsPerCarton = const Value.absent(),
                Value<double> cartonQuantity = const Value.absent(),
                Value<int> stockQuantity = const Value.absent(),
                Value<int> minStockLimit = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                name: name,
                barcode: barcode,
                category: category,
                unit: unit,
                purchasePrice: purchasePrice,
                price: price,
                cartonPrice: cartonPrice,
                unitsPerCarton: unitsPerCarton,
                cartonQuantity: cartonQuantity,
                stockQuantity: stockQuantity,
                minStockLimit: minStockLimit,
                isActive: isActive,
                imageUrl: imageUrl,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String barcode,
                required String category,
                Value<String> unit = const Value.absent(),
                Value<double> purchasePrice = const Value.absent(),
                required double price,
                Value<double> cartonPrice = const Value.absent(),
                Value<int> unitsPerCarton = const Value.absent(),
                Value<double> cartonQuantity = const Value.absent(),
                required int stockQuantity,
                Value<int> minStockLimit = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ProductsCompanion.insert(
                id: id,
                name: name,
                barcode: barcode,
                category: category,
                unit: unit,
                purchasePrice: purchasePrice,
                price: price,
                cartonPrice: cartonPrice,
                unitsPerCarton: unitsPerCarton,
                cartonQuantity: cartonQuantity,
                stockQuantity: stockQuantity,
                minStockLimit: minStockLimit,
                isActive: isActive,
                imageUrl: imageUrl,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                invoiceItemsRefs = false,
                stockMovementsRefs = false,
                purchaseItemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (invoiceItemsRefs) db.invoiceItems,
                    if (stockMovementsRefs) db.stockMovements,
                    if (purchaseItemsRefs) db.purchaseItems,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (invoiceItemsRefs)
                        await $_getPrefetchedData<
                          Product,
                          $ProductsTable,
                          InvoiceItem
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._invoiceItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).invoiceItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (stockMovementsRefs)
                        await $_getPrefetchedData<
                          Product,
                          $ProductsTable,
                          StockMovement
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._stockMovementsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).stockMovementsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (purchaseItemsRefs)
                        await $_getPrefetchedData<
                          Product,
                          $ProductsTable,
                          PurchaseItem
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._purchaseItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).purchaseItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      Product,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (Product, $$ProductsTableReferences),
      Product,
      PrefetchHooks Function({
        bool invoiceItemsRefs,
        bool stockMovementsRefs,
        bool purchaseItemsRefs,
      })
    >;
typedef $$CustomersTableCreateCompanionBuilder =
    CustomersCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> phone,
      Value<String> address,
      Value<double> totalDebt,
      Value<DateTime> createdAt,
    });
typedef $$CustomersTableUpdateCompanionBuilder =
    CustomersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> phone,
      Value<String> address,
      Value<double> totalDebt,
      Value<DateTime> createdAt,
    });

final class $$CustomersTableReferences
    extends BaseReferences<_$AppDatabase, $CustomersTable, Customer> {
  $$CustomersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$InvoicesTable, List<Invoice>> _invoicesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.invoices,
    aliasName: $_aliasNameGenerator(db.customers.id, db.invoices.customerId),
  );

  $$InvoicesTableProcessedTableManager get invoicesRefs {
    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.customerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoicesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CustomersTableFilterComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalDebt => $composableBuilder(
    column: $table.totalDebt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> invoicesRefs(
    Expression<bool> Function($$InvoicesTableFilterComposer f) f,
  ) {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomersTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalDebt => $composableBuilder(
    column: $table.totalDebt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<double> get totalDebt =>
      $composableBuilder(column: $table.totalDebt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> invoicesRefs<T extends Object>(
    Expression<T> Function($$InvoicesTableAnnotationComposer a) f,
  ) {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomersTable,
          Customer,
          $$CustomersTableFilterComposer,
          $$CustomersTableOrderingComposer,
          $$CustomersTableAnnotationComposer,
          $$CustomersTableCreateCompanionBuilder,
          $$CustomersTableUpdateCompanionBuilder,
          (Customer, $$CustomersTableReferences),
          Customer,
          PrefetchHooks Function({bool invoicesRefs})
        > {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<double> totalDebt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CustomersCompanion(
                id: id,
                name: name,
                phone: phone,
                address: address,
                totalDebt: totalDebt,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> phone = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<double> totalDebt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CustomersCompanion.insert(
                id: id,
                name: name,
                phone: phone,
                address: address,
                totalDebt: totalDebt,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CustomersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({invoicesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (invoicesRefs) db.invoices],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (invoicesRefs)
                    await $_getPrefetchedData<
                      Customer,
                      $CustomersTable,
                      Invoice
                    >(
                      currentTable: table,
                      referencedTable: $$CustomersTableReferences
                          ._invoicesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CustomersTableReferences(
                            db,
                            table,
                            p0,
                          ).invoicesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.customerId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CustomersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomersTable,
      Customer,
      $$CustomersTableFilterComposer,
      $$CustomersTableOrderingComposer,
      $$CustomersTableAnnotationComposer,
      $$CustomersTableCreateCompanionBuilder,
      $$CustomersTableUpdateCompanionBuilder,
      (Customer, $$CustomersTableReferences),
      Customer,
      PrefetchHooks Function({bool invoicesRefs})
    >;
typedef $$InvoicesTableCreateCompanionBuilder =
    InvoicesCompanion Function({
      Value<int> id,
      required String invoiceNumber,
      required int userId,
      Value<int?> customerId,
      required double totalAmount,
      Value<double> discount,
      Value<double> tax,
      required double netAmount,
      Value<double> profit,
      Value<double> paidAmount,
      Value<double> remainingAmount,
      Value<String> paymentMethod,
      Value<String> status,
      Value<DateTime> createdAt,
    });
typedef $$InvoicesTableUpdateCompanionBuilder =
    InvoicesCompanion Function({
      Value<int> id,
      Value<String> invoiceNumber,
      Value<int> userId,
      Value<int?> customerId,
      Value<double> totalAmount,
      Value<double> discount,
      Value<double> tax,
      Value<double> netAmount,
      Value<double> profit,
      Value<double> paidAmount,
      Value<double> remainingAmount,
      Value<String> paymentMethod,
      Value<String> status,
      Value<DateTime> createdAt,
    });

final class $$InvoicesTableReferences
    extends BaseReferences<_$AppDatabase, $InvoicesTable, Invoice> {
  $$InvoicesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.invoices.userId, db.users.id),
  );

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CustomersTable _customerIdTable(_$AppDatabase db) =>
      db.customers.createAlias(
        $_aliasNameGenerator(db.invoices.customerId, db.customers.id),
      );

  $$CustomersTableProcessedTableManager? get customerId {
    final $_column = $_itemColumn<int>('customer_id');
    if ($_column == null) return null;
    final manager = $$CustomersTableTableManager(
      $_db,
      $_db.customers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$InvoiceItemsTable, List<InvoiceItem>>
  _invoiceItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.invoiceItems,
    aliasName: $_aliasNameGenerator(db.invoices.id, db.invoiceItems.invoiceId),
  );

  $$InvoiceItemsTableProcessedTableManager get invoiceItemsRefs {
    final manager = $$InvoiceItemsTableTableManager(
      $_db,
      $_db.invoiceItems,
    ).filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoiceItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DebtPaymentsTable, List<DebtPayment>>
  _debtPaymentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.debtPayments,
    aliasName: $_aliasNameGenerator(db.invoices.id, db.debtPayments.invoiceId),
  );

  $$DebtPaymentsTableProcessedTableManager get debtPaymentsRefs {
    final manager = $$DebtPaymentsTableTableManager(
      $_db,
      $_db.debtPayments,
    ).filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_debtPaymentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $PaymentAccountTransactionsTable,
    List<PaymentAccountTransaction>
  >
  _paymentAccountTransactionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.paymentAccountTransactions,
        aliasName: $_aliasNameGenerator(
          db.invoices.id,
          db.paymentAccountTransactions.invoiceId,
        ),
      );

  $$PaymentAccountTransactionsTableProcessedTableManager
  get paymentAccountTransactionsRefs {
    final manager = $$PaymentAccountTransactionsTableTableManager(
      $_db,
      $_db.paymentAccountTransactions,
    ).filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _paymentAccountTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$InvoicesTableFilterComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tax => $composableBuilder(
    column: $table.tax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get netAmount => $composableBuilder(
    column: $table.netAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get profit => $composableBuilder(
    column: $table.profit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get paidAmount => $composableBuilder(
    column: $table.paidAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get remainingAmount => $composableBuilder(
    column: $table.remainingAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableFilterComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> invoiceItemsRefs(
    Expression<bool> Function($$InvoiceItemsTableFilterComposer f) f,
  ) {
    final $$InvoiceItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoiceItems,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceItemsTableFilterComposer(
            $db: $db,
            $table: $db.invoiceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> debtPaymentsRefs(
    Expression<bool> Function($$DebtPaymentsTableFilterComposer f) f,
  ) {
    final $$DebtPaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.debtPayments,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DebtPaymentsTableFilterComposer(
            $db: $db,
            $table: $db.debtPayments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> paymentAccountTransactionsRefs(
    Expression<bool> Function($$PaymentAccountTransactionsTableFilterComposer f)
    f,
  ) {
    final $$PaymentAccountTransactionsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.paymentAccountTransactions,
          getReferencedColumn: (t) => t.invoiceId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PaymentAccountTransactionsTableFilterComposer(
                $db: $db,
                $table: $db.paymentAccountTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$InvoicesTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tax => $composableBuilder(
    column: $table.tax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get netAmount => $composableBuilder(
    column: $table.netAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get profit => $composableBuilder(
    column: $table.profit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get paidAmount => $composableBuilder(
    column: $table.paidAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get remainingAmount => $composableBuilder(
    column: $table.remainingAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableOrderingComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get discount =>
      $composableBuilder(column: $table.discount, builder: (column) => column);

  GeneratedColumn<double> get tax =>
      $composableBuilder(column: $table.tax, builder: (column) => column);

  GeneratedColumn<double> get netAmount =>
      $composableBuilder(column: $table.netAmount, builder: (column) => column);

  GeneratedColumn<double> get profit =>
      $composableBuilder(column: $table.profit, builder: (column) => column);

  GeneratedColumn<double> get paidAmount => $composableBuilder(
    column: $table.paidAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get remainingAmount => $composableBuilder(
    column: $table.remainingAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableAnnotationComposer get customerId {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> invoiceItemsRefs<T extends Object>(
    Expression<T> Function($$InvoiceItemsTableAnnotationComposer a) f,
  ) {
    final $$InvoiceItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoiceItems,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.invoiceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> debtPaymentsRefs<T extends Object>(
    Expression<T> Function($$DebtPaymentsTableAnnotationComposer a) f,
  ) {
    final $$DebtPaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.debtPayments,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DebtPaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.debtPayments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> paymentAccountTransactionsRefs<T extends Object>(
    Expression<T> Function(
      $$PaymentAccountTransactionsTableAnnotationComposer a,
    )
    f,
  ) {
    final $$PaymentAccountTransactionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.paymentAccountTransactions,
          getReferencedColumn: (t) => t.invoiceId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PaymentAccountTransactionsTableAnnotationComposer(
                $db: $db,
                $table: $db.paymentAccountTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$InvoicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoicesTable,
          Invoice,
          $$InvoicesTableFilterComposer,
          $$InvoicesTableOrderingComposer,
          $$InvoicesTableAnnotationComposer,
          $$InvoicesTableCreateCompanionBuilder,
          $$InvoicesTableUpdateCompanionBuilder,
          (Invoice, $$InvoicesTableReferences),
          Invoice,
          PrefetchHooks Function({
            bool userId,
            bool customerId,
            bool invoiceItemsRefs,
            bool debtPaymentsRefs,
            bool paymentAccountTransactionsRefs,
          })
        > {
  $$InvoicesTableTableManager(_$AppDatabase db, $InvoicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> invoiceNumber = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<int?> customerId = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<double> discount = const Value.absent(),
                Value<double> tax = const Value.absent(),
                Value<double> netAmount = const Value.absent(),
                Value<double> profit = const Value.absent(),
                Value<double> paidAmount = const Value.absent(),
                Value<double> remainingAmount = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => InvoicesCompanion(
                id: id,
                invoiceNumber: invoiceNumber,
                userId: userId,
                customerId: customerId,
                totalAmount: totalAmount,
                discount: discount,
                tax: tax,
                netAmount: netAmount,
                profit: profit,
                paidAmount: paidAmount,
                remainingAmount: remainingAmount,
                paymentMethod: paymentMethod,
                status: status,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String invoiceNumber,
                required int userId,
                Value<int?> customerId = const Value.absent(),
                required double totalAmount,
                Value<double> discount = const Value.absent(),
                Value<double> tax = const Value.absent(),
                required double netAmount,
                Value<double> profit = const Value.absent(),
                Value<double> paidAmount = const Value.absent(),
                Value<double> remainingAmount = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => InvoicesCompanion.insert(
                id: id,
                invoiceNumber: invoiceNumber,
                userId: userId,
                customerId: customerId,
                totalAmount: totalAmount,
                discount: discount,
                tax: tax,
                netAmount: netAmount,
                profit: profit,
                paidAmount: paidAmount,
                remainingAmount: remainingAmount,
                paymentMethod: paymentMethod,
                status: status,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InvoicesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                userId = false,
                customerId = false,
                invoiceItemsRefs = false,
                debtPaymentsRefs = false,
                paymentAccountTransactionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (invoiceItemsRefs) db.invoiceItems,
                    if (debtPaymentsRefs) db.debtPayments,
                    if (paymentAccountTransactionsRefs)
                      db.paymentAccountTransactions,
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
                        if (userId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.userId,
                                    referencedTable: $$InvoicesTableReferences
                                        ._userIdTable(db),
                                    referencedColumn: $$InvoicesTableReferences
                                        ._userIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (customerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.customerId,
                                    referencedTable: $$InvoicesTableReferences
                                        ._customerIdTable(db),
                                    referencedColumn: $$InvoicesTableReferences
                                        ._customerIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (invoiceItemsRefs)
                        await $_getPrefetchedData<
                          Invoice,
                          $InvoicesTable,
                          InvoiceItem
                        >(
                          currentTable: table,
                          referencedTable: $$InvoicesTableReferences
                              ._invoiceItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvoicesTableReferences(
                                db,
                                table,
                                p0,
                              ).invoiceItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.invoiceId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (debtPaymentsRefs)
                        await $_getPrefetchedData<
                          Invoice,
                          $InvoicesTable,
                          DebtPayment
                        >(
                          currentTable: table,
                          referencedTable: $$InvoicesTableReferences
                              ._debtPaymentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvoicesTableReferences(
                                db,
                                table,
                                p0,
                              ).debtPaymentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.invoiceId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (paymentAccountTransactionsRefs)
                        await $_getPrefetchedData<
                          Invoice,
                          $InvoicesTable,
                          PaymentAccountTransaction
                        >(
                          currentTable: table,
                          referencedTable: $$InvoicesTableReferences
                              ._paymentAccountTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvoicesTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentAccountTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.invoiceId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$InvoicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoicesTable,
      Invoice,
      $$InvoicesTableFilterComposer,
      $$InvoicesTableOrderingComposer,
      $$InvoicesTableAnnotationComposer,
      $$InvoicesTableCreateCompanionBuilder,
      $$InvoicesTableUpdateCompanionBuilder,
      (Invoice, $$InvoicesTableReferences),
      Invoice,
      PrefetchHooks Function({
        bool userId,
        bool customerId,
        bool invoiceItemsRefs,
        bool debtPaymentsRefs,
        bool paymentAccountTransactionsRefs,
      })
    >;
typedef $$InvoiceItemsTableCreateCompanionBuilder =
    InvoiceItemsCompanion Function({
      Value<int> id,
      required int invoiceId,
      required int productId,
      required String productName,
      required String barcode,
      required String category,
      required String unit,
      required double purchasePrice,
      required double unitPrice,
      required int quantity,
      required double totalPrice,
      Value<double> profit,
    });
typedef $$InvoiceItemsTableUpdateCompanionBuilder =
    InvoiceItemsCompanion Function({
      Value<int> id,
      Value<int> invoiceId,
      Value<int> productId,
      Value<String> productName,
      Value<String> barcode,
      Value<String> category,
      Value<String> unit,
      Value<double> purchasePrice,
      Value<double> unitPrice,
      Value<int> quantity,
      Value<double> totalPrice,
      Value<double> profit,
    });

final class $$InvoiceItemsTableReferences
    extends BaseReferences<_$AppDatabase, $InvoiceItemsTable, InvoiceItem> {
  $$InvoiceItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $InvoicesTable _invoiceIdTable(_$AppDatabase db) =>
      db.invoices.createAlias(
        $_aliasNameGenerator(db.invoiceItems.invoiceId, db.invoices.id),
      );

  $$InvoicesTableProcessedTableManager get invoiceId {
    final $_column = $_itemColumn<int>('invoice_id')!;

    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias(
        $_aliasNameGenerator(db.invoiceItems.productId, db.products.id),
      );

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InvoiceItemsTableFilterComposer
    extends Composer<_$AppDatabase, $InvoiceItemsTable> {
  $$InvoiceItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get profit => $composableBuilder(
    column: $table.profit,
    builder: (column) => ColumnFilters(column),
  );

  $$InvoicesTableFilterComposer get invoiceId {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoiceItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoiceItemsTable> {
  $$InvoiceItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get profit => $composableBuilder(
    column: $table.profit,
    builder: (column) => ColumnOrderings(column),
  );

  $$InvoicesTableOrderingComposer get invoiceId {
    final $$InvoicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableOrderingComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoiceItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoiceItemsTable> {
  $$InvoiceItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get profit =>
      $composableBuilder(column: $table.profit, builder: (column) => column);

  $$InvoicesTableAnnotationComposer get invoiceId {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoiceItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoiceItemsTable,
          InvoiceItem,
          $$InvoiceItemsTableFilterComposer,
          $$InvoiceItemsTableOrderingComposer,
          $$InvoiceItemsTableAnnotationComposer,
          $$InvoiceItemsTableCreateCompanionBuilder,
          $$InvoiceItemsTableUpdateCompanionBuilder,
          (InvoiceItem, $$InvoiceItemsTableReferences),
          InvoiceItem,
          PrefetchHooks Function({bool invoiceId, bool productId})
        > {
  $$InvoiceItemsTableTableManager(_$AppDatabase db, $InvoiceItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoiceItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoiceItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoiceItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> invoiceId = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<String> productName = const Value.absent(),
                Value<String> barcode = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<double> purchasePrice = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<double> totalPrice = const Value.absent(),
                Value<double> profit = const Value.absent(),
              }) => InvoiceItemsCompanion(
                id: id,
                invoiceId: invoiceId,
                productId: productId,
                productName: productName,
                barcode: barcode,
                category: category,
                unit: unit,
                purchasePrice: purchasePrice,
                unitPrice: unitPrice,
                quantity: quantity,
                totalPrice: totalPrice,
                profit: profit,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int invoiceId,
                required int productId,
                required String productName,
                required String barcode,
                required String category,
                required String unit,
                required double purchasePrice,
                required double unitPrice,
                required int quantity,
                required double totalPrice,
                Value<double> profit = const Value.absent(),
              }) => InvoiceItemsCompanion.insert(
                id: id,
                invoiceId: invoiceId,
                productId: productId,
                productName: productName,
                barcode: barcode,
                category: category,
                unit: unit,
                purchasePrice: purchasePrice,
                unitPrice: unitPrice,
                quantity: quantity,
                totalPrice: totalPrice,
                profit: profit,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InvoiceItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({invoiceId = false, productId = false}) {
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
                    if (invoiceId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.invoiceId,
                                referencedTable: $$InvoiceItemsTableReferences
                                    ._invoiceIdTable(db),
                                referencedColumn: $$InvoiceItemsTableReferences
                                    ._invoiceIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable: $$InvoiceItemsTableReferences
                                    ._productIdTable(db),
                                referencedColumn: $$InvoiceItemsTableReferences
                                    ._productIdTable(db)
                                    .id,
                              )
                              as T;
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

typedef $$InvoiceItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoiceItemsTable,
      InvoiceItem,
      $$InvoiceItemsTableFilterComposer,
      $$InvoiceItemsTableOrderingComposer,
      $$InvoiceItemsTableAnnotationComposer,
      $$InvoiceItemsTableCreateCompanionBuilder,
      $$InvoiceItemsTableUpdateCompanionBuilder,
      (InvoiceItem, $$InvoiceItemsTableReferences),
      InvoiceItem,
      PrefetchHooks Function({bool invoiceId, bool productId})
    >;
typedef $$StockMovementsTableCreateCompanionBuilder =
    StockMovementsCompanion Function({
      Value<int> id,
      required int productId,
      required int userId,
      required int quantity,
      required String type,
      Value<String?> note,
      Value<DateTime> createdAt,
    });
typedef $$StockMovementsTableUpdateCompanionBuilder =
    StockMovementsCompanion Function({
      Value<int> id,
      Value<int> productId,
      Value<int> userId,
      Value<int> quantity,
      Value<String> type,
      Value<String?> note,
      Value<DateTime> createdAt,
    });

final class $$StockMovementsTableReferences
    extends BaseReferences<_$AppDatabase, $StockMovementsTable, StockMovement> {
  $$StockMovementsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias(
        $_aliasNameGenerator(db.stockMovements.productId, db.products.id),
      );

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.stockMovements.userId, db.users.id),
  );

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StockMovementsTableFilterComposer
    extends Composer<_$AppDatabase, $StockMovementsTable> {
  $$StockMovementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StockMovementsTableOrderingComposer
    extends Composer<_$AppDatabase, $StockMovementsTable> {
  $$StockMovementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StockMovementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StockMovementsTable> {
  $$StockMovementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StockMovementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StockMovementsTable,
          StockMovement,
          $$StockMovementsTableFilterComposer,
          $$StockMovementsTableOrderingComposer,
          $$StockMovementsTableAnnotationComposer,
          $$StockMovementsTableCreateCompanionBuilder,
          $$StockMovementsTableUpdateCompanionBuilder,
          (StockMovement, $$StockMovementsTableReferences),
          StockMovement,
          PrefetchHooks Function({bool productId, bool userId})
        > {
  $$StockMovementsTableTableManager(
    _$AppDatabase db,
    $StockMovementsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StockMovementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StockMovementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StockMovementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => StockMovementsCompanion(
                id: id,
                productId: productId,
                userId: userId,
                quantity: quantity,
                type: type,
                note: note,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int productId,
                required int userId,
                required int quantity,
                required String type,
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => StockMovementsCompanion.insert(
                id: id,
                productId: productId,
                userId: userId,
                quantity: quantity,
                type: type,
                note: note,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$StockMovementsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productId = false, userId = false}) {
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
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable: $$StockMovementsTableReferences
                                    ._productIdTable(db),
                                referencedColumn:
                                    $$StockMovementsTableReferences
                                        ._productIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (userId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userId,
                                referencedTable: $$StockMovementsTableReferences
                                    ._userIdTable(db),
                                referencedColumn:
                                    $$StockMovementsTableReferences
                                        ._userIdTable(db)
                                        .id,
                              )
                              as T;
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

typedef $$StockMovementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StockMovementsTable,
      StockMovement,
      $$StockMovementsTableFilterComposer,
      $$StockMovementsTableOrderingComposer,
      $$StockMovementsTableAnnotationComposer,
      $$StockMovementsTableCreateCompanionBuilder,
      $$StockMovementsTableUpdateCompanionBuilder,
      (StockMovement, $$StockMovementsTableReferences),
      StockMovement,
      PrefetchHooks Function({bool productId, bool userId})
    >;
typedef $$SuppliersTableCreateCompanionBuilder =
    SuppliersCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> phone,
      Value<String?> address,
      Value<DateTime> createdAt,
    });
typedef $$SuppliersTableUpdateCompanionBuilder =
    SuppliersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> phone,
      Value<String?> address,
      Value<DateTime> createdAt,
    });

final class $$SuppliersTableReferences
    extends BaseReferences<_$AppDatabase, $SuppliersTable, Supplier> {
  $$SuppliersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PurchasesTable, List<Purchase>>
  _purchasesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.purchases,
    aliasName: $_aliasNameGenerator(db.suppliers.id, db.purchases.supplierId),
  );

  $$PurchasesTableProcessedTableManager get purchasesRefs {
    final manager = $$PurchasesTableTableManager(
      $_db,
      $_db.purchases,
    ).filter((f) => f.supplierId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_purchasesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SuppliersTableFilterComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> purchasesRefs(
    Expression<bool> Function($$PurchasesTableFilterComposer f) f,
  ) {
    final $$PurchasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchases,
      getReferencedColumn: (t) => t.supplierId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchasesTableFilterComposer(
            $db: $db,
            $table: $db.purchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SuppliersTableOrderingComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SuppliersTableAnnotationComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> purchasesRefs<T extends Object>(
    Expression<T> Function($$PurchasesTableAnnotationComposer a) f,
  ) {
    final $$PurchasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchases,
      getReferencedColumn: (t) => t.supplierId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchasesTableAnnotationComposer(
            $db: $db,
            $table: $db.purchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SuppliersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SuppliersTable,
          Supplier,
          $$SuppliersTableFilterComposer,
          $$SuppliersTableOrderingComposer,
          $$SuppliersTableAnnotationComposer,
          $$SuppliersTableCreateCompanionBuilder,
          $$SuppliersTableUpdateCompanionBuilder,
          (Supplier, $$SuppliersTableReferences),
          Supplier,
          PrefetchHooks Function({bool purchasesRefs})
        > {
  $$SuppliersTableTableManager(_$AppDatabase db, $SuppliersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SuppliersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SuppliersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SuppliersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SuppliersCompanion(
                id: id,
                name: name,
                phone: phone,
                address: address,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SuppliersCompanion.insert(
                id: id,
                name: name,
                phone: phone,
                address: address,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SuppliersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({purchasesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (purchasesRefs) db.purchases],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (purchasesRefs)
                    await $_getPrefetchedData<
                      Supplier,
                      $SuppliersTable,
                      Purchase
                    >(
                      currentTable: table,
                      referencedTable: $$SuppliersTableReferences
                          ._purchasesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SuppliersTableReferences(
                            db,
                            table,
                            p0,
                          ).purchasesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.supplierId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SuppliersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SuppliersTable,
      Supplier,
      $$SuppliersTableFilterComposer,
      $$SuppliersTableOrderingComposer,
      $$SuppliersTableAnnotationComposer,
      $$SuppliersTableCreateCompanionBuilder,
      $$SuppliersTableUpdateCompanionBuilder,
      (Supplier, $$SuppliersTableReferences),
      Supplier,
      PrefetchHooks Function({bool purchasesRefs})
    >;
typedef $$PurchasesTableCreateCompanionBuilder =
    PurchasesCompanion Function({
      Value<int> id,
      required int supplierId,
      required String invoiceNumber,
      required double total,
      Value<double> discount,
      Value<double> tax,
      required double netTotal,
      required String paymentMethod,
      Value<DateTime?> dueDate,
      Value<DateTime> createdAt,
    });
typedef $$PurchasesTableUpdateCompanionBuilder =
    PurchasesCompanion Function({
      Value<int> id,
      Value<int> supplierId,
      Value<String> invoiceNumber,
      Value<double> total,
      Value<double> discount,
      Value<double> tax,
      Value<double> netTotal,
      Value<String> paymentMethod,
      Value<DateTime?> dueDate,
      Value<DateTime> createdAt,
    });

final class $$PurchasesTableReferences
    extends BaseReferences<_$AppDatabase, $PurchasesTable, Purchase> {
  $$PurchasesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SuppliersTable _supplierIdTable(_$AppDatabase db) =>
      db.suppliers.createAlias(
        $_aliasNameGenerator(db.purchases.supplierId, db.suppliers.id),
      );

  $$SuppliersTableProcessedTableManager get supplierId {
    final $_column = $_itemColumn<int>('supplier_id')!;

    final manager = $$SuppliersTableTableManager(
      $_db,
      $_db.suppliers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_supplierIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PurchaseItemsTable, List<PurchaseItem>>
  _purchaseItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.purchaseItems,
    aliasName: $_aliasNameGenerator(
      db.purchases.id,
      db.purchaseItems.purchaseId,
    ),
  );

  $$PurchaseItemsTableProcessedTableManager get purchaseItemsRefs {
    final manager = $$PurchaseItemsTableTableManager(
      $_db,
      $_db.purchaseItems,
    ).filter((f) => f.purchaseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_purchaseItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PurchasePaymentsTable, List<PurchasePayment>>
  _purchasePaymentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.purchasePayments,
    aliasName: $_aliasNameGenerator(
      db.purchases.id,
      db.purchasePayments.purchaseId,
    ),
  );

  $$PurchasePaymentsTableProcessedTableManager get purchasePaymentsRefs {
    final manager = $$PurchasePaymentsTableTableManager(
      $_db,
      $_db.purchasePayments,
    ).filter((f) => f.purchaseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _purchasePaymentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PurchasesTableFilterComposer
    extends Composer<_$AppDatabase, $PurchasesTable> {
  $$PurchasesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tax => $composableBuilder(
    column: $table.tax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get netTotal => $composableBuilder(
    column: $table.netTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SuppliersTableFilterComposer get supplierId {
    final $$SuppliersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SuppliersTableFilterComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> purchaseItemsRefs(
    Expression<bool> Function($$PurchaseItemsTableFilterComposer f) f,
  ) {
    final $$PurchaseItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseItems,
      getReferencedColumn: (t) => t.purchaseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseItemsTableFilterComposer(
            $db: $db,
            $table: $db.purchaseItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> purchasePaymentsRefs(
    Expression<bool> Function($$PurchasePaymentsTableFilterComposer f) f,
  ) {
    final $$PurchasePaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchasePayments,
      getReferencedColumn: (t) => t.purchaseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchasePaymentsTableFilterComposer(
            $db: $db,
            $table: $db.purchasePayments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PurchasesTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchasesTable> {
  $$PurchasesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tax => $composableBuilder(
    column: $table.tax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get netTotal => $composableBuilder(
    column: $table.netTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SuppliersTableOrderingComposer get supplierId {
    final $$SuppliersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SuppliersTableOrderingComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchasesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchasesTable> {
  $$PurchasesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => column,
  );

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<double> get discount =>
      $composableBuilder(column: $table.discount, builder: (column) => column);

  GeneratedColumn<double> get tax =>
      $composableBuilder(column: $table.tax, builder: (column) => column);

  GeneratedColumn<double> get netTotal =>
      $composableBuilder(column: $table.netTotal, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$SuppliersTableAnnotationComposer get supplierId {
    final $$SuppliersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SuppliersTableAnnotationComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> purchaseItemsRefs<T extends Object>(
    Expression<T> Function($$PurchaseItemsTableAnnotationComposer a) f,
  ) {
    final $$PurchaseItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseItems,
      getReferencedColumn: (t) => t.purchaseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchaseItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.purchaseItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> purchasePaymentsRefs<T extends Object>(
    Expression<T> Function($$PurchasePaymentsTableAnnotationComposer a) f,
  ) {
    final $$PurchasePaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchasePayments,
      getReferencedColumn: (t) => t.purchaseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchasePaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.purchasePayments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PurchasesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchasesTable,
          Purchase,
          $$PurchasesTableFilterComposer,
          $$PurchasesTableOrderingComposer,
          $$PurchasesTableAnnotationComposer,
          $$PurchasesTableCreateCompanionBuilder,
          $$PurchasesTableUpdateCompanionBuilder,
          (Purchase, $$PurchasesTableReferences),
          Purchase,
          PrefetchHooks Function({
            bool supplierId,
            bool purchaseItemsRefs,
            bool purchasePaymentsRefs,
          })
        > {
  $$PurchasesTableTableManager(_$AppDatabase db, $PurchasesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchasesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchasesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchasesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> supplierId = const Value.absent(),
                Value<String> invoiceNumber = const Value.absent(),
                Value<double> total = const Value.absent(),
                Value<double> discount = const Value.absent(),
                Value<double> tax = const Value.absent(),
                Value<double> netTotal = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PurchasesCompanion(
                id: id,
                supplierId: supplierId,
                invoiceNumber: invoiceNumber,
                total: total,
                discount: discount,
                tax: tax,
                netTotal: netTotal,
                paymentMethod: paymentMethod,
                dueDate: dueDate,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int supplierId,
                required String invoiceNumber,
                required double total,
                Value<double> discount = const Value.absent(),
                Value<double> tax = const Value.absent(),
                required double netTotal,
                required String paymentMethod,
                Value<DateTime?> dueDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PurchasesCompanion.insert(
                id: id,
                supplierId: supplierId,
                invoiceNumber: invoiceNumber,
                total: total,
                discount: discount,
                tax: tax,
                netTotal: netTotal,
                paymentMethod: paymentMethod,
                dueDate: dueDate,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PurchasesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                supplierId = false,
                purchaseItemsRefs = false,
                purchasePaymentsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (purchaseItemsRefs) db.purchaseItems,
                    if (purchasePaymentsRefs) db.purchasePayments,
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
                        if (supplierId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.supplierId,
                                    referencedTable: $$PurchasesTableReferences
                                        ._supplierIdTable(db),
                                    referencedColumn: $$PurchasesTableReferences
                                        ._supplierIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (purchaseItemsRefs)
                        await $_getPrefetchedData<
                          Purchase,
                          $PurchasesTable,
                          PurchaseItem
                        >(
                          currentTable: table,
                          referencedTable: $$PurchasesTableReferences
                              ._purchaseItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PurchasesTableReferences(
                                db,
                                table,
                                p0,
                              ).purchaseItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.purchaseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (purchasePaymentsRefs)
                        await $_getPrefetchedData<
                          Purchase,
                          $PurchasesTable,
                          PurchasePayment
                        >(
                          currentTable: table,
                          referencedTable: $$PurchasesTableReferences
                              ._purchasePaymentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PurchasesTableReferences(
                                db,
                                table,
                                p0,
                              ).purchasePaymentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.purchaseId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PurchasesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchasesTable,
      Purchase,
      $$PurchasesTableFilterComposer,
      $$PurchasesTableOrderingComposer,
      $$PurchasesTableAnnotationComposer,
      $$PurchasesTableCreateCompanionBuilder,
      $$PurchasesTableUpdateCompanionBuilder,
      (Purchase, $$PurchasesTableReferences),
      Purchase,
      PrefetchHooks Function({
        bool supplierId,
        bool purchaseItemsRefs,
        bool purchasePaymentsRefs,
      })
    >;
typedef $$PurchaseItemsTableCreateCompanionBuilder =
    PurchaseItemsCompanion Function({
      Value<int> id,
      required int purchaseId,
      required int productId,
      required int quantity,
      Value<double> cartonQuantity,
      Value<int> unitsPerCarton,
      required double purchasePrice,
      Value<double> salePrice,
      required double total,
    });
typedef $$PurchaseItemsTableUpdateCompanionBuilder =
    PurchaseItemsCompanion Function({
      Value<int> id,
      Value<int> purchaseId,
      Value<int> productId,
      Value<int> quantity,
      Value<double> cartonQuantity,
      Value<int> unitsPerCarton,
      Value<double> purchasePrice,
      Value<double> salePrice,
      Value<double> total,
    });

final class $$PurchaseItemsTableReferences
    extends BaseReferences<_$AppDatabase, $PurchaseItemsTable, PurchaseItem> {
  $$PurchaseItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PurchasesTable _purchaseIdTable(_$AppDatabase db) =>
      db.purchases.createAlias(
        $_aliasNameGenerator(db.purchaseItems.purchaseId, db.purchases.id),
      );

  $$PurchasesTableProcessedTableManager get purchaseId {
    final $_column = $_itemColumn<int>('purchase_id')!;

    final manager = $$PurchasesTableTableManager(
      $_db,
      $_db.purchases,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_purchaseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias(
        $_aliasNameGenerator(db.purchaseItems.productId, db.products.id),
      );

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PurchaseItemsTableFilterComposer
    extends Composer<_$AppDatabase, $PurchaseItemsTable> {
  $$PurchaseItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cartonQuantity => $composableBuilder(
    column: $table.cartonQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unitsPerCarton => $composableBuilder(
    column: $table.unitsPerCarton,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get salePrice => $composableBuilder(
    column: $table.salePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  $$PurchasesTableFilterComposer get purchaseId {
    final $$PurchasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseId,
      referencedTable: $db.purchases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchasesTableFilterComposer(
            $db: $db,
            $table: $db.purchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchaseItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchaseItemsTable> {
  $$PurchaseItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cartonQuantity => $composableBuilder(
    column: $table.cartonQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unitsPerCarton => $composableBuilder(
    column: $table.unitsPerCarton,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get salePrice => $composableBuilder(
    column: $table.salePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  $$PurchasesTableOrderingComposer get purchaseId {
    final $$PurchasesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseId,
      referencedTable: $db.purchases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchasesTableOrderingComposer(
            $db: $db,
            $table: $db.purchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchaseItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchaseItemsTable> {
  $$PurchaseItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get cartonQuantity => $composableBuilder(
    column: $table.cartonQuantity,
    builder: (column) => column,
  );

  GeneratedColumn<int> get unitsPerCarton => $composableBuilder(
    column: $table.unitsPerCarton,
    builder: (column) => column,
  );

  GeneratedColumn<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get salePrice =>
      $composableBuilder(column: $table.salePrice, builder: (column) => column);

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  $$PurchasesTableAnnotationComposer get purchaseId {
    final $$PurchasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseId,
      referencedTable: $db.purchases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchasesTableAnnotationComposer(
            $db: $db,
            $table: $db.purchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchaseItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchaseItemsTable,
          PurchaseItem,
          $$PurchaseItemsTableFilterComposer,
          $$PurchaseItemsTableOrderingComposer,
          $$PurchaseItemsTableAnnotationComposer,
          $$PurchaseItemsTableCreateCompanionBuilder,
          $$PurchaseItemsTableUpdateCompanionBuilder,
          (PurchaseItem, $$PurchaseItemsTableReferences),
          PurchaseItem,
          PrefetchHooks Function({bool purchaseId, bool productId})
        > {
  $$PurchaseItemsTableTableManager(_$AppDatabase db, $PurchaseItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchaseItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchaseItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchaseItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> purchaseId = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<double> cartonQuantity = const Value.absent(),
                Value<int> unitsPerCarton = const Value.absent(),
                Value<double> purchasePrice = const Value.absent(),
                Value<double> salePrice = const Value.absent(),
                Value<double> total = const Value.absent(),
              }) => PurchaseItemsCompanion(
                id: id,
                purchaseId: purchaseId,
                productId: productId,
                quantity: quantity,
                cartonQuantity: cartonQuantity,
                unitsPerCarton: unitsPerCarton,
                purchasePrice: purchasePrice,
                salePrice: salePrice,
                total: total,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int purchaseId,
                required int productId,
                required int quantity,
                Value<double> cartonQuantity = const Value.absent(),
                Value<int> unitsPerCarton = const Value.absent(),
                required double purchasePrice,
                Value<double> salePrice = const Value.absent(),
                required double total,
              }) => PurchaseItemsCompanion.insert(
                id: id,
                purchaseId: purchaseId,
                productId: productId,
                quantity: quantity,
                cartonQuantity: cartonQuantity,
                unitsPerCarton: unitsPerCarton,
                purchasePrice: purchasePrice,
                salePrice: salePrice,
                total: total,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PurchaseItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({purchaseId = false, productId = false}) {
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
                    if (purchaseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.purchaseId,
                                referencedTable: $$PurchaseItemsTableReferences
                                    ._purchaseIdTable(db),
                                referencedColumn: $$PurchaseItemsTableReferences
                                    ._purchaseIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable: $$PurchaseItemsTableReferences
                                    ._productIdTable(db),
                                referencedColumn: $$PurchaseItemsTableReferences
                                    ._productIdTable(db)
                                    .id,
                              )
                              as T;
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

typedef $$PurchaseItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchaseItemsTable,
      PurchaseItem,
      $$PurchaseItemsTableFilterComposer,
      $$PurchaseItemsTableOrderingComposer,
      $$PurchaseItemsTableAnnotationComposer,
      $$PurchaseItemsTableCreateCompanionBuilder,
      $$PurchaseItemsTableUpdateCompanionBuilder,
      (PurchaseItem, $$PurchaseItemsTableReferences),
      PurchaseItem,
      PrefetchHooks Function({bool purchaseId, bool productId})
    >;
typedef $$PurchasePaymentsTableCreateCompanionBuilder =
    PurchasePaymentsCompanion Function({
      Value<int> id,
      required int purchaseId,
      required double amount,
      Value<String> paymentMethod,
      Value<DateTime> createdAt,
      Value<String?> note,
    });
typedef $$PurchasePaymentsTableUpdateCompanionBuilder =
    PurchasePaymentsCompanion Function({
      Value<int> id,
      Value<int> purchaseId,
      Value<double> amount,
      Value<String> paymentMethod,
      Value<DateTime> createdAt,
      Value<String?> note,
    });

final class $$PurchasePaymentsTableReferences
    extends
        BaseReferences<_$AppDatabase, $PurchasePaymentsTable, PurchasePayment> {
  $$PurchasePaymentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PurchasesTable _purchaseIdTable(_$AppDatabase db) =>
      db.purchases.createAlias(
        $_aliasNameGenerator(db.purchasePayments.purchaseId, db.purchases.id),
      );

  $$PurchasesTableProcessedTableManager get purchaseId {
    final $_column = $_itemColumn<int>('purchase_id')!;

    final manager = $$PurchasesTableTableManager(
      $_db,
      $_db.purchases,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_purchaseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PurchasePaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $PurchasePaymentsTable> {
  $$PurchasePaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  $$PurchasesTableFilterComposer get purchaseId {
    final $$PurchasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseId,
      referencedTable: $db.purchases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchasesTableFilterComposer(
            $db: $db,
            $table: $db.purchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchasePaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchasePaymentsTable> {
  $$PurchasePaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  $$PurchasesTableOrderingComposer get purchaseId {
    final $$PurchasesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseId,
      referencedTable: $db.purchases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchasesTableOrderingComposer(
            $db: $db,
            $table: $db.purchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchasePaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchasePaymentsTable> {
  $$PurchasePaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$PurchasesTableAnnotationComposer get purchaseId {
    final $$PurchasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseId,
      referencedTable: $db.purchases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PurchasesTableAnnotationComposer(
            $db: $db,
            $table: $db.purchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchasePaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchasePaymentsTable,
          PurchasePayment,
          $$PurchasePaymentsTableFilterComposer,
          $$PurchasePaymentsTableOrderingComposer,
          $$PurchasePaymentsTableAnnotationComposer,
          $$PurchasePaymentsTableCreateCompanionBuilder,
          $$PurchasePaymentsTableUpdateCompanionBuilder,
          (PurchasePayment, $$PurchasePaymentsTableReferences),
          PurchasePayment,
          PrefetchHooks Function({bool purchaseId})
        > {
  $$PurchasePaymentsTableTableManager(
    _$AppDatabase db,
    $PurchasePaymentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchasePaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchasePaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchasePaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> purchaseId = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => PurchasePaymentsCompanion(
                id: id,
                purchaseId: purchaseId,
                amount: amount,
                paymentMethod: paymentMethod,
                createdAt: createdAt,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int purchaseId,
                required double amount,
                Value<String> paymentMethod = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => PurchasePaymentsCompanion.insert(
                id: id,
                purchaseId: purchaseId,
                amount: amount,
                paymentMethod: paymentMethod,
                createdAt: createdAt,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PurchasePaymentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({purchaseId = false}) {
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
                    if (purchaseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.purchaseId,
                                referencedTable:
                                    $$PurchasePaymentsTableReferences
                                        ._purchaseIdTable(db),
                                referencedColumn:
                                    $$PurchasePaymentsTableReferences
                                        ._purchaseIdTable(db)
                                        .id,
                              )
                              as T;
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

typedef $$PurchasePaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchasePaymentsTable,
      PurchasePayment,
      $$PurchasePaymentsTableFilterComposer,
      $$PurchasePaymentsTableOrderingComposer,
      $$PurchasePaymentsTableAnnotationComposer,
      $$PurchasePaymentsTableCreateCompanionBuilder,
      $$PurchasePaymentsTableUpdateCompanionBuilder,
      (PurchasePayment, $$PurchasePaymentsTableReferences),
      PurchasePayment,
      PrefetchHooks Function({bool purchaseId})
    >;
typedef $$PaymentAccountsTableCreateCompanionBuilder =
    PaymentAccountsCompanion Function({
      Value<int> id,
      required String type,
      required String name,
      Value<String?> provider,
      Value<String?> reference,
      Value<bool> isActive,
      Value<DateTime> createdAt,
    });
typedef $$PaymentAccountsTableUpdateCompanionBuilder =
    PaymentAccountsCompanion Function({
      Value<int> id,
      Value<String> type,
      Value<String> name,
      Value<String?> provider,
      Value<String?> reference,
      Value<bool> isActive,
      Value<DateTime> createdAt,
    });

final class $$PaymentAccountsTableReferences
    extends
        BaseReferences<_$AppDatabase, $PaymentAccountsTable, PaymentAccount> {
  $$PaymentAccountsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$ExpensesTable, List<Expense>> _expensesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.expenses,
    aliasName: $_aliasNameGenerator(
      db.paymentAccounts.id,
      db.expenses.paymentAccountId,
    ),
  );

  $$ExpensesTableProcessedTableManager get expensesRefs {
    final manager = $$ExpensesTableTableManager(
      $_db,
      $_db.expenses,
    ).filter((f) => f.paymentAccountId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_expensesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DebtPaymentsTable, List<DebtPayment>>
  _debtPaymentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.debtPayments,
    aliasName: $_aliasNameGenerator(
      db.paymentAccounts.id,
      db.debtPayments.paymentAccountId,
    ),
  );

  $$DebtPaymentsTableProcessedTableManager get debtPaymentsRefs {
    final manager = $$DebtPaymentsTableTableManager(
      $_db,
      $_db.debtPayments,
    ).filter((f) => f.paymentAccountId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_debtPaymentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $PaymentAccountTransactionsTable,
    List<PaymentAccountTransaction>
  >
  _paymentAccountTransactionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.paymentAccountTransactions,
        aliasName: $_aliasNameGenerator(
          db.paymentAccounts.id,
          db.paymentAccountTransactions.accountId,
        ),
      );

  $$PaymentAccountTransactionsTableProcessedTableManager
  get paymentAccountTransactionsRefs {
    final manager = $$PaymentAccountTransactionsTableTableManager(
      $_db,
      $_db.paymentAccountTransactions,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _paymentAccountTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PaymentAccountsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentAccountsTable> {
  $$PaymentAccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> expensesRefs(
    Expression<bool> Function($$ExpensesTableFilterComposer f) f,
  ) {
    final $$ExpensesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expenses,
      getReferencedColumn: (t) => t.paymentAccountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableFilterComposer(
            $db: $db,
            $table: $db.expenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> debtPaymentsRefs(
    Expression<bool> Function($$DebtPaymentsTableFilterComposer f) f,
  ) {
    final $$DebtPaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.debtPayments,
      getReferencedColumn: (t) => t.paymentAccountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DebtPaymentsTableFilterComposer(
            $db: $db,
            $table: $db.debtPayments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> paymentAccountTransactionsRefs(
    Expression<bool> Function($$PaymentAccountTransactionsTableFilterComposer f)
    f,
  ) {
    final $$PaymentAccountTransactionsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.paymentAccountTransactions,
          getReferencedColumn: (t) => t.accountId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PaymentAccountTransactionsTableFilterComposer(
                $db: $db,
                $table: $db.paymentAccountTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PaymentAccountsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentAccountsTable> {
  $$PaymentAccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PaymentAccountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentAccountsTable> {
  $$PaymentAccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get provider =>
      $composableBuilder(column: $table.provider, builder: (column) => column);

  GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> expensesRefs<T extends Object>(
    Expression<T> Function($$ExpensesTableAnnotationComposer a) f,
  ) {
    final $$ExpensesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expenses,
      getReferencedColumn: (t) => t.paymentAccountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableAnnotationComposer(
            $db: $db,
            $table: $db.expenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> debtPaymentsRefs<T extends Object>(
    Expression<T> Function($$DebtPaymentsTableAnnotationComposer a) f,
  ) {
    final $$DebtPaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.debtPayments,
      getReferencedColumn: (t) => t.paymentAccountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DebtPaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.debtPayments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> paymentAccountTransactionsRefs<T extends Object>(
    Expression<T> Function(
      $$PaymentAccountTransactionsTableAnnotationComposer a,
    )
    f,
  ) {
    final $$PaymentAccountTransactionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.paymentAccountTransactions,
          getReferencedColumn: (t) => t.accountId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PaymentAccountTransactionsTableAnnotationComposer(
                $db: $db,
                $table: $db.paymentAccountTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PaymentAccountsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentAccountsTable,
          PaymentAccount,
          $$PaymentAccountsTableFilterComposer,
          $$PaymentAccountsTableOrderingComposer,
          $$PaymentAccountsTableAnnotationComposer,
          $$PaymentAccountsTableCreateCompanionBuilder,
          $$PaymentAccountsTableUpdateCompanionBuilder,
          (PaymentAccount, $$PaymentAccountsTableReferences),
          PaymentAccount,
          PrefetchHooks Function({
            bool expensesRefs,
            bool debtPaymentsRefs,
            bool paymentAccountTransactionsRefs,
          })
        > {
  $$PaymentAccountsTableTableManager(
    _$AppDatabase db,
    $PaymentAccountsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentAccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentAccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentAccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> provider = const Value.absent(),
                Value<String?> reference = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PaymentAccountsCompanion(
                id: id,
                type: type,
                name: name,
                provider: provider,
                reference: reference,
                isActive: isActive,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String type,
                required String name,
                Value<String?> provider = const Value.absent(),
                Value<String?> reference = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PaymentAccountsCompanion.insert(
                id: id,
                type: type,
                name: name,
                provider: provider,
                reference: reference,
                isActive: isActive,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PaymentAccountsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                expensesRefs = false,
                debtPaymentsRefs = false,
                paymentAccountTransactionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (expensesRefs) db.expenses,
                    if (debtPaymentsRefs) db.debtPayments,
                    if (paymentAccountTransactionsRefs)
                      db.paymentAccountTransactions,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (expensesRefs)
                        await $_getPrefetchedData<
                          PaymentAccount,
                          $PaymentAccountsTable,
                          Expense
                        >(
                          currentTable: table,
                          referencedTable: $$PaymentAccountsTableReferences
                              ._expensesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PaymentAccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).expensesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.paymentAccountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (debtPaymentsRefs)
                        await $_getPrefetchedData<
                          PaymentAccount,
                          $PaymentAccountsTable,
                          DebtPayment
                        >(
                          currentTable: table,
                          referencedTable: $$PaymentAccountsTableReferences
                              ._debtPaymentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PaymentAccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).debtPaymentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.paymentAccountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (paymentAccountTransactionsRefs)
                        await $_getPrefetchedData<
                          PaymentAccount,
                          $PaymentAccountsTable,
                          PaymentAccountTransaction
                        >(
                          currentTable: table,
                          referencedTable: $$PaymentAccountsTableReferences
                              ._paymentAccountTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PaymentAccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentAccountTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PaymentAccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentAccountsTable,
      PaymentAccount,
      $$PaymentAccountsTableFilterComposer,
      $$PaymentAccountsTableOrderingComposer,
      $$PaymentAccountsTableAnnotationComposer,
      $$PaymentAccountsTableCreateCompanionBuilder,
      $$PaymentAccountsTableUpdateCompanionBuilder,
      (PaymentAccount, $$PaymentAccountsTableReferences),
      PaymentAccount,
      PrefetchHooks Function({
        bool expensesRefs,
        bool debtPaymentsRefs,
        bool paymentAccountTransactionsRefs,
      })
    >;
typedef $$ExpensesTableCreateCompanionBuilder =
    ExpensesCompanion Function({
      Value<int> id,
      required String title,
      required String category,
      required double amount,
      Value<String?> notes,
      Value<String> status,
      Value<String> paymentMethod,
      Value<int?> paymentAccountId,
      required DateTime expenseDate,
      Value<DateTime> createdAt,
    });
typedef $$ExpensesTableUpdateCompanionBuilder =
    ExpensesCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> category,
      Value<double> amount,
      Value<String?> notes,
      Value<String> status,
      Value<String> paymentMethod,
      Value<int?> paymentAccountId,
      Value<DateTime> expenseDate,
      Value<DateTime> createdAt,
    });

final class $$ExpensesTableReferences
    extends BaseReferences<_$AppDatabase, $ExpensesTable, Expense> {
  $$ExpensesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PaymentAccountsTable _paymentAccountIdTable(_$AppDatabase db) =>
      db.paymentAccounts.createAlias(
        $_aliasNameGenerator(
          db.expenses.paymentAccountId,
          db.paymentAccounts.id,
        ),
      );

  $$PaymentAccountsTableProcessedTableManager? get paymentAccountId {
    final $_column = $_itemColumn<int>('payment_account_id');
    if ($_column == null) return null;
    final manager = $$PaymentAccountsTableTableManager(
      $_db,
      $_db.paymentAccounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_paymentAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expenseDate => $composableBuilder(
    column: $table.expenseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PaymentAccountsTableFilterComposer get paymentAccountId {
    final $$PaymentAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paymentAccountId,
      referencedTable: $db.paymentAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentAccountsTableFilterComposer(
            $db: $db,
            $table: $db.paymentAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expenseDate => $composableBuilder(
    column: $table.expenseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PaymentAccountsTableOrderingComposer get paymentAccountId {
    final $$PaymentAccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paymentAccountId,
      referencedTable: $db.paymentAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentAccountsTableOrderingComposer(
            $db: $db,
            $table: $db.paymentAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get expenseDate => $composableBuilder(
    column: $table.expenseDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PaymentAccountsTableAnnotationComposer get paymentAccountId {
    final $$PaymentAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paymentAccountId,
      referencedTable: $db.paymentAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.paymentAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpensesTable,
          Expense,
          $$ExpensesTableFilterComposer,
          $$ExpensesTableOrderingComposer,
          $$ExpensesTableAnnotationComposer,
          $$ExpensesTableCreateCompanionBuilder,
          $$ExpensesTableUpdateCompanionBuilder,
          (Expense, $$ExpensesTableReferences),
          Expense,
          PrefetchHooks Function({bool paymentAccountId})
        > {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<int?> paymentAccountId = const Value.absent(),
                Value<DateTime> expenseDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ExpensesCompanion(
                id: id,
                title: title,
                category: category,
                amount: amount,
                notes: notes,
                status: status,
                paymentMethod: paymentMethod,
                paymentAccountId: paymentAccountId,
                expenseDate: expenseDate,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String category,
                required double amount,
                Value<String?> notes = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<int?> paymentAccountId = const Value.absent(),
                required DateTime expenseDate,
                Value<DateTime> createdAt = const Value.absent(),
              }) => ExpensesCompanion.insert(
                id: id,
                title: title,
                category: category,
                amount: amount,
                notes: notes,
                status: status,
                paymentMethod: paymentMethod,
                paymentAccountId: paymentAccountId,
                expenseDate: expenseDate,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExpensesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({paymentAccountId = false}) {
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
                    if (paymentAccountId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.paymentAccountId,
                                referencedTable: $$ExpensesTableReferences
                                    ._paymentAccountIdTable(db),
                                referencedColumn: $$ExpensesTableReferences
                                    ._paymentAccountIdTable(db)
                                    .id,
                              )
                              as T;
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

typedef $$ExpensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpensesTable,
      Expense,
      $$ExpensesTableFilterComposer,
      $$ExpensesTableOrderingComposer,
      $$ExpensesTableAnnotationComposer,
      $$ExpensesTableCreateCompanionBuilder,
      $$ExpensesTableUpdateCompanionBuilder,
      (Expense, $$ExpensesTableReferences),
      Expense,
      PrefetchHooks Function({bool paymentAccountId})
    >;
typedef $$DailyClosingsTableCreateCompanionBuilder =
    DailyClosingsCompanion Function({
      Value<int> id,
      required DateTime date,
      Value<double> totalSales,
      Value<double> totalPurchases,
      Value<double> totalExpenses,
      Value<double> cashBalance,
      Value<double> posBalance,
      Value<double> walletBalance,
      Value<double> expectedBalance,
      Value<double> difference,
      Value<String?> note,
      Value<String?> userName,
      Value<bool> isClosed,
    });
typedef $$DailyClosingsTableUpdateCompanionBuilder =
    DailyClosingsCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<double> totalSales,
      Value<double> totalPurchases,
      Value<double> totalExpenses,
      Value<double> cashBalance,
      Value<double> posBalance,
      Value<double> walletBalance,
      Value<double> expectedBalance,
      Value<double> difference,
      Value<String?> note,
      Value<String?> userName,
      Value<bool> isClosed,
    });

class $$DailyClosingsTableFilterComposer
    extends Composer<_$AppDatabase, $DailyClosingsTable> {
  $$DailyClosingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalSales => $composableBuilder(
    column: $table.totalSales,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalPurchases => $composableBuilder(
    column: $table.totalPurchases,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalExpenses => $composableBuilder(
    column: $table.totalExpenses,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cashBalance => $composableBuilder(
    column: $table.cashBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get posBalance => $composableBuilder(
    column: $table.posBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get walletBalance => $composableBuilder(
    column: $table.walletBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get expectedBalance => $composableBuilder(
    column: $table.expectedBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get difference => $composableBuilder(
    column: $table.difference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userName => $composableBuilder(
    column: $table.userName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isClosed => $composableBuilder(
    column: $table.isClosed,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyClosingsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyClosingsTable> {
  $$DailyClosingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalSales => $composableBuilder(
    column: $table.totalSales,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalPurchases => $composableBuilder(
    column: $table.totalPurchases,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalExpenses => $composableBuilder(
    column: $table.totalExpenses,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cashBalance => $composableBuilder(
    column: $table.cashBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get posBalance => $composableBuilder(
    column: $table.posBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get walletBalance => $composableBuilder(
    column: $table.walletBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get expectedBalance => $composableBuilder(
    column: $table.expectedBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get difference => $composableBuilder(
    column: $table.difference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userName => $composableBuilder(
    column: $table.userName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isClosed => $composableBuilder(
    column: $table.isClosed,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyClosingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyClosingsTable> {
  $$DailyClosingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get totalSales => $composableBuilder(
    column: $table.totalSales,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalPurchases => $composableBuilder(
    column: $table.totalPurchases,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalExpenses => $composableBuilder(
    column: $table.totalExpenses,
    builder: (column) => column,
  );

  GeneratedColumn<double> get cashBalance => $composableBuilder(
    column: $table.cashBalance,
    builder: (column) => column,
  );

  GeneratedColumn<double> get posBalance => $composableBuilder(
    column: $table.posBalance,
    builder: (column) => column,
  );

  GeneratedColumn<double> get walletBalance => $composableBuilder(
    column: $table.walletBalance,
    builder: (column) => column,
  );

  GeneratedColumn<double> get expectedBalance => $composableBuilder(
    column: $table.expectedBalance,
    builder: (column) => column,
  );

  GeneratedColumn<double> get difference => $composableBuilder(
    column: $table.difference,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get userName =>
      $composableBuilder(column: $table.userName, builder: (column) => column);

  GeneratedColumn<bool> get isClosed =>
      $composableBuilder(column: $table.isClosed, builder: (column) => column);
}

class $$DailyClosingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyClosingsTable,
          DailyClosing,
          $$DailyClosingsTableFilterComposer,
          $$DailyClosingsTableOrderingComposer,
          $$DailyClosingsTableAnnotationComposer,
          $$DailyClosingsTableCreateCompanionBuilder,
          $$DailyClosingsTableUpdateCompanionBuilder,
          (
            DailyClosing,
            BaseReferences<_$AppDatabase, $DailyClosingsTable, DailyClosing>,
          ),
          DailyClosing,
          PrefetchHooks Function()
        > {
  $$DailyClosingsTableTableManager(_$AppDatabase db, $DailyClosingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyClosingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyClosingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyClosingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<double> totalSales = const Value.absent(),
                Value<double> totalPurchases = const Value.absent(),
                Value<double> totalExpenses = const Value.absent(),
                Value<double> cashBalance = const Value.absent(),
                Value<double> posBalance = const Value.absent(),
                Value<double> walletBalance = const Value.absent(),
                Value<double> expectedBalance = const Value.absent(),
                Value<double> difference = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> userName = const Value.absent(),
                Value<bool> isClosed = const Value.absent(),
              }) => DailyClosingsCompanion(
                id: id,
                date: date,
                totalSales: totalSales,
                totalPurchases: totalPurchases,
                totalExpenses: totalExpenses,
                cashBalance: cashBalance,
                posBalance: posBalance,
                walletBalance: walletBalance,
                expectedBalance: expectedBalance,
                difference: difference,
                note: note,
                userName: userName,
                isClosed: isClosed,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                Value<double> totalSales = const Value.absent(),
                Value<double> totalPurchases = const Value.absent(),
                Value<double> totalExpenses = const Value.absent(),
                Value<double> cashBalance = const Value.absent(),
                Value<double> posBalance = const Value.absent(),
                Value<double> walletBalance = const Value.absent(),
                Value<double> expectedBalance = const Value.absent(),
                Value<double> difference = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> userName = const Value.absent(),
                Value<bool> isClosed = const Value.absent(),
              }) => DailyClosingsCompanion.insert(
                id: id,
                date: date,
                totalSales: totalSales,
                totalPurchases: totalPurchases,
                totalExpenses: totalExpenses,
                cashBalance: cashBalance,
                posBalance: posBalance,
                walletBalance: walletBalance,
                expectedBalance: expectedBalance,
                difference: difference,
                note: note,
                userName: userName,
                isClosed: isClosed,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyClosingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyClosingsTable,
      DailyClosing,
      $$DailyClosingsTableFilterComposer,
      $$DailyClosingsTableOrderingComposer,
      $$DailyClosingsTableAnnotationComposer,
      $$DailyClosingsTableCreateCompanionBuilder,
      $$DailyClosingsTableUpdateCompanionBuilder,
      (
        DailyClosing,
        BaseReferences<_$AppDatabase, $DailyClosingsTable, DailyClosing>,
      ),
      DailyClosing,
      PrefetchHooks Function()
    >;
typedef $$DebtPaymentsTableCreateCompanionBuilder =
    DebtPaymentsCompanion Function({
      Value<int> id,
      required int invoiceId,
      required double amount,
      required String paymentMethod,
      Value<int?> paymentAccountId,
      required int userId,
      Value<DateTime> createdAt,
    });
typedef $$DebtPaymentsTableUpdateCompanionBuilder =
    DebtPaymentsCompanion Function({
      Value<int> id,
      Value<int> invoiceId,
      Value<double> amount,
      Value<String> paymentMethod,
      Value<int?> paymentAccountId,
      Value<int> userId,
      Value<DateTime> createdAt,
    });

final class $$DebtPaymentsTableReferences
    extends BaseReferences<_$AppDatabase, $DebtPaymentsTable, DebtPayment> {
  $$DebtPaymentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $InvoicesTable _invoiceIdTable(_$AppDatabase db) =>
      db.invoices.createAlias(
        $_aliasNameGenerator(db.debtPayments.invoiceId, db.invoices.id),
      );

  $$InvoicesTableProcessedTableManager get invoiceId {
    final $_column = $_itemColumn<int>('invoice_id')!;

    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PaymentAccountsTable _paymentAccountIdTable(_$AppDatabase db) =>
      db.paymentAccounts.createAlias(
        $_aliasNameGenerator(
          db.debtPayments.paymentAccountId,
          db.paymentAccounts.id,
        ),
      );

  $$PaymentAccountsTableProcessedTableManager? get paymentAccountId {
    final $_column = $_itemColumn<int>('payment_account_id');
    if ($_column == null) return null;
    final manager = $$PaymentAccountsTableTableManager(
      $_db,
      $_db.paymentAccounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_paymentAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.debtPayments.userId, db.users.id),
  );

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DebtPaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $DebtPaymentsTable> {
  $$DebtPaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$InvoicesTableFilterComposer get invoiceId {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PaymentAccountsTableFilterComposer get paymentAccountId {
    final $$PaymentAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paymentAccountId,
      referencedTable: $db.paymentAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentAccountsTableFilterComposer(
            $db: $db,
            $table: $db.paymentAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DebtPaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $DebtPaymentsTable> {
  $$DebtPaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$InvoicesTableOrderingComposer get invoiceId {
    final $$InvoicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableOrderingComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PaymentAccountsTableOrderingComposer get paymentAccountId {
    final $$PaymentAccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paymentAccountId,
      referencedTable: $db.paymentAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentAccountsTableOrderingComposer(
            $db: $db,
            $table: $db.paymentAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DebtPaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DebtPaymentsTable> {
  $$DebtPaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$InvoicesTableAnnotationComposer get invoiceId {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PaymentAccountsTableAnnotationComposer get paymentAccountId {
    final $$PaymentAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paymentAccountId,
      referencedTable: $db.paymentAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.paymentAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DebtPaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DebtPaymentsTable,
          DebtPayment,
          $$DebtPaymentsTableFilterComposer,
          $$DebtPaymentsTableOrderingComposer,
          $$DebtPaymentsTableAnnotationComposer,
          $$DebtPaymentsTableCreateCompanionBuilder,
          $$DebtPaymentsTableUpdateCompanionBuilder,
          (DebtPayment, $$DebtPaymentsTableReferences),
          DebtPayment,
          PrefetchHooks Function({
            bool invoiceId,
            bool paymentAccountId,
            bool userId,
          })
        > {
  $$DebtPaymentsTableTableManager(_$AppDatabase db, $DebtPaymentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DebtPaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DebtPaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DebtPaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> invoiceId = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<int?> paymentAccountId = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => DebtPaymentsCompanion(
                id: id,
                invoiceId: invoiceId,
                amount: amount,
                paymentMethod: paymentMethod,
                paymentAccountId: paymentAccountId,
                userId: userId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int invoiceId,
                required double amount,
                required String paymentMethod,
                Value<int?> paymentAccountId = const Value.absent(),
                required int userId,
                Value<DateTime> createdAt = const Value.absent(),
              }) => DebtPaymentsCompanion.insert(
                id: id,
                invoiceId: invoiceId,
                amount: amount,
                paymentMethod: paymentMethod,
                paymentAccountId: paymentAccountId,
                userId: userId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DebtPaymentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({invoiceId = false, paymentAccountId = false, userId = false}) {
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
                        if (invoiceId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.invoiceId,
                                    referencedTable:
                                        $$DebtPaymentsTableReferences
                                            ._invoiceIdTable(db),
                                    referencedColumn:
                                        $$DebtPaymentsTableReferences
                                            ._invoiceIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (paymentAccountId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.paymentAccountId,
                                    referencedTable:
                                        $$DebtPaymentsTableReferences
                                            ._paymentAccountIdTable(db),
                                    referencedColumn:
                                        $$DebtPaymentsTableReferences
                                            ._paymentAccountIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (userId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.userId,
                                    referencedTable:
                                        $$DebtPaymentsTableReferences
                                            ._userIdTable(db),
                                    referencedColumn:
                                        $$DebtPaymentsTableReferences
                                            ._userIdTable(db)
                                            .id,
                                  )
                                  as T;
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

typedef $$DebtPaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DebtPaymentsTable,
      DebtPayment,
      $$DebtPaymentsTableFilterComposer,
      $$DebtPaymentsTableOrderingComposer,
      $$DebtPaymentsTableAnnotationComposer,
      $$DebtPaymentsTableCreateCompanionBuilder,
      $$DebtPaymentsTableUpdateCompanionBuilder,
      (DebtPayment, $$DebtPaymentsTableReferences),
      DebtPayment,
      PrefetchHooks Function({
        bool invoiceId,
        bool paymentAccountId,
        bool userId,
      })
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<double> initialCashBalance,
      Value<DateTime> createdAt,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<int> id,
      Value<double> initialCashBalance,
      Value<DateTime> createdAt,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get initialCashBalance => $composableBuilder(
    column: $table.initialCashBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get initialCashBalance => $composableBuilder(
    column: $table.initialCashBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get initialCashBalance => $composableBuilder(
    column: $table.initialCashBalance,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> initialCashBalance = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AppSettingsCompanion(
                id: id,
                initialCashBalance: initialCashBalance,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> initialCashBalance = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                id: id,
                initialCashBalance: initialCashBalance,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;
typedef $$WorkerAdvancesTableCreateCompanionBuilder =
    WorkerAdvancesCompanion Function({
      Value<int> id,
      required int workerId,
      required double amount,
      Value<String?> reason,
      Value<DateTime> createdAt,
    });
typedef $$WorkerAdvancesTableUpdateCompanionBuilder =
    WorkerAdvancesCompanion Function({
      Value<int> id,
      Value<int> workerId,
      Value<double> amount,
      Value<String?> reason,
      Value<DateTime> createdAt,
    });

final class $$WorkerAdvancesTableReferences
    extends BaseReferences<_$AppDatabase, $WorkerAdvancesTable, WorkerAdvance> {
  $$WorkerAdvancesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UsersTable _workerIdTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.workerAdvances.workerId, db.users.id),
  );

  $$UsersTableProcessedTableManager get workerId {
    final $_column = $_itemColumn<int>('worker_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WorkerAdvancesTableFilterComposer
    extends Composer<_$AppDatabase, $WorkerAdvancesTable> {
  $$WorkerAdvancesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get workerId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workerId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkerAdvancesTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkerAdvancesTable> {
  $$WorkerAdvancesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get workerId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workerId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkerAdvancesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkerAdvancesTable> {
  $$WorkerAdvancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get workerId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workerId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkerAdvancesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkerAdvancesTable,
          WorkerAdvance,
          $$WorkerAdvancesTableFilterComposer,
          $$WorkerAdvancesTableOrderingComposer,
          $$WorkerAdvancesTableAnnotationComposer,
          $$WorkerAdvancesTableCreateCompanionBuilder,
          $$WorkerAdvancesTableUpdateCompanionBuilder,
          (WorkerAdvance, $$WorkerAdvancesTableReferences),
          WorkerAdvance,
          PrefetchHooks Function({bool workerId})
        > {
  $$WorkerAdvancesTableTableManager(
    _$AppDatabase db,
    $WorkerAdvancesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkerAdvancesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkerAdvancesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkerAdvancesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> workerId = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => WorkerAdvancesCompanion(
                id: id,
                workerId: workerId,
                amount: amount,
                reason: reason,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int workerId,
                required double amount,
                Value<String?> reason = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => WorkerAdvancesCompanion.insert(
                id: id,
                workerId: workerId,
                amount: amount,
                reason: reason,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WorkerAdvancesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({workerId = false}) {
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
                    if (workerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.workerId,
                                referencedTable: $$WorkerAdvancesTableReferences
                                    ._workerIdTable(db),
                                referencedColumn:
                                    $$WorkerAdvancesTableReferences
                                        ._workerIdTable(db)
                                        .id,
                              )
                              as T;
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

typedef $$WorkerAdvancesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkerAdvancesTable,
      WorkerAdvance,
      $$WorkerAdvancesTableFilterComposer,
      $$WorkerAdvancesTableOrderingComposer,
      $$WorkerAdvancesTableAnnotationComposer,
      $$WorkerAdvancesTableCreateCompanionBuilder,
      $$WorkerAdvancesTableUpdateCompanionBuilder,
      (WorkerAdvance, $$WorkerAdvancesTableReferences),
      WorkerAdvance,
      PrefetchHooks Function({bool workerId})
    >;
typedef $$WorkerProductIssuesTableCreateCompanionBuilder =
    WorkerProductIssuesCompanion Function({
      Value<int> id,
      required int workerId,
      required int productId,
      required String productName,
      required String barcode,
      Value<int> quantity,
      required double unitPrice,
      Value<DateTime> createdAt,
    });
typedef $$WorkerProductIssuesTableUpdateCompanionBuilder =
    WorkerProductIssuesCompanion Function({
      Value<int> id,
      Value<int> workerId,
      Value<int> productId,
      Value<String> productName,
      Value<String> barcode,
      Value<int> quantity,
      Value<double> unitPrice,
      Value<DateTime> createdAt,
    });

final class $$WorkerProductIssuesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $WorkerProductIssuesTable,
          WorkerProductIssue
        > {
  $$WorkerProductIssuesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UsersTable _workerIdTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.workerProductIssues.workerId, db.users.id),
  );

  $$UsersTableProcessedTableManager get workerId {
    final $_column = $_itemColumn<int>('worker_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WorkerProductIssuesTableFilterComposer
    extends Composer<_$AppDatabase, $WorkerProductIssuesTable> {
  $$WorkerProductIssuesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get workerId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workerId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkerProductIssuesTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkerProductIssuesTable> {
  $$WorkerProductIssuesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get workerId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workerId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkerProductIssuesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkerProductIssuesTable> {
  $$WorkerProductIssuesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get workerId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.workerId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkerProductIssuesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkerProductIssuesTable,
          WorkerProductIssue,
          $$WorkerProductIssuesTableFilterComposer,
          $$WorkerProductIssuesTableOrderingComposer,
          $$WorkerProductIssuesTableAnnotationComposer,
          $$WorkerProductIssuesTableCreateCompanionBuilder,
          $$WorkerProductIssuesTableUpdateCompanionBuilder,
          (WorkerProductIssue, $$WorkerProductIssuesTableReferences),
          WorkerProductIssue,
          PrefetchHooks Function({bool workerId})
        > {
  $$WorkerProductIssuesTableTableManager(
    _$AppDatabase db,
    $WorkerProductIssuesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkerProductIssuesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkerProductIssuesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$WorkerProductIssuesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> workerId = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<String> productName = const Value.absent(),
                Value<String> barcode = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => WorkerProductIssuesCompanion(
                id: id,
                workerId: workerId,
                productId: productId,
                productName: productName,
                barcode: barcode,
                quantity: quantity,
                unitPrice: unitPrice,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int workerId,
                required int productId,
                required String productName,
                required String barcode,
                Value<int> quantity = const Value.absent(),
                required double unitPrice,
                Value<DateTime> createdAt = const Value.absent(),
              }) => WorkerProductIssuesCompanion.insert(
                id: id,
                workerId: workerId,
                productId: productId,
                productName: productName,
                barcode: barcode,
                quantity: quantity,
                unitPrice: unitPrice,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WorkerProductIssuesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({workerId = false}) {
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
                    if (workerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.workerId,
                                referencedTable:
                                    $$WorkerProductIssuesTableReferences
                                        ._workerIdTable(db),
                                referencedColumn:
                                    $$WorkerProductIssuesTableReferences
                                        ._workerIdTable(db)
                                        .id,
                              )
                              as T;
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

typedef $$WorkerProductIssuesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkerProductIssuesTable,
      WorkerProductIssue,
      $$WorkerProductIssuesTableFilterComposer,
      $$WorkerProductIssuesTableOrderingComposer,
      $$WorkerProductIssuesTableAnnotationComposer,
      $$WorkerProductIssuesTableCreateCompanionBuilder,
      $$WorkerProductIssuesTableUpdateCompanionBuilder,
      (WorkerProductIssue, $$WorkerProductIssuesTableReferences),
      WorkerProductIssue,
      PrefetchHooks Function({bool workerId})
    >;
typedef $$PaymentAccountTransactionsTableCreateCompanionBuilder =
    PaymentAccountTransactionsCompanion Function({
      Value<int> id,
      required int accountId,
      Value<int?> invoiceId,
      Value<String?> invoiceNumber,
      required int userId,
      required String kind,
      required double amount,
      Value<String?> note,
      Value<DateTime> createdAt,
    });
typedef $$PaymentAccountTransactionsTableUpdateCompanionBuilder =
    PaymentAccountTransactionsCompanion Function({
      Value<int> id,
      Value<int> accountId,
      Value<int?> invoiceId,
      Value<String?> invoiceNumber,
      Value<int> userId,
      Value<String> kind,
      Value<double> amount,
      Value<String?> note,
      Value<DateTime> createdAt,
    });

final class $$PaymentAccountTransactionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PaymentAccountTransactionsTable,
          PaymentAccountTransaction
        > {
  $$PaymentAccountTransactionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PaymentAccountsTable _accountIdTable(_$AppDatabase db) =>
      db.paymentAccounts.createAlias(
        $_aliasNameGenerator(
          db.paymentAccountTransactions.accountId,
          db.paymentAccounts.id,
        ),
      );

  $$PaymentAccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<int>('account_id')!;

    final manager = $$PaymentAccountsTableTableManager(
      $_db,
      $_db.paymentAccounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $InvoicesTable _invoiceIdTable(_$AppDatabase db) =>
      db.invoices.createAlias(
        $_aliasNameGenerator(
          db.paymentAccountTransactions.invoiceId,
          db.invoices.id,
        ),
      );

  $$InvoicesTableProcessedTableManager? get invoiceId {
    final $_column = $_itemColumn<int>('invoice_id');
    if ($_column == null) return null;
    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.paymentAccountTransactions.userId, db.users.id),
  );

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PaymentAccountTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentAccountTransactionsTable> {
  $$PaymentAccountTransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PaymentAccountsTableFilterComposer get accountId {
    final $$PaymentAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.paymentAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentAccountsTableFilterComposer(
            $db: $db,
            $table: $db.paymentAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InvoicesTableFilterComposer get invoiceId {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentAccountTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentAccountTransactionsTable> {
  $$PaymentAccountTransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PaymentAccountsTableOrderingComposer get accountId {
    final $$PaymentAccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.paymentAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentAccountsTableOrderingComposer(
            $db: $db,
            $table: $db.paymentAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InvoicesTableOrderingComposer get invoiceId {
    final $$InvoicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableOrderingComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentAccountTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentAccountTransactionsTable> {
  $$PaymentAccountTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PaymentAccountsTableAnnotationComposer get accountId {
    final $$PaymentAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.paymentAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.paymentAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InvoicesTableAnnotationComposer get invoiceId {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentAccountTransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentAccountTransactionsTable,
          PaymentAccountTransaction,
          $$PaymentAccountTransactionsTableFilterComposer,
          $$PaymentAccountTransactionsTableOrderingComposer,
          $$PaymentAccountTransactionsTableAnnotationComposer,
          $$PaymentAccountTransactionsTableCreateCompanionBuilder,
          $$PaymentAccountTransactionsTableUpdateCompanionBuilder,
          (
            PaymentAccountTransaction,
            $$PaymentAccountTransactionsTableReferences,
          ),
          PaymentAccountTransaction,
          PrefetchHooks Function({bool accountId, bool invoiceId, bool userId})
        > {
  $$PaymentAccountTransactionsTableTableManager(
    _$AppDatabase db,
    $PaymentAccountTransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentAccountTransactionsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$PaymentAccountTransactionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PaymentAccountTransactionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> accountId = const Value.absent(),
                Value<int?> invoiceId = const Value.absent(),
                Value<String?> invoiceNumber = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PaymentAccountTransactionsCompanion(
                id: id,
                accountId: accountId,
                invoiceId: invoiceId,
                invoiceNumber: invoiceNumber,
                userId: userId,
                kind: kind,
                amount: amount,
                note: note,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int accountId,
                Value<int?> invoiceId = const Value.absent(),
                Value<String?> invoiceNumber = const Value.absent(),
                required int userId,
                required String kind,
                required double amount,
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PaymentAccountTransactionsCompanion.insert(
                id: id,
                accountId: accountId,
                invoiceId: invoiceId,
                invoiceNumber: invoiceNumber,
                userId: userId,
                kind: kind,
                amount: amount,
                note: note,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PaymentAccountTransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({accountId = false, invoiceId = false, userId = false}) {
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
                    if (accountId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.accountId,
                                referencedTable:
                                    $$PaymentAccountTransactionsTableReferences
                                        ._accountIdTable(db),
                                referencedColumn:
                                    $$PaymentAccountTransactionsTableReferences
                                        ._accountIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (invoiceId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.invoiceId,
                                referencedTable:
                                    $$PaymentAccountTransactionsTableReferences
                                        ._invoiceIdTable(db),
                                referencedColumn:
                                    $$PaymentAccountTransactionsTableReferences
                                        ._invoiceIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (userId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userId,
                                referencedTable:
                                    $$PaymentAccountTransactionsTableReferences
                                        ._userIdTable(db),
                                referencedColumn:
                                    $$PaymentAccountTransactionsTableReferences
                                        ._userIdTable(db)
                                        .id,
                              )
                              as T;
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

typedef $$PaymentAccountTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentAccountTransactionsTable,
      PaymentAccountTransaction,
      $$PaymentAccountTransactionsTableFilterComposer,
      $$PaymentAccountTransactionsTableOrderingComposer,
      $$PaymentAccountTransactionsTableAnnotationComposer,
      $$PaymentAccountTransactionsTableCreateCompanionBuilder,
      $$PaymentAccountTransactionsTableUpdateCompanionBuilder,
      (PaymentAccountTransaction, $$PaymentAccountTransactionsTableReferences),
      PaymentAccountTransaction,
      PrefetchHooks Function({bool accountId, bool invoiceId, bool userId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$InvoicesTableTableManager get invoices =>
      $$InvoicesTableTableManager(_db, _db.invoices);
  $$InvoiceItemsTableTableManager get invoiceItems =>
      $$InvoiceItemsTableTableManager(_db, _db.invoiceItems);
  $$StockMovementsTableTableManager get stockMovements =>
      $$StockMovementsTableTableManager(_db, _db.stockMovements);
  $$SuppliersTableTableManager get suppliers =>
      $$SuppliersTableTableManager(_db, _db.suppliers);
  $$PurchasesTableTableManager get purchases =>
      $$PurchasesTableTableManager(_db, _db.purchases);
  $$PurchaseItemsTableTableManager get purchaseItems =>
      $$PurchaseItemsTableTableManager(_db, _db.purchaseItems);
  $$PurchasePaymentsTableTableManager get purchasePayments =>
      $$PurchasePaymentsTableTableManager(_db, _db.purchasePayments);
  $$PaymentAccountsTableTableManager get paymentAccounts =>
      $$PaymentAccountsTableTableManager(_db, _db.paymentAccounts);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
  $$DailyClosingsTableTableManager get dailyClosings =>
      $$DailyClosingsTableTableManager(_db, _db.dailyClosings);
  $$DebtPaymentsTableTableManager get debtPayments =>
      $$DebtPaymentsTableTableManager(_db, _db.debtPayments);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$WorkerAdvancesTableTableManager get workerAdvances =>
      $$WorkerAdvancesTableTableManager(_db, _db.workerAdvances);
  $$WorkerProductIssuesTableTableManager get workerProductIssues =>
      $$WorkerProductIssuesTableTableManager(_db, _db.workerProductIssues);
  $$PaymentAccountTransactionsTableTableManager
  get paymentAccountTransactions =>
      $$PaymentAccountTransactionsTableTableManager(
        _db,
        _db.paymentAccountTransactions,
      );
}
