// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_db_context.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
      'display_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _birthDateMeta =
      const VerificationMeta('birthDate');
  @override
  late final GeneratedColumn<DateTime> birthDate = GeneratedColumn<DateTime>(
      'birth_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastSeenMeta =
      const VerificationMeta('lastSeen');
  @override
  late final GeneratedColumn<DateTime> lastSeen = GeneratedColumn<DateTime>(
      'last_seen', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _dataCreationTimeMeta =
      const VerificationMeta('dataCreationTime');
  @override
  late final GeneratedColumn<DateTime> dataCreationTime =
      GeneratedColumn<DateTime>('data_creation_time', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _currentUserMeta =
      const VerificationMeta('currentUser');
  @override
  late final GeneratedColumn<String> currentUser = GeneratedColumn<String>(
      'current_user', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isSimpleMeta =
      const VerificationMeta('isSimple');
  @override
  late final GeneratedColumn<bool> isSimple = GeneratedColumn<bool>(
      'is_simple', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_simple" IN (0, 1))'));
  static const VerificationMeta _isTempRecommendationMeta =
      const VerificationMeta('isTempRecommendation');
  @override
  late final GeneratedColumn<bool> isTempRecommendation = GeneratedColumn<bool>(
      'is_temp_recommendation', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_temp_recommendation" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        username,
        displayName,
        birthDate,
        status,
        lastSeen,
        dataCreationTime,
        currentUser,
        isSimple,
        isTempRecommendation
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('birth_date')) {
      context.handle(_birthDateMeta,
          birthDate.isAcceptableOrUnknown(data['birth_date']!, _birthDateMeta));
    } else if (isInserting) {
      context.missing(_birthDateMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('last_seen')) {
      context.handle(_lastSeenMeta,
          lastSeen.isAcceptableOrUnknown(data['last_seen']!, _lastSeenMeta));
    } else if (isInserting) {
      context.missing(_lastSeenMeta);
    }
    if (data.containsKey('data_creation_time')) {
      context.handle(
          _dataCreationTimeMeta,
          dataCreationTime.isAcceptableOrUnknown(
              data['data_creation_time']!, _dataCreationTimeMeta));
    } else if (isInserting) {
      context.missing(_dataCreationTimeMeta);
    }
    if (data.containsKey('current_user')) {
      context.handle(
          _currentUserMeta,
          currentUser.isAcceptableOrUnknown(
              data['current_user']!, _currentUserMeta));
    } else if (isInserting) {
      context.missing(_currentUserMeta);
    }
    if (data.containsKey('is_simple')) {
      context.handle(_isSimpleMeta,
          isSimple.isAcceptableOrUnknown(data['is_simple']!, _isSimpleMeta));
    } else if (isInserting) {
      context.missing(_isSimpleMeta);
    }
    if (data.containsKey('is_temp_recommendation')) {
      context.handle(
          _isTempRecommendationMeta,
          isTempRecommendation.isAcceptableOrUnknown(
              data['is_temp_recommendation']!, _isTempRecommendationMeta));
    } else if (isInserting) {
      context.missing(_isTempRecommendationMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username'])!,
      displayName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}display_name'])!,
      birthDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}birth_date'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      lastSeen: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_seen'])!,
      dataCreationTime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}data_creation_time'])!,
      currentUser: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}current_user'])!,
      isSimple: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_simple'])!,
      isTempRecommendation: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}is_temp_recommendation'])!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final String id;
  final String username;
  final String displayName;
  final DateTime birthDate;
  final String status;
  final DateTime lastSeen;
  final DateTime dataCreationTime;
  final String currentUser;
  final bool isSimple;
  final bool isTempRecommendation;
  const User(
      {required this.id,
      required this.username,
      required this.displayName,
      required this.birthDate,
      required this.status,
      required this.lastSeen,
      required this.dataCreationTime,
      required this.currentUser,
      required this.isSimple,
      required this.isTempRecommendation});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['username'] = Variable<String>(username);
    map['display_name'] = Variable<String>(displayName);
    map['birth_date'] = Variable<DateTime>(birthDate);
    map['status'] = Variable<String>(status);
    map['last_seen'] = Variable<DateTime>(lastSeen);
    map['data_creation_time'] = Variable<DateTime>(dataCreationTime);
    map['current_user'] = Variable<String>(currentUser);
    map['is_simple'] = Variable<bool>(isSimple);
    map['is_temp_recommendation'] = Variable<bool>(isTempRecommendation);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      username: Value(username),
      displayName: Value(displayName),
      birthDate: Value(birthDate),
      status: Value(status),
      lastSeen: Value(lastSeen),
      dataCreationTime: Value(dataCreationTime),
      currentUser: Value(currentUser),
      isSimple: Value(isSimple),
      isTempRecommendation: Value(isTempRecommendation),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<String>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      displayName: serializer.fromJson<String>(json['displayName']),
      birthDate: serializer.fromJson<DateTime>(json['birthDate']),
      status: serializer.fromJson<String>(json['status']),
      lastSeen: serializer.fromJson<DateTime>(json['lastSeen']),
      dataCreationTime: serializer.fromJson<DateTime>(json['dataCreationTime']),
      currentUser: serializer.fromJson<String>(json['currentUser']),
      isSimple: serializer.fromJson<bool>(json['isSimple']),
      isTempRecommendation:
          serializer.fromJson<bool>(json['isTempRecommendation']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'username': serializer.toJson<String>(username),
      'displayName': serializer.toJson<String>(displayName),
      'birthDate': serializer.toJson<DateTime>(birthDate),
      'status': serializer.toJson<String>(status),
      'lastSeen': serializer.toJson<DateTime>(lastSeen),
      'dataCreationTime': serializer.toJson<DateTime>(dataCreationTime),
      'currentUser': serializer.toJson<String>(currentUser),
      'isSimple': serializer.toJson<bool>(isSimple),
      'isTempRecommendation': serializer.toJson<bool>(isTempRecommendation),
    };
  }

  User copyWith(
          {String? id,
          String? username,
          String? displayName,
          DateTime? birthDate,
          String? status,
          DateTime? lastSeen,
          DateTime? dataCreationTime,
          String? currentUser,
          bool? isSimple,
          bool? isTempRecommendation}) =>
      User(
        id: id ?? this.id,
        username: username ?? this.username,
        displayName: displayName ?? this.displayName,
        birthDate: birthDate ?? this.birthDate,
        status: status ?? this.status,
        lastSeen: lastSeen ?? this.lastSeen,
        dataCreationTime: dataCreationTime ?? this.dataCreationTime,
        currentUser: currentUser ?? this.currentUser,
        isSimple: isSimple ?? this.isSimple,
        isTempRecommendation: isTempRecommendation ?? this.isTempRecommendation,
      );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      displayName:
          data.displayName.present ? data.displayName.value : this.displayName,
      birthDate: data.birthDate.present ? data.birthDate.value : this.birthDate,
      status: data.status.present ? data.status.value : this.status,
      lastSeen: data.lastSeen.present ? data.lastSeen.value : this.lastSeen,
      dataCreationTime: data.dataCreationTime.present
          ? data.dataCreationTime.value
          : this.dataCreationTime,
      currentUser:
          data.currentUser.present ? data.currentUser.value : this.currentUser,
      isSimple: data.isSimple.present ? data.isSimple.value : this.isSimple,
      isTempRecommendation: data.isTempRecommendation.present
          ? data.isTempRecommendation.value
          : this.isTempRecommendation,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('displayName: $displayName, ')
          ..write('birthDate: $birthDate, ')
          ..write('status: $status, ')
          ..write('lastSeen: $lastSeen, ')
          ..write('dataCreationTime: $dataCreationTime, ')
          ..write('currentUser: $currentUser, ')
          ..write('isSimple: $isSimple, ')
          ..write('isTempRecommendation: $isTempRecommendation')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, username, displayName, birthDate, status,
      lastSeen, dataCreationTime, currentUser, isSimple, isTempRecommendation);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.username == this.username &&
          other.displayName == this.displayName &&
          other.birthDate == this.birthDate &&
          other.status == this.status &&
          other.lastSeen == this.lastSeen &&
          other.dataCreationTime == this.dataCreationTime &&
          other.currentUser == this.currentUser &&
          other.isSimple == this.isSimple &&
          other.isTempRecommendation == this.isTempRecommendation);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<String> username;
  final Value<String> displayName;
  final Value<DateTime> birthDate;
  final Value<String> status;
  final Value<DateTime> lastSeen;
  final Value<DateTime> dataCreationTime;
  final Value<String> currentUser;
  final Value<bool> isSimple;
  final Value<bool> isTempRecommendation;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.displayName = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.status = const Value.absent(),
    this.lastSeen = const Value.absent(),
    this.dataCreationTime = const Value.absent(),
    this.currentUser = const Value.absent(),
    this.isSimple = const Value.absent(),
    this.isTempRecommendation = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    required String username,
    required String displayName,
    required DateTime birthDate,
    required String status,
    required DateTime lastSeen,
    required DateTime dataCreationTime,
    required String currentUser,
    required bool isSimple,
    required bool isTempRecommendation,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        username = Value(username),
        displayName = Value(displayName),
        birthDate = Value(birthDate),
        status = Value(status),
        lastSeen = Value(lastSeen),
        dataCreationTime = Value(dataCreationTime),
        currentUser = Value(currentUser),
        isSimple = Value(isSimple),
        isTempRecommendation = Value(isTempRecommendation);
  static Insertable<User> custom({
    Expression<String>? id,
    Expression<String>? username,
    Expression<String>? displayName,
    Expression<DateTime>? birthDate,
    Expression<String>? status,
    Expression<DateTime>? lastSeen,
    Expression<DateTime>? dataCreationTime,
    Expression<String>? currentUser,
    Expression<bool>? isSimple,
    Expression<bool>? isTempRecommendation,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (displayName != null) 'display_name': displayName,
      if (birthDate != null) 'birth_date': birthDate,
      if (status != null) 'status': status,
      if (lastSeen != null) 'last_seen': lastSeen,
      if (dataCreationTime != null) 'data_creation_time': dataCreationTime,
      if (currentUser != null) 'current_user': currentUser,
      if (isSimple != null) 'is_simple': isSimple,
      if (isTempRecommendation != null)
        'is_temp_recommendation': isTempRecommendation,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith(
      {Value<String>? id,
      Value<String>? username,
      Value<String>? displayName,
      Value<DateTime>? birthDate,
      Value<String>? status,
      Value<DateTime>? lastSeen,
      Value<DateTime>? dataCreationTime,
      Value<String>? currentUser,
      Value<bool>? isSimple,
      Value<bool>? isTempRecommendation,
      Value<int>? rowid}) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      birthDate: birthDate ?? this.birthDate,
      status: status ?? this.status,
      lastSeen: lastSeen ?? this.lastSeen,
      dataCreationTime: dataCreationTime ?? this.dataCreationTime,
      currentUser: currentUser ?? this.currentUser,
      isSimple: isSimple ?? this.isSimple,
      isTempRecommendation: isTempRecommendation ?? this.isTempRecommendation,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (birthDate.present) {
      map['birth_date'] = Variable<DateTime>(birthDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (lastSeen.present) {
      map['last_seen'] = Variable<DateTime>(lastSeen.value);
    }
    if (dataCreationTime.present) {
      map['data_creation_time'] = Variable<DateTime>(dataCreationTime.value);
    }
    if (currentUser.present) {
      map['current_user'] = Variable<String>(currentUser.value);
    }
    if (isSimple.present) {
      map['is_simple'] = Variable<bool>(isSimple.value);
    }
    if (isTempRecommendation.present) {
      map['is_temp_recommendation'] =
          Variable<bool>(isTempRecommendation.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('displayName: $displayName, ')
          ..write('birthDate: $birthDate, ')
          ..write('status: $status, ')
          ..write('lastSeen: $lastSeen, ')
          ..write('dataCreationTime: $dataCreationTime, ')
          ..write('currentUser: $currentUser, ')
          ..write('isSimple: $isSimple, ')
          ..write('isTempRecommendation: $isTempRecommendation, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PostsTable extends Posts with TableInfo<$PostsTable, Post> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PostsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ownerIdMeta =
      const VerificationMeta('ownerId');
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
      'owner_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _dataCreationTimeMeta =
      const VerificationMeta('dataCreationTime');
  @override
  late final GeneratedColumn<DateTime> dataCreationTime =
      GeneratedColumn<DateTime>('data_creation_time', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _versionMeta =
      const VerificationMeta('version');
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
      'version', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, ownerId, dataCreationTime, version];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'posts';
  @override
  VerificationContext validateIntegrity(Insertable<Post> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('owner_id')) {
      context.handle(_ownerIdMeta,
          ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta));
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('data_creation_time')) {
      context.handle(
          _dataCreationTimeMeta,
          dataCreationTime.isAcceptableOrUnknown(
              data['data_creation_time']!, _dataCreationTimeMeta));
    } else if (isInserting) {
      context.missing(_dataCreationTimeMeta);
    }
    if (data.containsKey('version')) {
      context.handle(_versionMeta,
          version.isAcceptableOrUnknown(data['version']!, _versionMeta));
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Post map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Post(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      ownerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}owner_id'])!,
      dataCreationTime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}data_creation_time'])!,
      version: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}version'])!,
    );
  }

  @override
  $PostsTable createAlias(String alias) {
    return $PostsTable(attachedDatabase, alias);
  }
}

class Post extends DataClass implements Insertable<Post> {
  final String id;
  final String ownerId;
  final DateTime dataCreationTime;
  final int version;
  const Post(
      {required this.id,
      required this.ownerId,
      required this.dataCreationTime,
      required this.version});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['owner_id'] = Variable<String>(ownerId);
    map['data_creation_time'] = Variable<DateTime>(dataCreationTime);
    map['version'] = Variable<int>(version);
    return map;
  }

  PostsCompanion toCompanion(bool nullToAbsent) {
    return PostsCompanion(
      id: Value(id),
      ownerId: Value(ownerId),
      dataCreationTime: Value(dataCreationTime),
      version: Value(version),
    );
  }

  factory Post.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Post(
      id: serializer.fromJson<String>(json['id']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      dataCreationTime: serializer.fromJson<DateTime>(json['dataCreationTime']),
      version: serializer.fromJson<int>(json['version']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ownerId': serializer.toJson<String>(ownerId),
      'dataCreationTime': serializer.toJson<DateTime>(dataCreationTime),
      'version': serializer.toJson<int>(version),
    };
  }

  Post copyWith(
          {String? id,
          String? ownerId,
          DateTime? dataCreationTime,
          int? version}) =>
      Post(
        id: id ?? this.id,
        ownerId: ownerId ?? this.ownerId,
        dataCreationTime: dataCreationTime ?? this.dataCreationTime,
        version: version ?? this.version,
      );
  Post copyWithCompanion(PostsCompanion data) {
    return Post(
      id: data.id.present ? data.id.value : this.id,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      dataCreationTime: data.dataCreationTime.present
          ? data.dataCreationTime.value
          : this.dataCreationTime,
      version: data.version.present ? data.version.value : this.version,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Post(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('dataCreationTime: $dataCreationTime, ')
          ..write('version: $version')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ownerId, dataCreationTime, version);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Post &&
          other.id == this.id &&
          other.ownerId == this.ownerId &&
          other.dataCreationTime == this.dataCreationTime &&
          other.version == this.version);
}

class PostsCompanion extends UpdateCompanion<Post> {
  final Value<String> id;
  final Value<String> ownerId;
  final Value<DateTime> dataCreationTime;
  final Value<int> version;
  final Value<int> rowid;
  const PostsCompanion({
    this.id = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.dataCreationTime = const Value.absent(),
    this.version = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PostsCompanion.insert({
    required String id,
    required String ownerId,
    required DateTime dataCreationTime,
    required int version,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        ownerId = Value(ownerId),
        dataCreationTime = Value(dataCreationTime),
        version = Value(version);
  static Insertable<Post> custom({
    Expression<String>? id,
    Expression<String>? ownerId,
    Expression<DateTime>? dataCreationTime,
    Expression<int>? version,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerId != null) 'owner_id': ownerId,
      if (dataCreationTime != null) 'data_creation_time': dataCreationTime,
      if (version != null) 'version': version,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PostsCompanion copyWith(
      {Value<String>? id,
      Value<String>? ownerId,
      Value<DateTime>? dataCreationTime,
      Value<int>? version,
      Value<int>? rowid}) {
    return PostsCompanion(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      dataCreationTime: dataCreationTime ?? this.dataCreationTime,
      version: version ?? this.version,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (dataCreationTime.present) {
      map['data_creation_time'] = Variable<DateTime>(dataCreationTime.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PostsCompanion(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('dataCreationTime: $dataCreationTime, ')
          ..write('version: $version, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SimpleLocationPointsTable extends SimpleLocationPoints
    with TableInfo<$SimpleLocationPointsTable, SimpleLocationPoint> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SimpleLocationPointsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _postIdMeta = const VerificationMeta('postId');
  @override
  late final GeneratedColumn<String> postId = GeneratedColumn<String>(
      'post_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
      'longitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
      'type', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _zoomLevelMeta =
      const VerificationMeta('zoomLevel');
  @override
  late final GeneratedColumn<int> zoomLevel = GeneratedColumn<int>(
      'zoom_level', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _childCountMeta =
      const VerificationMeta('childCount');
  @override
  late final GeneratedColumn<int> childCount = GeneratedColumn<int>(
      'child_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _imageIdMeta =
      const VerificationMeta('imageId');
  @override
  late final GeneratedColumn<String> imageId = GeneratedColumn<String>(
      'image_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _currentUserMeta =
      const VerificationMeta('currentUser');
  @override
  late final GeneratedColumn<String> currentUser = GeneratedColumn<String>(
      'current_user', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        postId,
        longitude,
        latitude,
        type,
        zoomLevel,
        childCount,
        imageId,
        currentUser
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'simple_location_points';
  @override
  VerificationContext validateIntegrity(
      Insertable<SimpleLocationPoint> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('post_id')) {
      context.handle(_postIdMeta,
          postId.isAcceptableOrUnknown(data['post_id']!, _postIdMeta));
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('zoom_level')) {
      context.handle(_zoomLevelMeta,
          zoomLevel.isAcceptableOrUnknown(data['zoom_level']!, _zoomLevelMeta));
    } else if (isInserting) {
      context.missing(_zoomLevelMeta);
    }
    if (data.containsKey('child_count')) {
      context.handle(
          _childCountMeta,
          childCount.isAcceptableOrUnknown(
              data['child_count']!, _childCountMeta));
    } else if (isInserting) {
      context.missing(_childCountMeta);
    }
    if (data.containsKey('image_id')) {
      context.handle(_imageIdMeta,
          imageId.isAcceptableOrUnknown(data['image_id']!, _imageIdMeta));
    }
    if (data.containsKey('current_user')) {
      context.handle(
          _currentUserMeta,
          currentUser.isAcceptableOrUnknown(
              data['current_user']!, _currentUserMeta));
    } else if (isInserting) {
      context.missing(_currentUserMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SimpleLocationPoint map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SimpleLocationPoint(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      postId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}post_id']),
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude'])!,
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!,
      zoomLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}zoom_level'])!,
      childCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}child_count'])!,
      imageId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_id']),
      currentUser: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}current_user'])!,
    );
  }

  @override
  $SimpleLocationPointsTable createAlias(String alias) {
    return $SimpleLocationPointsTable(attachedDatabase, alias);
  }
}

class SimpleLocationPoint extends DataClass
    implements Insertable<SimpleLocationPoint> {
  final String id;
  final String? postId;
  final double longitude;
  final double latitude;
  final int type;
  final int zoomLevel;
  final int childCount;
  final String? imageId;
  final String currentUser;
  const SimpleLocationPoint(
      {required this.id,
      this.postId,
      required this.longitude,
      required this.latitude,
      required this.type,
      required this.zoomLevel,
      required this.childCount,
      this.imageId,
      required this.currentUser});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || postId != null) {
      map['post_id'] = Variable<String>(postId);
    }
    map['longitude'] = Variable<double>(longitude);
    map['latitude'] = Variable<double>(latitude);
    map['type'] = Variable<int>(type);
    map['zoom_level'] = Variable<int>(zoomLevel);
    map['child_count'] = Variable<int>(childCount);
    if (!nullToAbsent || imageId != null) {
      map['image_id'] = Variable<String>(imageId);
    }
    map['current_user'] = Variable<String>(currentUser);
    return map;
  }

  SimpleLocationPointsCompanion toCompanion(bool nullToAbsent) {
    return SimpleLocationPointsCompanion(
      id: Value(id),
      postId:
          postId == null && nullToAbsent ? const Value.absent() : Value(postId),
      longitude: Value(longitude),
      latitude: Value(latitude),
      type: Value(type),
      zoomLevel: Value(zoomLevel),
      childCount: Value(childCount),
      imageId: imageId == null && nullToAbsent
          ? const Value.absent()
          : Value(imageId),
      currentUser: Value(currentUser),
    );
  }

  factory SimpleLocationPoint.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SimpleLocationPoint(
      id: serializer.fromJson<String>(json['id']),
      postId: serializer.fromJson<String?>(json['postId']),
      longitude: serializer.fromJson<double>(json['longitude']),
      latitude: serializer.fromJson<double>(json['latitude']),
      type: serializer.fromJson<int>(json['type']),
      zoomLevel: serializer.fromJson<int>(json['zoomLevel']),
      childCount: serializer.fromJson<int>(json['childCount']),
      imageId: serializer.fromJson<String?>(json['imageId']),
      currentUser: serializer.fromJson<String>(json['currentUser']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'postId': serializer.toJson<String?>(postId),
      'longitude': serializer.toJson<double>(longitude),
      'latitude': serializer.toJson<double>(latitude),
      'type': serializer.toJson<int>(type),
      'zoomLevel': serializer.toJson<int>(zoomLevel),
      'childCount': serializer.toJson<int>(childCount),
      'imageId': serializer.toJson<String?>(imageId),
      'currentUser': serializer.toJson<String>(currentUser),
    };
  }

  SimpleLocationPoint copyWith(
          {String? id,
          Value<String?> postId = const Value.absent(),
          double? longitude,
          double? latitude,
          int? type,
          int? zoomLevel,
          int? childCount,
          Value<String?> imageId = const Value.absent(),
          String? currentUser}) =>
      SimpleLocationPoint(
        id: id ?? this.id,
        postId: postId.present ? postId.value : this.postId,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
        type: type ?? this.type,
        zoomLevel: zoomLevel ?? this.zoomLevel,
        childCount: childCount ?? this.childCount,
        imageId: imageId.present ? imageId.value : this.imageId,
        currentUser: currentUser ?? this.currentUser,
      );
  SimpleLocationPoint copyWithCompanion(SimpleLocationPointsCompanion data) {
    return SimpleLocationPoint(
      id: data.id.present ? data.id.value : this.id,
      postId: data.postId.present ? data.postId.value : this.postId,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      type: data.type.present ? data.type.value : this.type,
      zoomLevel: data.zoomLevel.present ? data.zoomLevel.value : this.zoomLevel,
      childCount:
          data.childCount.present ? data.childCount.value : this.childCount,
      imageId: data.imageId.present ? data.imageId.value : this.imageId,
      currentUser:
          data.currentUser.present ? data.currentUser.value : this.currentUser,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SimpleLocationPoint(')
          ..write('id: $id, ')
          ..write('postId: $postId, ')
          ..write('longitude: $longitude, ')
          ..write('latitude: $latitude, ')
          ..write('type: $type, ')
          ..write('zoomLevel: $zoomLevel, ')
          ..write('childCount: $childCount, ')
          ..write('imageId: $imageId, ')
          ..write('currentUser: $currentUser')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, postId, longitude, latitude, type,
      zoomLevel, childCount, imageId, currentUser);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SimpleLocationPoint &&
          other.id == this.id &&
          other.postId == this.postId &&
          other.longitude == this.longitude &&
          other.latitude == this.latitude &&
          other.type == this.type &&
          other.zoomLevel == this.zoomLevel &&
          other.childCount == this.childCount &&
          other.imageId == this.imageId &&
          other.currentUser == this.currentUser);
}

class SimpleLocationPointsCompanion
    extends UpdateCompanion<SimpleLocationPoint> {
  final Value<String> id;
  final Value<String?> postId;
  final Value<double> longitude;
  final Value<double> latitude;
  final Value<int> type;
  final Value<int> zoomLevel;
  final Value<int> childCount;
  final Value<String?> imageId;
  final Value<String> currentUser;
  final Value<int> rowid;
  const SimpleLocationPointsCompanion({
    this.id = const Value.absent(),
    this.postId = const Value.absent(),
    this.longitude = const Value.absent(),
    this.latitude = const Value.absent(),
    this.type = const Value.absent(),
    this.zoomLevel = const Value.absent(),
    this.childCount = const Value.absent(),
    this.imageId = const Value.absent(),
    this.currentUser = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SimpleLocationPointsCompanion.insert({
    required String id,
    this.postId = const Value.absent(),
    required double longitude,
    required double latitude,
    required int type,
    required int zoomLevel,
    required int childCount,
    this.imageId = const Value.absent(),
    required String currentUser,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        longitude = Value(longitude),
        latitude = Value(latitude),
        type = Value(type),
        zoomLevel = Value(zoomLevel),
        childCount = Value(childCount),
        currentUser = Value(currentUser);
  static Insertable<SimpleLocationPoint> custom({
    Expression<String>? id,
    Expression<String>? postId,
    Expression<double>? longitude,
    Expression<double>? latitude,
    Expression<int>? type,
    Expression<int>? zoomLevel,
    Expression<int>? childCount,
    Expression<String>? imageId,
    Expression<String>? currentUser,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (postId != null) 'post_id': postId,
      if (longitude != null) 'longitude': longitude,
      if (latitude != null) 'latitude': latitude,
      if (type != null) 'type': type,
      if (zoomLevel != null) 'zoom_level': zoomLevel,
      if (childCount != null) 'child_count': childCount,
      if (imageId != null) 'image_id': imageId,
      if (currentUser != null) 'current_user': currentUser,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SimpleLocationPointsCompanion copyWith(
      {Value<String>? id,
      Value<String?>? postId,
      Value<double>? longitude,
      Value<double>? latitude,
      Value<int>? type,
      Value<int>? zoomLevel,
      Value<int>? childCount,
      Value<String?>? imageId,
      Value<String>? currentUser,
      Value<int>? rowid}) {
    return SimpleLocationPointsCompanion(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      type: type ?? this.type,
      zoomLevel: zoomLevel ?? this.zoomLevel,
      childCount: childCount ?? this.childCount,
      imageId: imageId ?? this.imageId,
      currentUser: currentUser ?? this.currentUser,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (postId.present) {
      map['post_id'] = Variable<String>(postId.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (zoomLevel.present) {
      map['zoom_level'] = Variable<int>(zoomLevel.value);
    }
    if (childCount.present) {
      map['child_count'] = Variable<int>(childCount.value);
    }
    if (imageId.present) {
      map['image_id'] = Variable<String>(imageId.value);
    }
    if (currentUser.present) {
      map['current_user'] = Variable<String>(currentUser.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SimpleLocationPointsCompanion(')
          ..write('id: $id, ')
          ..write('postId: $postId, ')
          ..write('longitude: $longitude, ')
          ..write('latitude: $latitude, ')
          ..write('type: $type, ')
          ..write('zoomLevel: $zoomLevel, ')
          ..write('childCount: $childCount, ')
          ..write('imageId: $imageId, ')
          ..write('currentUser: $currentUser, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocationPostsTable extends LocationPosts
    with TableInfo<$LocationPostsTable, LocationPost> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocationPostsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _locationIdMeta =
      const VerificationMeta('locationId');
  @override
  late final GeneratedColumn<String> locationId = GeneratedColumn<String>(
      'location_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _eventTimeMeta =
      const VerificationMeta('eventTime');
  @override
  late final GeneratedColumn<DateTime> eventTime = GeneratedColumn<DateTime>(
      'event_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ownerDisplayNameMeta =
      const VerificationMeta('ownerDisplayName');
  @override
  late final GeneratedColumn<String> ownerDisplayName = GeneratedColumn<String>(
      'owner_display_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pointIdMeta =
      const VerificationMeta('pointId');
  @override
  late final GeneratedColumn<String> pointId = GeneratedColumn<String>(
      'point_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES simple_location_points (id)'));
  static const VerificationMeta _smallFirstImageIdMeta =
      const VerificationMeta('smallFirstImageId');
  @override
  late final GeneratedColumn<String> smallFirstImageId =
      GeneratedColumn<String>('small_first_image_id', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dataCreationTimeMeta =
      const VerificationMeta('dataCreationTime');
  @override
  late final GeneratedColumn<DateTime> dataCreationTime =
      GeneratedColumn<DateTime>('data_creation_time', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _notificationIdMeta =
      const VerificationMeta('notificationId');
  @override
  late final GeneratedColumn<int> notificationId = GeneratedColumn<int>(
      'notification_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _versionMeta =
      const VerificationMeta('version');
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
      'version', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        locationId,
        eventTime,
        description,
        ownerDisplayName,
        pointId,
        smallFirstImageId,
        dataCreationTime,
        notificationId,
        version
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'location_posts';
  @override
  VerificationContext validateIntegrity(Insertable<LocationPost> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('location_id')) {
      context.handle(
          _locationIdMeta,
          locationId.isAcceptableOrUnknown(
              data['location_id']!, _locationIdMeta));
    }
    if (data.containsKey('event_time')) {
      context.handle(_eventTimeMeta,
          eventTime.isAcceptableOrUnknown(data['event_time']!, _eventTimeMeta));
    } else if (isInserting) {
      context.missing(_eventTimeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('owner_display_name')) {
      context.handle(
          _ownerDisplayNameMeta,
          ownerDisplayName.isAcceptableOrUnknown(
              data['owner_display_name']!, _ownerDisplayNameMeta));
    } else if (isInserting) {
      context.missing(_ownerDisplayNameMeta);
    }
    if (data.containsKey('point_id')) {
      context.handle(_pointIdMeta,
          pointId.isAcceptableOrUnknown(data['point_id']!, _pointIdMeta));
    } else if (isInserting) {
      context.missing(_pointIdMeta);
    }
    if (data.containsKey('small_first_image_id')) {
      context.handle(
          _smallFirstImageIdMeta,
          smallFirstImageId.isAcceptableOrUnknown(
              data['small_first_image_id']!, _smallFirstImageIdMeta));
    } else if (isInserting) {
      context.missing(_smallFirstImageIdMeta);
    }
    if (data.containsKey('data_creation_time')) {
      context.handle(
          _dataCreationTimeMeta,
          dataCreationTime.isAcceptableOrUnknown(
              data['data_creation_time']!, _dataCreationTimeMeta));
    } else if (isInserting) {
      context.missing(_dataCreationTimeMeta);
    }
    if (data.containsKey('notification_id')) {
      context.handle(
          _notificationIdMeta,
          notificationId.isAcceptableOrUnknown(
              data['notification_id']!, _notificationIdMeta));
    } else if (isInserting) {
      context.missing(_notificationIdMeta);
    }
    if (data.containsKey('version')) {
      context.handle(_versionMeta,
          version.isAcceptableOrUnknown(data['version']!, _versionMeta));
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocationPost map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocationPost(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      locationId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location_id']),
      eventTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}event_time'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      ownerDisplayName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}owner_display_name'])!,
      pointId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}point_id'])!,
      smallFirstImageId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}small_first_image_id'])!,
      dataCreationTime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}data_creation_time'])!,
      notificationId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}notification_id'])!,
      version: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}version'])!,
    );
  }

  @override
  $LocationPostsTable createAlias(String alias) {
    return $LocationPostsTable(attachedDatabase, alias);
  }
}

class LocationPost extends DataClass implements Insertable<LocationPost> {
  final String id;
  final String? locationId;
  final DateTime eventTime;
  final String description;
  final String ownerDisplayName;
  final String pointId;
  final String smallFirstImageId;
  final DateTime dataCreationTime;
  final int notificationId;
  final int version;
  const LocationPost(
      {required this.id,
      this.locationId,
      required this.eventTime,
      required this.description,
      required this.ownerDisplayName,
      required this.pointId,
      required this.smallFirstImageId,
      required this.dataCreationTime,
      required this.notificationId,
      required this.version});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || locationId != null) {
      map['location_id'] = Variable<String>(locationId);
    }
    map['event_time'] = Variable<DateTime>(eventTime);
    map['description'] = Variable<String>(description);
    map['owner_display_name'] = Variable<String>(ownerDisplayName);
    map['point_id'] = Variable<String>(pointId);
    map['small_first_image_id'] = Variable<String>(smallFirstImageId);
    map['data_creation_time'] = Variable<DateTime>(dataCreationTime);
    map['notification_id'] = Variable<int>(notificationId);
    map['version'] = Variable<int>(version);
    return map;
  }

  LocationPostsCompanion toCompanion(bool nullToAbsent) {
    return LocationPostsCompanion(
      id: Value(id),
      locationId: locationId == null && nullToAbsent
          ? const Value.absent()
          : Value(locationId),
      eventTime: Value(eventTime),
      description: Value(description),
      ownerDisplayName: Value(ownerDisplayName),
      pointId: Value(pointId),
      smallFirstImageId: Value(smallFirstImageId),
      dataCreationTime: Value(dataCreationTime),
      notificationId: Value(notificationId),
      version: Value(version),
    );
  }

  factory LocationPost.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocationPost(
      id: serializer.fromJson<String>(json['id']),
      locationId: serializer.fromJson<String?>(json['locationId']),
      eventTime: serializer.fromJson<DateTime>(json['eventTime']),
      description: serializer.fromJson<String>(json['description']),
      ownerDisplayName: serializer.fromJson<String>(json['ownerDisplayName']),
      pointId: serializer.fromJson<String>(json['pointId']),
      smallFirstImageId: serializer.fromJson<String>(json['smallFirstImageId']),
      dataCreationTime: serializer.fromJson<DateTime>(json['dataCreationTime']),
      notificationId: serializer.fromJson<int>(json['notificationId']),
      version: serializer.fromJson<int>(json['version']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'locationId': serializer.toJson<String?>(locationId),
      'eventTime': serializer.toJson<DateTime>(eventTime),
      'description': serializer.toJson<String>(description),
      'ownerDisplayName': serializer.toJson<String>(ownerDisplayName),
      'pointId': serializer.toJson<String>(pointId),
      'smallFirstImageId': serializer.toJson<String>(smallFirstImageId),
      'dataCreationTime': serializer.toJson<DateTime>(dataCreationTime),
      'notificationId': serializer.toJson<int>(notificationId),
      'version': serializer.toJson<int>(version),
    };
  }

  LocationPost copyWith(
          {String? id,
          Value<String?> locationId = const Value.absent(),
          DateTime? eventTime,
          String? description,
          String? ownerDisplayName,
          String? pointId,
          String? smallFirstImageId,
          DateTime? dataCreationTime,
          int? notificationId,
          int? version}) =>
      LocationPost(
        id: id ?? this.id,
        locationId: locationId.present ? locationId.value : this.locationId,
        eventTime: eventTime ?? this.eventTime,
        description: description ?? this.description,
        ownerDisplayName: ownerDisplayName ?? this.ownerDisplayName,
        pointId: pointId ?? this.pointId,
        smallFirstImageId: smallFirstImageId ?? this.smallFirstImageId,
        dataCreationTime: dataCreationTime ?? this.dataCreationTime,
        notificationId: notificationId ?? this.notificationId,
        version: version ?? this.version,
      );
  LocationPost copyWithCompanion(LocationPostsCompanion data) {
    return LocationPost(
      id: data.id.present ? data.id.value : this.id,
      locationId:
          data.locationId.present ? data.locationId.value : this.locationId,
      eventTime: data.eventTime.present ? data.eventTime.value : this.eventTime,
      description:
          data.description.present ? data.description.value : this.description,
      ownerDisplayName: data.ownerDisplayName.present
          ? data.ownerDisplayName.value
          : this.ownerDisplayName,
      pointId: data.pointId.present ? data.pointId.value : this.pointId,
      smallFirstImageId: data.smallFirstImageId.present
          ? data.smallFirstImageId.value
          : this.smallFirstImageId,
      dataCreationTime: data.dataCreationTime.present
          ? data.dataCreationTime.value
          : this.dataCreationTime,
      notificationId: data.notificationId.present
          ? data.notificationId.value
          : this.notificationId,
      version: data.version.present ? data.version.value : this.version,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocationPost(')
          ..write('id: $id, ')
          ..write('locationId: $locationId, ')
          ..write('eventTime: $eventTime, ')
          ..write('description: $description, ')
          ..write('ownerDisplayName: $ownerDisplayName, ')
          ..write('pointId: $pointId, ')
          ..write('smallFirstImageId: $smallFirstImageId, ')
          ..write('dataCreationTime: $dataCreationTime, ')
          ..write('notificationId: $notificationId, ')
          ..write('version: $version')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      locationId,
      eventTime,
      description,
      ownerDisplayName,
      pointId,
      smallFirstImageId,
      dataCreationTime,
      notificationId,
      version);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocationPost &&
          other.id == this.id &&
          other.locationId == this.locationId &&
          other.eventTime == this.eventTime &&
          other.description == this.description &&
          other.ownerDisplayName == this.ownerDisplayName &&
          other.pointId == this.pointId &&
          other.smallFirstImageId == this.smallFirstImageId &&
          other.dataCreationTime == this.dataCreationTime &&
          other.notificationId == this.notificationId &&
          other.version == this.version);
}

class LocationPostsCompanion extends UpdateCompanion<LocationPost> {
  final Value<String> id;
  final Value<String?> locationId;
  final Value<DateTime> eventTime;
  final Value<String> description;
  final Value<String> ownerDisplayName;
  final Value<String> pointId;
  final Value<String> smallFirstImageId;
  final Value<DateTime> dataCreationTime;
  final Value<int> notificationId;
  final Value<int> version;
  final Value<int> rowid;
  const LocationPostsCompanion({
    this.id = const Value.absent(),
    this.locationId = const Value.absent(),
    this.eventTime = const Value.absent(),
    this.description = const Value.absent(),
    this.ownerDisplayName = const Value.absent(),
    this.pointId = const Value.absent(),
    this.smallFirstImageId = const Value.absent(),
    this.dataCreationTime = const Value.absent(),
    this.notificationId = const Value.absent(),
    this.version = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocationPostsCompanion.insert({
    required String id,
    this.locationId = const Value.absent(),
    required DateTime eventTime,
    required String description,
    required String ownerDisplayName,
    required String pointId,
    required String smallFirstImageId,
    required DateTime dataCreationTime,
    required int notificationId,
    required int version,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        eventTime = Value(eventTime),
        description = Value(description),
        ownerDisplayName = Value(ownerDisplayName),
        pointId = Value(pointId),
        smallFirstImageId = Value(smallFirstImageId),
        dataCreationTime = Value(dataCreationTime),
        notificationId = Value(notificationId),
        version = Value(version);
  static Insertable<LocationPost> custom({
    Expression<String>? id,
    Expression<String>? locationId,
    Expression<DateTime>? eventTime,
    Expression<String>? description,
    Expression<String>? ownerDisplayName,
    Expression<String>? pointId,
    Expression<String>? smallFirstImageId,
    Expression<DateTime>? dataCreationTime,
    Expression<int>? notificationId,
    Expression<int>? version,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (locationId != null) 'location_id': locationId,
      if (eventTime != null) 'event_time': eventTime,
      if (description != null) 'description': description,
      if (ownerDisplayName != null) 'owner_display_name': ownerDisplayName,
      if (pointId != null) 'point_id': pointId,
      if (smallFirstImageId != null) 'small_first_image_id': smallFirstImageId,
      if (dataCreationTime != null) 'data_creation_time': dataCreationTime,
      if (notificationId != null) 'notification_id': notificationId,
      if (version != null) 'version': version,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocationPostsCompanion copyWith(
      {Value<String>? id,
      Value<String?>? locationId,
      Value<DateTime>? eventTime,
      Value<String>? description,
      Value<String>? ownerDisplayName,
      Value<String>? pointId,
      Value<String>? smallFirstImageId,
      Value<DateTime>? dataCreationTime,
      Value<int>? notificationId,
      Value<int>? version,
      Value<int>? rowid}) {
    return LocationPostsCompanion(
      id: id ?? this.id,
      locationId: locationId ?? this.locationId,
      eventTime: eventTime ?? this.eventTime,
      description: description ?? this.description,
      ownerDisplayName: ownerDisplayName ?? this.ownerDisplayName,
      pointId: pointId ?? this.pointId,
      smallFirstImageId: smallFirstImageId ?? this.smallFirstImageId,
      dataCreationTime: dataCreationTime ?? this.dataCreationTime,
      notificationId: notificationId ?? this.notificationId,
      version: version ?? this.version,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (locationId.present) {
      map['location_id'] = Variable<String>(locationId.value);
    }
    if (eventTime.present) {
      map['event_time'] = Variable<DateTime>(eventTime.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (ownerDisplayName.present) {
      map['owner_display_name'] = Variable<String>(ownerDisplayName.value);
    }
    if (pointId.present) {
      map['point_id'] = Variable<String>(pointId.value);
    }
    if (smallFirstImageId.present) {
      map['small_first_image_id'] = Variable<String>(smallFirstImageId.value);
    }
    if (dataCreationTime.present) {
      map['data_creation_time'] = Variable<DateTime>(dataCreationTime.value);
    }
    if (notificationId.present) {
      map['notification_id'] = Variable<int>(notificationId.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationPostsCompanion(')
          ..write('id: $id, ')
          ..write('locationId: $locationId, ')
          ..write('eventTime: $eventTime, ')
          ..write('description: $description, ')
          ..write('ownerDisplayName: $ownerDisplayName, ')
          ..write('pointId: $pointId, ')
          ..write('smallFirstImageId: $smallFirstImageId, ')
          ..write('dataCreationTime: $dataCreationTime, ')
          ..write('notificationId: $notificationId, ')
          ..write('version: $version, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MyImagesTable extends MyImages with TableInfo<$MyImagesTable, MyImage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MyImagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _shortPathMeta =
      const VerificationMeta('shortPath');
  @override
  late final GeneratedColumn<String> shortPath = GeneratedColumn<String>(
      'short_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fullPathMeta =
      const VerificationMeta('fullPath');
  @override
  late final GeneratedColumn<String> fullPath = GeneratedColumn<String>(
      'full_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _localFullPathMeta =
      const VerificationMeta('localFullPath');
  @override
  late final GeneratedColumn<String> localFullPath = GeneratedColumn<String>(
      'local_full_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fileTypeMeta =
      const VerificationMeta('fileType');
  @override
  late final GeneratedColumn<String> fileType = GeneratedColumn<String>(
      'file_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<int> height = GeneratedColumn<int>(
      'height', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _widthMeta = const VerificationMeta('width');
  @override
  late final GeneratedColumn<int> width = GeneratedColumn<int>(
      'width', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _aspectRatioMeta =
      const VerificationMeta('aspectRatio');
  @override
  late final GeneratedColumn<double> aspectRatio = GeneratedColumn<double>(
      'aspect_ratio', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
      'type', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _postIdMeta = const VerificationMeta('postId');
  @override
  late final GeneratedColumn<String> postId = GeneratedColumn<String>(
      'post_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES posts (id)'));
  static const VerificationMeta _locationPostIdMeta =
      const VerificationMeta('locationPostId');
  @override
  late final GeneratedColumn<String> locationPostId = GeneratedColumn<String>(
      'location_post_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES location_posts (id)'));
  static const VerificationMeta _simpleLocationPointIdMeta =
      const VerificationMeta('simpleLocationPointId');
  @override
  late final GeneratedColumn<String> simpleLocationPointId =
      GeneratedColumn<String>('simple_location_point_id', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'REFERENCES simple_location_points (id)'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        shortPath,
        fullPath,
        localFullPath,
        fileType,
        height,
        width,
        aspectRatio,
        type,
        postId,
        locationPostId,
        simpleLocationPointId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'my_images';
  @override
  VerificationContext validateIntegrity(Insertable<MyImage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('short_path')) {
      context.handle(_shortPathMeta,
          shortPath.isAcceptableOrUnknown(data['short_path']!, _shortPathMeta));
    } else if (isInserting) {
      context.missing(_shortPathMeta);
    }
    if (data.containsKey('full_path')) {
      context.handle(_fullPathMeta,
          fullPath.isAcceptableOrUnknown(data['full_path']!, _fullPathMeta));
    } else if (isInserting) {
      context.missing(_fullPathMeta);
    }
    if (data.containsKey('local_full_path')) {
      context.handle(
          _localFullPathMeta,
          localFullPath.isAcceptableOrUnknown(
              data['local_full_path']!, _localFullPathMeta));
    } else if (isInserting) {
      context.missing(_localFullPathMeta);
    }
    if (data.containsKey('file_type')) {
      context.handle(_fileTypeMeta,
          fileType.isAcceptableOrUnknown(data['file_type']!, _fileTypeMeta));
    } else if (isInserting) {
      context.missing(_fileTypeMeta);
    }
    if (data.containsKey('height')) {
      context.handle(_heightMeta,
          height.isAcceptableOrUnknown(data['height']!, _heightMeta));
    } else if (isInserting) {
      context.missing(_heightMeta);
    }
    if (data.containsKey('width')) {
      context.handle(
          _widthMeta, width.isAcceptableOrUnknown(data['width']!, _widthMeta));
    } else if (isInserting) {
      context.missing(_widthMeta);
    }
    if (data.containsKey('aspect_ratio')) {
      context.handle(
          _aspectRatioMeta,
          aspectRatio.isAcceptableOrUnknown(
              data['aspect_ratio']!, _aspectRatioMeta));
    } else if (isInserting) {
      context.missing(_aspectRatioMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('post_id')) {
      context.handle(_postIdMeta,
          postId.isAcceptableOrUnknown(data['post_id']!, _postIdMeta));
    }
    if (data.containsKey('location_post_id')) {
      context.handle(
          _locationPostIdMeta,
          locationPostId.isAcceptableOrUnknown(
              data['location_post_id']!, _locationPostIdMeta));
    }
    if (data.containsKey('simple_location_point_id')) {
      context.handle(
          _simpleLocationPointIdMeta,
          simpleLocationPointId.isAcceptableOrUnknown(
              data['simple_location_point_id']!, _simpleLocationPointIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MyImage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MyImage(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      shortPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}short_path'])!,
      fullPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}full_path'])!,
      localFullPath: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}local_full_path'])!,
      fileType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_type'])!,
      height: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}height'])!,
      width: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}width'])!,
      aspectRatio: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}aspect_ratio'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!,
      postId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}post_id']),
      locationPostId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}location_post_id']),
      simpleLocationPointId: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}simple_location_point_id']),
    );
  }

  @override
  $MyImagesTable createAlias(String alias) {
    return $MyImagesTable(attachedDatabase, alias);
  }
}

class MyImage extends DataClass implements Insertable<MyImage> {
  final String id;
  final String shortPath;
  final String fullPath;
  final String localFullPath;
  final String fileType;
  final int height;
  final int width;
  final double aspectRatio;
  final int type;
  final String? postId;
  final String? locationPostId;
  final String? simpleLocationPointId;
  const MyImage(
      {required this.id,
      required this.shortPath,
      required this.fullPath,
      required this.localFullPath,
      required this.fileType,
      required this.height,
      required this.width,
      required this.aspectRatio,
      required this.type,
      this.postId,
      this.locationPostId,
      this.simpleLocationPointId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['short_path'] = Variable<String>(shortPath);
    map['full_path'] = Variable<String>(fullPath);
    map['local_full_path'] = Variable<String>(localFullPath);
    map['file_type'] = Variable<String>(fileType);
    map['height'] = Variable<int>(height);
    map['width'] = Variable<int>(width);
    map['aspect_ratio'] = Variable<double>(aspectRatio);
    map['type'] = Variable<int>(type);
    if (!nullToAbsent || postId != null) {
      map['post_id'] = Variable<String>(postId);
    }
    if (!nullToAbsent || locationPostId != null) {
      map['location_post_id'] = Variable<String>(locationPostId);
    }
    if (!nullToAbsent || simpleLocationPointId != null) {
      map['simple_location_point_id'] = Variable<String>(simpleLocationPointId);
    }
    return map;
  }

  MyImagesCompanion toCompanion(bool nullToAbsent) {
    return MyImagesCompanion(
      id: Value(id),
      shortPath: Value(shortPath),
      fullPath: Value(fullPath),
      localFullPath: Value(localFullPath),
      fileType: Value(fileType),
      height: Value(height),
      width: Value(width),
      aspectRatio: Value(aspectRatio),
      type: Value(type),
      postId:
          postId == null && nullToAbsent ? const Value.absent() : Value(postId),
      locationPostId: locationPostId == null && nullToAbsent
          ? const Value.absent()
          : Value(locationPostId),
      simpleLocationPointId: simpleLocationPointId == null && nullToAbsent
          ? const Value.absent()
          : Value(simpleLocationPointId),
    );
  }

  factory MyImage.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MyImage(
      id: serializer.fromJson<String>(json['id']),
      shortPath: serializer.fromJson<String>(json['shortPath']),
      fullPath: serializer.fromJson<String>(json['fullPath']),
      localFullPath: serializer.fromJson<String>(json['localFullPath']),
      fileType: serializer.fromJson<String>(json['fileType']),
      height: serializer.fromJson<int>(json['height']),
      width: serializer.fromJson<int>(json['width']),
      aspectRatio: serializer.fromJson<double>(json['aspectRatio']),
      type: serializer.fromJson<int>(json['type']),
      postId: serializer.fromJson<String?>(json['postId']),
      locationPostId: serializer.fromJson<String?>(json['locationPostId']),
      simpleLocationPointId:
          serializer.fromJson<String?>(json['simpleLocationPointId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shortPath': serializer.toJson<String>(shortPath),
      'fullPath': serializer.toJson<String>(fullPath),
      'localFullPath': serializer.toJson<String>(localFullPath),
      'fileType': serializer.toJson<String>(fileType),
      'height': serializer.toJson<int>(height),
      'width': serializer.toJson<int>(width),
      'aspectRatio': serializer.toJson<double>(aspectRatio),
      'type': serializer.toJson<int>(type),
      'postId': serializer.toJson<String?>(postId),
      'locationPostId': serializer.toJson<String?>(locationPostId),
      'simpleLocationPointId':
          serializer.toJson<String?>(simpleLocationPointId),
    };
  }

  MyImage copyWith(
          {String? id,
          String? shortPath,
          String? fullPath,
          String? localFullPath,
          String? fileType,
          int? height,
          int? width,
          double? aspectRatio,
          int? type,
          Value<String?> postId = const Value.absent(),
          Value<String?> locationPostId = const Value.absent(),
          Value<String?> simpleLocationPointId = const Value.absent()}) =>
      MyImage(
        id: id ?? this.id,
        shortPath: shortPath ?? this.shortPath,
        fullPath: fullPath ?? this.fullPath,
        localFullPath: localFullPath ?? this.localFullPath,
        fileType: fileType ?? this.fileType,
        height: height ?? this.height,
        width: width ?? this.width,
        aspectRatio: aspectRatio ?? this.aspectRatio,
        type: type ?? this.type,
        postId: postId.present ? postId.value : this.postId,
        locationPostId:
            locationPostId.present ? locationPostId.value : this.locationPostId,
        simpleLocationPointId: simpleLocationPointId.present
            ? simpleLocationPointId.value
            : this.simpleLocationPointId,
      );
  MyImage copyWithCompanion(MyImagesCompanion data) {
    return MyImage(
      id: data.id.present ? data.id.value : this.id,
      shortPath: data.shortPath.present ? data.shortPath.value : this.shortPath,
      fullPath: data.fullPath.present ? data.fullPath.value : this.fullPath,
      localFullPath: data.localFullPath.present
          ? data.localFullPath.value
          : this.localFullPath,
      fileType: data.fileType.present ? data.fileType.value : this.fileType,
      height: data.height.present ? data.height.value : this.height,
      width: data.width.present ? data.width.value : this.width,
      aspectRatio:
          data.aspectRatio.present ? data.aspectRatio.value : this.aspectRatio,
      type: data.type.present ? data.type.value : this.type,
      postId: data.postId.present ? data.postId.value : this.postId,
      locationPostId: data.locationPostId.present
          ? data.locationPostId.value
          : this.locationPostId,
      simpleLocationPointId: data.simpleLocationPointId.present
          ? data.simpleLocationPointId.value
          : this.simpleLocationPointId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MyImage(')
          ..write('id: $id, ')
          ..write('shortPath: $shortPath, ')
          ..write('fullPath: $fullPath, ')
          ..write('localFullPath: $localFullPath, ')
          ..write('fileType: $fileType, ')
          ..write('height: $height, ')
          ..write('width: $width, ')
          ..write('aspectRatio: $aspectRatio, ')
          ..write('type: $type, ')
          ..write('postId: $postId, ')
          ..write('locationPostId: $locationPostId, ')
          ..write('simpleLocationPointId: $simpleLocationPointId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      shortPath,
      fullPath,
      localFullPath,
      fileType,
      height,
      width,
      aspectRatio,
      type,
      postId,
      locationPostId,
      simpleLocationPointId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MyImage &&
          other.id == this.id &&
          other.shortPath == this.shortPath &&
          other.fullPath == this.fullPath &&
          other.localFullPath == this.localFullPath &&
          other.fileType == this.fileType &&
          other.height == this.height &&
          other.width == this.width &&
          other.aspectRatio == this.aspectRatio &&
          other.type == this.type &&
          other.postId == this.postId &&
          other.locationPostId == this.locationPostId &&
          other.simpleLocationPointId == this.simpleLocationPointId);
}

class MyImagesCompanion extends UpdateCompanion<MyImage> {
  final Value<String> id;
  final Value<String> shortPath;
  final Value<String> fullPath;
  final Value<String> localFullPath;
  final Value<String> fileType;
  final Value<int> height;
  final Value<int> width;
  final Value<double> aspectRatio;
  final Value<int> type;
  final Value<String?> postId;
  final Value<String?> locationPostId;
  final Value<String?> simpleLocationPointId;
  final Value<int> rowid;
  const MyImagesCompanion({
    this.id = const Value.absent(),
    this.shortPath = const Value.absent(),
    this.fullPath = const Value.absent(),
    this.localFullPath = const Value.absent(),
    this.fileType = const Value.absent(),
    this.height = const Value.absent(),
    this.width = const Value.absent(),
    this.aspectRatio = const Value.absent(),
    this.type = const Value.absent(),
    this.postId = const Value.absent(),
    this.locationPostId = const Value.absent(),
    this.simpleLocationPointId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MyImagesCompanion.insert({
    required String id,
    required String shortPath,
    required String fullPath,
    required String localFullPath,
    required String fileType,
    required int height,
    required int width,
    required double aspectRatio,
    required int type,
    this.postId = const Value.absent(),
    this.locationPostId = const Value.absent(),
    this.simpleLocationPointId = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        shortPath = Value(shortPath),
        fullPath = Value(fullPath),
        localFullPath = Value(localFullPath),
        fileType = Value(fileType),
        height = Value(height),
        width = Value(width),
        aspectRatio = Value(aspectRatio),
        type = Value(type);
  static Insertable<MyImage> custom({
    Expression<String>? id,
    Expression<String>? shortPath,
    Expression<String>? fullPath,
    Expression<String>? localFullPath,
    Expression<String>? fileType,
    Expression<int>? height,
    Expression<int>? width,
    Expression<double>? aspectRatio,
    Expression<int>? type,
    Expression<String>? postId,
    Expression<String>? locationPostId,
    Expression<String>? simpleLocationPointId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shortPath != null) 'short_path': shortPath,
      if (fullPath != null) 'full_path': fullPath,
      if (localFullPath != null) 'local_full_path': localFullPath,
      if (fileType != null) 'file_type': fileType,
      if (height != null) 'height': height,
      if (width != null) 'width': width,
      if (aspectRatio != null) 'aspect_ratio': aspectRatio,
      if (type != null) 'type': type,
      if (postId != null) 'post_id': postId,
      if (locationPostId != null) 'location_post_id': locationPostId,
      if (simpleLocationPointId != null)
        'simple_location_point_id': simpleLocationPointId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MyImagesCompanion copyWith(
      {Value<String>? id,
      Value<String>? shortPath,
      Value<String>? fullPath,
      Value<String>? localFullPath,
      Value<String>? fileType,
      Value<int>? height,
      Value<int>? width,
      Value<double>? aspectRatio,
      Value<int>? type,
      Value<String?>? postId,
      Value<String?>? locationPostId,
      Value<String?>? simpleLocationPointId,
      Value<int>? rowid}) {
    return MyImagesCompanion(
      id: id ?? this.id,
      shortPath: shortPath ?? this.shortPath,
      fullPath: fullPath ?? this.fullPath,
      localFullPath: localFullPath ?? this.localFullPath,
      fileType: fileType ?? this.fileType,
      height: height ?? this.height,
      width: width ?? this.width,
      aspectRatio: aspectRatio ?? this.aspectRatio,
      type: type ?? this.type,
      postId: postId ?? this.postId,
      locationPostId: locationPostId ?? this.locationPostId,
      simpleLocationPointId:
          simpleLocationPointId ?? this.simpleLocationPointId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shortPath.present) {
      map['short_path'] = Variable<String>(shortPath.value);
    }
    if (fullPath.present) {
      map['full_path'] = Variable<String>(fullPath.value);
    }
    if (localFullPath.present) {
      map['local_full_path'] = Variable<String>(localFullPath.value);
    }
    if (fileType.present) {
      map['file_type'] = Variable<String>(fileType.value);
    }
    if (height.present) {
      map['height'] = Variable<int>(height.value);
    }
    if (width.present) {
      map['width'] = Variable<int>(width.value);
    }
    if (aspectRatio.present) {
      map['aspect_ratio'] = Variable<double>(aspectRatio.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (postId.present) {
      map['post_id'] = Variable<String>(postId.value);
    }
    if (locationPostId.present) {
      map['location_post_id'] = Variable<String>(locationPostId.value);
    }
    if (simpleLocationPointId.present) {
      map['simple_location_point_id'] =
          Variable<String>(simpleLocationPointId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MyImagesCompanion(')
          ..write('id: $id, ')
          ..write('shortPath: $shortPath, ')
          ..write('fullPath: $fullPath, ')
          ..write('localFullPath: $localFullPath, ')
          ..write('fileType: $fileType, ')
          ..write('height: $height, ')
          ..write('width: $width, ')
          ..write('aspectRatio: $aspectRatio, ')
          ..write('type: $type, ')
          ..write('postId: $postId, ')
          ..write('locationPostId: $locationPostId, ')
          ..write('simpleLocationPointId: $simpleLocationPointId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDbContext extends GeneratedDatabase {
  _$MyDbContext(QueryExecutor e) : super(e);
  $MyDbContextManager get managers => $MyDbContextManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $PostsTable posts = $PostsTable(this);
  late final $SimpleLocationPointsTable simpleLocationPoints =
      $SimpleLocationPointsTable(this);
  late final $LocationPostsTable locationPosts = $LocationPostsTable(this);
  late final $MyImagesTable myImages = $MyImagesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [users, posts, simpleLocationPoints, locationPosts, myImages];
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  required String id,
  required String username,
  required String displayName,
  required DateTime birthDate,
  required String status,
  required DateTime lastSeen,
  required DateTime dataCreationTime,
  required String currentUser,
  required bool isSimple,
  required bool isTempRecommendation,
  Value<int> rowid,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<String> id,
  Value<String> username,
  Value<String> displayName,
  Value<DateTime> birthDate,
  Value<String> status,
  Value<DateTime> lastSeen,
  Value<DateTime> dataCreationTime,
  Value<String> currentUser,
  Value<bool> isSimple,
  Value<bool> isTempRecommendation,
  Value<int> rowid,
});

final class $$UsersTableReferences
    extends BaseReferences<_$MyDbContext, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PostsTable, List<Post>> _postsRefsTable(
          _$MyDbContext db) =>
      MultiTypedResultKey.fromTable(db.posts,
          aliasName: $_aliasNameGenerator(db.users.id, db.posts.ownerId));

  $$PostsTableProcessedTableManager get postsRefs {
    final manager = $$PostsTableTableManager($_db, $_db.posts)
        .filter((f) => f.ownerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_postsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$UsersTableFilterComposer extends Composer<_$MyDbContext, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get birthDate => $composableBuilder(
      column: $table.birthDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSeen => $composableBuilder(
      column: $table.lastSeen, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataCreationTime => $composableBuilder(
      column: $table.dataCreationTime,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currentUser => $composableBuilder(
      column: $table.currentUser, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSimple => $composableBuilder(
      column: $table.isSimple, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isTempRecommendation => $composableBuilder(
      column: $table.isTempRecommendation,
      builder: (column) => ColumnFilters(column));

  Expression<bool> postsRefs(
      Expression<bool> Function($$PostsTableFilterComposer f) f) {
    final $$PostsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.posts,
        getReferencedColumn: (t) => t.ownerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PostsTableFilterComposer(
              $db: $db,
              $table: $db.posts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$MyDbContext, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get birthDate => $composableBuilder(
      column: $table.birthDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSeen => $composableBuilder(
      column: $table.lastSeen, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataCreationTime => $composableBuilder(
      column: $table.dataCreationTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currentUser => $composableBuilder(
      column: $table.currentUser, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSimple => $composableBuilder(
      column: $table.isSimple, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isTempRecommendation => $composableBuilder(
      column: $table.isTempRecommendation,
      builder: (column) => ColumnOrderings(column));
}

class $$UsersTableAnnotationComposer
    extends Composer<_$MyDbContext, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => column);

  GeneratedColumn<DateTime> get birthDate =>
      $composableBuilder(column: $table.birthDate, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSeen =>
      $composableBuilder(column: $table.lastSeen, builder: (column) => column);

  GeneratedColumn<DateTime> get dataCreationTime => $composableBuilder(
      column: $table.dataCreationTime, builder: (column) => column);

  GeneratedColumn<String> get currentUser => $composableBuilder(
      column: $table.currentUser, builder: (column) => column);

  GeneratedColumn<bool> get isSimple =>
      $composableBuilder(column: $table.isSimple, builder: (column) => column);

  GeneratedColumn<bool> get isTempRecommendation => $composableBuilder(
      column: $table.isTempRecommendation, builder: (column) => column);

  Expression<T> postsRefs<T extends Object>(
      Expression<T> Function($$PostsTableAnnotationComposer a) f) {
    final $$PostsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.posts,
        getReferencedColumn: (t) => t.ownerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PostsTableAnnotationComposer(
              $db: $db,
              $table: $db.posts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsersTableTableManager extends RootTableManager<
    _$MyDbContext,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, $$UsersTableReferences),
    User,
    PrefetchHooks Function({bool postsRefs})> {
  $$UsersTableTableManager(_$MyDbContext db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> username = const Value.absent(),
            Value<String> displayName = const Value.absent(),
            Value<DateTime> birthDate = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> lastSeen = const Value.absent(),
            Value<DateTime> dataCreationTime = const Value.absent(),
            Value<String> currentUser = const Value.absent(),
            Value<bool> isSimple = const Value.absent(),
            Value<bool> isTempRecommendation = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UsersCompanion(
            id: id,
            username: username,
            displayName: displayName,
            birthDate: birthDate,
            status: status,
            lastSeen: lastSeen,
            dataCreationTime: dataCreationTime,
            currentUser: currentUser,
            isSimple: isSimple,
            isTempRecommendation: isTempRecommendation,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String username,
            required String displayName,
            required DateTime birthDate,
            required String status,
            required DateTime lastSeen,
            required DateTime dataCreationTime,
            required String currentUser,
            required bool isSimple,
            required bool isTempRecommendation,
            Value<int> rowid = const Value.absent(),
          }) =>
              UsersCompanion.insert(
            id: id,
            username: username,
            displayName: displayName,
            birthDate: birthDate,
            status: status,
            lastSeen: lastSeen,
            dataCreationTime: dataCreationTime,
            currentUser: currentUser,
            isSimple: isSimple,
            isTempRecommendation: isTempRecommendation,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$UsersTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({postsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (postsRefs) db.posts],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (postsRefs)
                    await $_getPrefetchedData<User, $UsersTable, Post>(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._postsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0).postsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.ownerId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$UsersTableProcessedTableManager = ProcessedTableManager<
    _$MyDbContext,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, $$UsersTableReferences),
    User,
    PrefetchHooks Function({bool postsRefs})>;
typedef $$PostsTableCreateCompanionBuilder = PostsCompanion Function({
  required String id,
  required String ownerId,
  required DateTime dataCreationTime,
  required int version,
  Value<int> rowid,
});
typedef $$PostsTableUpdateCompanionBuilder = PostsCompanion Function({
  Value<String> id,
  Value<String> ownerId,
  Value<DateTime> dataCreationTime,
  Value<int> version,
  Value<int> rowid,
});

final class $$PostsTableReferences
    extends BaseReferences<_$MyDbContext, $PostsTable, Post> {
  $$PostsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _ownerIdTable(_$MyDbContext db) =>
      db.users.createAlias($_aliasNameGenerator(db.posts.ownerId, db.users.id));

  $$UsersTableProcessedTableManager get ownerId {
    final $_column = $_itemColumn<String>('owner_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ownerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$MyImagesTable, List<MyImage>> _myImagesRefsTable(
          _$MyDbContext db) =>
      MultiTypedResultKey.fromTable(db.myImages,
          aliasName: $_aliasNameGenerator(db.posts.id, db.myImages.postId));

  $$MyImagesTableProcessedTableManager get myImagesRefs {
    final manager = $$MyImagesTableTableManager($_db, $_db.myImages)
        .filter((f) => f.postId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_myImagesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PostsTableFilterComposer extends Composer<_$MyDbContext, $PostsTable> {
  $$PostsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataCreationTime => $composableBuilder(
      column: $table.dataCreationTime,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnFilters(column));

  $$UsersTableFilterComposer get ownerId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ownerId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> myImagesRefs(
      Expression<bool> Function($$MyImagesTableFilterComposer f) f) {
    final $$MyImagesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.myImages,
        getReferencedColumn: (t) => t.postId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MyImagesTableFilterComposer(
              $db: $db,
              $table: $db.myImages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PostsTableOrderingComposer
    extends Composer<_$MyDbContext, $PostsTable> {
  $$PostsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataCreationTime => $composableBuilder(
      column: $table.dataCreationTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnOrderings(column));

  $$UsersTableOrderingComposer get ownerId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ownerId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PostsTableAnnotationComposer
    extends Composer<_$MyDbContext, $PostsTable> {
  $$PostsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get dataCreationTime => $composableBuilder(
      column: $table.dataCreationTime, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  $$UsersTableAnnotationComposer get ownerId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ownerId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> myImagesRefs<T extends Object>(
      Expression<T> Function($$MyImagesTableAnnotationComposer a) f) {
    final $$MyImagesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.myImages,
        getReferencedColumn: (t) => t.postId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MyImagesTableAnnotationComposer(
              $db: $db,
              $table: $db.myImages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PostsTableTableManager extends RootTableManager<
    _$MyDbContext,
    $PostsTable,
    Post,
    $$PostsTableFilterComposer,
    $$PostsTableOrderingComposer,
    $$PostsTableAnnotationComposer,
    $$PostsTableCreateCompanionBuilder,
    $$PostsTableUpdateCompanionBuilder,
    (Post, $$PostsTableReferences),
    Post,
    PrefetchHooks Function({bool ownerId, bool myImagesRefs})> {
  $$PostsTableTableManager(_$MyDbContext db, $PostsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PostsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PostsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PostsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> ownerId = const Value.absent(),
            Value<DateTime> dataCreationTime = const Value.absent(),
            Value<int> version = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PostsCompanion(
            id: id,
            ownerId: ownerId,
            dataCreationTime: dataCreationTime,
            version: version,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String ownerId,
            required DateTime dataCreationTime,
            required int version,
            Value<int> rowid = const Value.absent(),
          }) =>
              PostsCompanion.insert(
            id: id,
            ownerId: ownerId,
            dataCreationTime: dataCreationTime,
            version: version,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$PostsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({ownerId = false, myImagesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (myImagesRefs) db.myImages],
              addJoins: <
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
                      dynamic>>(state) {
                if (ownerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.ownerId,
                    referencedTable: $$PostsTableReferences._ownerIdTable(db),
                    referencedColumn:
                        $$PostsTableReferences._ownerIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (myImagesRefs)
                    await $_getPrefetchedData<Post, $PostsTable, MyImage>(
                        currentTable: table,
                        referencedTable:
                            $$PostsTableReferences._myImagesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PostsTableReferences(db, table, p0).myImagesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.postId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PostsTableProcessedTableManager = ProcessedTableManager<
    _$MyDbContext,
    $PostsTable,
    Post,
    $$PostsTableFilterComposer,
    $$PostsTableOrderingComposer,
    $$PostsTableAnnotationComposer,
    $$PostsTableCreateCompanionBuilder,
    $$PostsTableUpdateCompanionBuilder,
    (Post, $$PostsTableReferences),
    Post,
    PrefetchHooks Function({bool ownerId, bool myImagesRefs})>;
typedef $$SimpleLocationPointsTableCreateCompanionBuilder
    = SimpleLocationPointsCompanion Function({
  required String id,
  Value<String?> postId,
  required double longitude,
  required double latitude,
  required int type,
  required int zoomLevel,
  required int childCount,
  Value<String?> imageId,
  required String currentUser,
  Value<int> rowid,
});
typedef $$SimpleLocationPointsTableUpdateCompanionBuilder
    = SimpleLocationPointsCompanion Function({
  Value<String> id,
  Value<String?> postId,
  Value<double> longitude,
  Value<double> latitude,
  Value<int> type,
  Value<int> zoomLevel,
  Value<int> childCount,
  Value<String?> imageId,
  Value<String> currentUser,
  Value<int> rowid,
});

final class $$SimpleLocationPointsTableReferences extends BaseReferences<
    _$MyDbContext, $SimpleLocationPointsTable, SimpleLocationPoint> {
  $$SimpleLocationPointsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$LocationPostsTable, List<LocationPost>>
      _locationPostsRefsTable(_$MyDbContext db) =>
          MultiTypedResultKey.fromTable(db.locationPosts,
              aliasName: $_aliasNameGenerator(
                  db.simpleLocationPoints.id, db.locationPosts.pointId));

  $$LocationPostsTableProcessedTableManager get locationPostsRefs {
    final manager = $$LocationPostsTableTableManager($_db, $_db.locationPosts)
        .filter((f) => f.pointId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_locationPostsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$MyImagesTable, List<MyImage>> _myImagesRefsTable(
          _$MyDbContext db) =>
      MultiTypedResultKey.fromTable(db.myImages,
          aliasName: $_aliasNameGenerator(
              db.simpleLocationPoints.id, db.myImages.simpleLocationPointId));

  $$MyImagesTableProcessedTableManager get myImagesRefs {
    final manager = $$MyImagesTableTableManager($_db, $_db.myImages).filter(
        (f) =>
            f.simpleLocationPointId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_myImagesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SimpleLocationPointsTableFilterComposer
    extends Composer<_$MyDbContext, $SimpleLocationPointsTable> {
  $$SimpleLocationPointsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get postId => $composableBuilder(
      column: $table.postId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get zoomLevel => $composableBuilder(
      column: $table.zoomLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get childCount => $composableBuilder(
      column: $table.childCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageId => $composableBuilder(
      column: $table.imageId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currentUser => $composableBuilder(
      column: $table.currentUser, builder: (column) => ColumnFilters(column));

  Expression<bool> locationPostsRefs(
      Expression<bool> Function($$LocationPostsTableFilterComposer f) f) {
    final $$LocationPostsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.locationPosts,
        getReferencedColumn: (t) => t.pointId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocationPostsTableFilterComposer(
              $db: $db,
              $table: $db.locationPosts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> myImagesRefs(
      Expression<bool> Function($$MyImagesTableFilterComposer f) f) {
    final $$MyImagesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.myImages,
        getReferencedColumn: (t) => t.simpleLocationPointId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MyImagesTableFilterComposer(
              $db: $db,
              $table: $db.myImages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SimpleLocationPointsTableOrderingComposer
    extends Composer<_$MyDbContext, $SimpleLocationPointsTable> {
  $$SimpleLocationPointsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get postId => $composableBuilder(
      column: $table.postId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get zoomLevel => $composableBuilder(
      column: $table.zoomLevel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get childCount => $composableBuilder(
      column: $table.childCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageId => $composableBuilder(
      column: $table.imageId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currentUser => $composableBuilder(
      column: $table.currentUser, builder: (column) => ColumnOrderings(column));
}

class $$SimpleLocationPointsTableAnnotationComposer
    extends Composer<_$MyDbContext, $SimpleLocationPointsTable> {
  $$SimpleLocationPointsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get postId =>
      $composableBuilder(column: $table.postId, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get zoomLevel =>
      $composableBuilder(column: $table.zoomLevel, builder: (column) => column);

  GeneratedColumn<int> get childCount => $composableBuilder(
      column: $table.childCount, builder: (column) => column);

  GeneratedColumn<String> get imageId =>
      $composableBuilder(column: $table.imageId, builder: (column) => column);

  GeneratedColumn<String> get currentUser => $composableBuilder(
      column: $table.currentUser, builder: (column) => column);

  Expression<T> locationPostsRefs<T extends Object>(
      Expression<T> Function($$LocationPostsTableAnnotationComposer a) f) {
    final $$LocationPostsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.locationPosts,
        getReferencedColumn: (t) => t.pointId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocationPostsTableAnnotationComposer(
              $db: $db,
              $table: $db.locationPosts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> myImagesRefs<T extends Object>(
      Expression<T> Function($$MyImagesTableAnnotationComposer a) f) {
    final $$MyImagesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.myImages,
        getReferencedColumn: (t) => t.simpleLocationPointId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MyImagesTableAnnotationComposer(
              $db: $db,
              $table: $db.myImages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SimpleLocationPointsTableTableManager extends RootTableManager<
    _$MyDbContext,
    $SimpleLocationPointsTable,
    SimpleLocationPoint,
    $$SimpleLocationPointsTableFilterComposer,
    $$SimpleLocationPointsTableOrderingComposer,
    $$SimpleLocationPointsTableAnnotationComposer,
    $$SimpleLocationPointsTableCreateCompanionBuilder,
    $$SimpleLocationPointsTableUpdateCompanionBuilder,
    (SimpleLocationPoint, $$SimpleLocationPointsTableReferences),
    SimpleLocationPoint,
    PrefetchHooks Function({bool locationPostsRefs, bool myImagesRefs})> {
  $$SimpleLocationPointsTableTableManager(
      _$MyDbContext db, $SimpleLocationPointsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SimpleLocationPointsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SimpleLocationPointsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SimpleLocationPointsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> postId = const Value.absent(),
            Value<double> longitude = const Value.absent(),
            Value<double> latitude = const Value.absent(),
            Value<int> type = const Value.absent(),
            Value<int> zoomLevel = const Value.absent(),
            Value<int> childCount = const Value.absent(),
            Value<String?> imageId = const Value.absent(),
            Value<String> currentUser = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SimpleLocationPointsCompanion(
            id: id,
            postId: postId,
            longitude: longitude,
            latitude: latitude,
            type: type,
            zoomLevel: zoomLevel,
            childCount: childCount,
            imageId: imageId,
            currentUser: currentUser,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> postId = const Value.absent(),
            required double longitude,
            required double latitude,
            required int type,
            required int zoomLevel,
            required int childCount,
            Value<String?> imageId = const Value.absent(),
            required String currentUser,
            Value<int> rowid = const Value.absent(),
          }) =>
              SimpleLocationPointsCompanion.insert(
            id: id,
            postId: postId,
            longitude: longitude,
            latitude: latitude,
            type: type,
            zoomLevel: zoomLevel,
            childCount: childCount,
            imageId: imageId,
            currentUser: currentUser,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SimpleLocationPointsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {locationPostsRefs = false, myImagesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (locationPostsRefs) db.locationPosts,
                if (myImagesRefs) db.myImages
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (locationPostsRefs)
                    await $_getPrefetchedData<SimpleLocationPoint,
                            $SimpleLocationPointsTable, LocationPost>(
                        currentTable: table,
                        referencedTable: $$SimpleLocationPointsTableReferences
                            ._locationPostsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SimpleLocationPointsTableReferences(db, table, p0)
                                .locationPostsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.pointId == item.id),
                        typedResults: items),
                  if (myImagesRefs)
                    await $_getPrefetchedData<SimpleLocationPoint,
                            $SimpleLocationPointsTable, MyImage>(
                        currentTable: table,
                        referencedTable: $$SimpleLocationPointsTableReferences
                            ._myImagesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SimpleLocationPointsTableReferences(db, table, p0)
                                .myImagesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems.where(
                                (e) => e.simpleLocationPointId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$SimpleLocationPointsTableProcessedTableManager
    = ProcessedTableManager<
        _$MyDbContext,
        $SimpleLocationPointsTable,
        SimpleLocationPoint,
        $$SimpleLocationPointsTableFilterComposer,
        $$SimpleLocationPointsTableOrderingComposer,
        $$SimpleLocationPointsTableAnnotationComposer,
        $$SimpleLocationPointsTableCreateCompanionBuilder,
        $$SimpleLocationPointsTableUpdateCompanionBuilder,
        (SimpleLocationPoint, $$SimpleLocationPointsTableReferences),
        SimpleLocationPoint,
        PrefetchHooks Function({bool locationPostsRefs, bool myImagesRefs})>;
typedef $$LocationPostsTableCreateCompanionBuilder = LocationPostsCompanion
    Function({
  required String id,
  Value<String?> locationId,
  required DateTime eventTime,
  required String description,
  required String ownerDisplayName,
  required String pointId,
  required String smallFirstImageId,
  required DateTime dataCreationTime,
  required int notificationId,
  required int version,
  Value<int> rowid,
});
typedef $$LocationPostsTableUpdateCompanionBuilder = LocationPostsCompanion
    Function({
  Value<String> id,
  Value<String?> locationId,
  Value<DateTime> eventTime,
  Value<String> description,
  Value<String> ownerDisplayName,
  Value<String> pointId,
  Value<String> smallFirstImageId,
  Value<DateTime> dataCreationTime,
  Value<int> notificationId,
  Value<int> version,
  Value<int> rowid,
});

final class $$LocationPostsTableReferences
    extends BaseReferences<_$MyDbContext, $LocationPostsTable, LocationPost> {
  $$LocationPostsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $SimpleLocationPointsTable _pointIdTable(_$MyDbContext db) =>
      db.simpleLocationPoints.createAlias($_aliasNameGenerator(
          db.locationPosts.pointId, db.simpleLocationPoints.id));

  $$SimpleLocationPointsTableProcessedTableManager get pointId {
    final $_column = $_itemColumn<String>('point_id')!;

    final manager =
        $$SimpleLocationPointsTableTableManager($_db, $_db.simpleLocationPoints)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pointIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$MyImagesTable, List<MyImage>> _myImagesRefsTable(
          _$MyDbContext db) =>
      MultiTypedResultKey.fromTable(db.myImages,
          aliasName: $_aliasNameGenerator(
              db.locationPosts.id, db.myImages.locationPostId));

  $$MyImagesTableProcessedTableManager get myImagesRefs {
    final manager = $$MyImagesTableTableManager($_db, $_db.myImages).filter(
        (f) => f.locationPostId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_myImagesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$LocationPostsTableFilterComposer
    extends Composer<_$MyDbContext, $LocationPostsTable> {
  $$LocationPostsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get locationId => $composableBuilder(
      column: $table.locationId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get eventTime => $composableBuilder(
      column: $table.eventTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ownerDisplayName => $composableBuilder(
      column: $table.ownerDisplayName,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get smallFirstImageId => $composableBuilder(
      column: $table.smallFirstImageId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dataCreationTime => $composableBuilder(
      column: $table.dataCreationTime,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get notificationId => $composableBuilder(
      column: $table.notificationId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnFilters(column));

  $$SimpleLocationPointsTableFilterComposer get pointId {
    final $$SimpleLocationPointsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.pointId,
        referencedTable: $db.simpleLocationPoints,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SimpleLocationPointsTableFilterComposer(
              $db: $db,
              $table: $db.simpleLocationPoints,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> myImagesRefs(
      Expression<bool> Function($$MyImagesTableFilterComposer f) f) {
    final $$MyImagesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.myImages,
        getReferencedColumn: (t) => t.locationPostId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MyImagesTableFilterComposer(
              $db: $db,
              $table: $db.myImages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LocationPostsTableOrderingComposer
    extends Composer<_$MyDbContext, $LocationPostsTable> {
  $$LocationPostsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get locationId => $composableBuilder(
      column: $table.locationId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get eventTime => $composableBuilder(
      column: $table.eventTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ownerDisplayName => $composableBuilder(
      column: $table.ownerDisplayName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get smallFirstImageId => $composableBuilder(
      column: $table.smallFirstImageId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dataCreationTime => $composableBuilder(
      column: $table.dataCreationTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get notificationId => $composableBuilder(
      column: $table.notificationId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnOrderings(column));

  $$SimpleLocationPointsTableOrderingComposer get pointId {
    final $$SimpleLocationPointsTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.pointId,
            referencedTable: $db.simpleLocationPoints,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SimpleLocationPointsTableOrderingComposer(
                  $db: $db,
                  $table: $db.simpleLocationPoints,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$LocationPostsTableAnnotationComposer
    extends Composer<_$MyDbContext, $LocationPostsTable> {
  $$LocationPostsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get locationId => $composableBuilder(
      column: $table.locationId, builder: (column) => column);

  GeneratedColumn<DateTime> get eventTime =>
      $composableBuilder(column: $table.eventTime, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get ownerDisplayName => $composableBuilder(
      column: $table.ownerDisplayName, builder: (column) => column);

  GeneratedColumn<String> get smallFirstImageId => $composableBuilder(
      column: $table.smallFirstImageId, builder: (column) => column);

  GeneratedColumn<DateTime> get dataCreationTime => $composableBuilder(
      column: $table.dataCreationTime, builder: (column) => column);

  GeneratedColumn<int> get notificationId => $composableBuilder(
      column: $table.notificationId, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  $$SimpleLocationPointsTableAnnotationComposer get pointId {
    final $$SimpleLocationPointsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.pointId,
            referencedTable: $db.simpleLocationPoints,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SimpleLocationPointsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.simpleLocationPoints,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  Expression<T> myImagesRefs<T extends Object>(
      Expression<T> Function($$MyImagesTableAnnotationComposer a) f) {
    final $$MyImagesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.myImages,
        getReferencedColumn: (t) => t.locationPostId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MyImagesTableAnnotationComposer(
              $db: $db,
              $table: $db.myImages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LocationPostsTableTableManager extends RootTableManager<
    _$MyDbContext,
    $LocationPostsTable,
    LocationPost,
    $$LocationPostsTableFilterComposer,
    $$LocationPostsTableOrderingComposer,
    $$LocationPostsTableAnnotationComposer,
    $$LocationPostsTableCreateCompanionBuilder,
    $$LocationPostsTableUpdateCompanionBuilder,
    (LocationPost, $$LocationPostsTableReferences),
    LocationPost,
    PrefetchHooks Function({bool pointId, bool myImagesRefs})> {
  $$LocationPostsTableTableManager(_$MyDbContext db, $LocationPostsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocationPostsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocationPostsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocationPostsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> locationId = const Value.absent(),
            Value<DateTime> eventTime = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> ownerDisplayName = const Value.absent(),
            Value<String> pointId = const Value.absent(),
            Value<String> smallFirstImageId = const Value.absent(),
            Value<DateTime> dataCreationTime = const Value.absent(),
            Value<int> notificationId = const Value.absent(),
            Value<int> version = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocationPostsCompanion(
            id: id,
            locationId: locationId,
            eventTime: eventTime,
            description: description,
            ownerDisplayName: ownerDisplayName,
            pointId: pointId,
            smallFirstImageId: smallFirstImageId,
            dataCreationTime: dataCreationTime,
            notificationId: notificationId,
            version: version,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> locationId = const Value.absent(),
            required DateTime eventTime,
            required String description,
            required String ownerDisplayName,
            required String pointId,
            required String smallFirstImageId,
            required DateTime dataCreationTime,
            required int notificationId,
            required int version,
            Value<int> rowid = const Value.absent(),
          }) =>
              LocationPostsCompanion.insert(
            id: id,
            locationId: locationId,
            eventTime: eventTime,
            description: description,
            ownerDisplayName: ownerDisplayName,
            pointId: pointId,
            smallFirstImageId: smallFirstImageId,
            dataCreationTime: dataCreationTime,
            notificationId: notificationId,
            version: version,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LocationPostsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({pointId = false, myImagesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (myImagesRefs) db.myImages],
              addJoins: <
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
                      dynamic>>(state) {
                if (pointId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.pointId,
                    referencedTable:
                        $$LocationPostsTableReferences._pointIdTable(db),
                    referencedColumn:
                        $$LocationPostsTableReferences._pointIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (myImagesRefs)
                    await $_getPrefetchedData<LocationPost, $LocationPostsTable,
                            MyImage>(
                        currentTable: table,
                        referencedTable: $$LocationPostsTableReferences
                            ._myImagesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LocationPostsTableReferences(db, table, p0)
                                .myImagesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.locationPostId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$LocationPostsTableProcessedTableManager = ProcessedTableManager<
    _$MyDbContext,
    $LocationPostsTable,
    LocationPost,
    $$LocationPostsTableFilterComposer,
    $$LocationPostsTableOrderingComposer,
    $$LocationPostsTableAnnotationComposer,
    $$LocationPostsTableCreateCompanionBuilder,
    $$LocationPostsTableUpdateCompanionBuilder,
    (LocationPost, $$LocationPostsTableReferences),
    LocationPost,
    PrefetchHooks Function({bool pointId, bool myImagesRefs})>;
typedef $$MyImagesTableCreateCompanionBuilder = MyImagesCompanion Function({
  required String id,
  required String shortPath,
  required String fullPath,
  required String localFullPath,
  required String fileType,
  required int height,
  required int width,
  required double aspectRatio,
  required int type,
  Value<String?> postId,
  Value<String?> locationPostId,
  Value<String?> simpleLocationPointId,
  Value<int> rowid,
});
typedef $$MyImagesTableUpdateCompanionBuilder = MyImagesCompanion Function({
  Value<String> id,
  Value<String> shortPath,
  Value<String> fullPath,
  Value<String> localFullPath,
  Value<String> fileType,
  Value<int> height,
  Value<int> width,
  Value<double> aspectRatio,
  Value<int> type,
  Value<String?> postId,
  Value<String?> locationPostId,
  Value<String?> simpleLocationPointId,
  Value<int> rowid,
});

final class $$MyImagesTableReferences
    extends BaseReferences<_$MyDbContext, $MyImagesTable, MyImage> {
  $$MyImagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PostsTable _postIdTable(_$MyDbContext db) => db.posts
      .createAlias($_aliasNameGenerator(db.myImages.postId, db.posts.id));

  $$PostsTableProcessedTableManager? get postId {
    final $_column = $_itemColumn<String>('post_id');
    if ($_column == null) return null;
    final manager = $$PostsTableTableManager($_db, $_db.posts)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_postIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $LocationPostsTable _locationPostIdTable(_$MyDbContext db) =>
      db.locationPosts.createAlias($_aliasNameGenerator(
          db.myImages.locationPostId, db.locationPosts.id));

  $$LocationPostsTableProcessedTableManager? get locationPostId {
    final $_column = $_itemColumn<String>('location_post_id');
    if ($_column == null) return null;
    final manager = $$LocationPostsTableTableManager($_db, $_db.locationPosts)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_locationPostIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $SimpleLocationPointsTable _simpleLocationPointIdTable(
          _$MyDbContext db) =>
      db.simpleLocationPoints.createAlias($_aliasNameGenerator(
          db.myImages.simpleLocationPointId, db.simpleLocationPoints.id));

  $$SimpleLocationPointsTableProcessedTableManager? get simpleLocationPointId {
    final $_column = $_itemColumn<String>('simple_location_point_id');
    if ($_column == null) return null;
    final manager =
        $$SimpleLocationPointsTableTableManager($_db, $_db.simpleLocationPoints)
            .filter((f) => f.id.sqlEquals($_column));
    final item =
        $_typedResult.readTableOrNull(_simpleLocationPointIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$MyImagesTableFilterComposer
    extends Composer<_$MyDbContext, $MyImagesTable> {
  $$MyImagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get shortPath => $composableBuilder(
      column: $table.shortPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fullPath => $composableBuilder(
      column: $table.fullPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get localFullPath => $composableBuilder(
      column: $table.localFullPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fileType => $composableBuilder(
      column: $table.fileType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get height => $composableBuilder(
      column: $table.height, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get width => $composableBuilder(
      column: $table.width, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get aspectRatio => $composableBuilder(
      column: $table.aspectRatio, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  $$PostsTableFilterComposer get postId {
    final $$PostsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.postId,
        referencedTable: $db.posts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PostsTableFilterComposer(
              $db: $db,
              $table: $db.posts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LocationPostsTableFilterComposer get locationPostId {
    final $$LocationPostsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.locationPostId,
        referencedTable: $db.locationPosts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocationPostsTableFilterComposer(
              $db: $db,
              $table: $db.locationPosts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SimpleLocationPointsTableFilterComposer get simpleLocationPointId {
    final $$SimpleLocationPointsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.simpleLocationPointId,
        referencedTable: $db.simpleLocationPoints,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SimpleLocationPointsTableFilterComposer(
              $db: $db,
              $table: $db.simpleLocationPoints,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MyImagesTableOrderingComposer
    extends Composer<_$MyDbContext, $MyImagesTable> {
  $$MyImagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get shortPath => $composableBuilder(
      column: $table.shortPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fullPath => $composableBuilder(
      column: $table.fullPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get localFullPath => $composableBuilder(
      column: $table.localFullPath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fileType => $composableBuilder(
      column: $table.fileType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get height => $composableBuilder(
      column: $table.height, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get width => $composableBuilder(
      column: $table.width, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get aspectRatio => $composableBuilder(
      column: $table.aspectRatio, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  $$PostsTableOrderingComposer get postId {
    final $$PostsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.postId,
        referencedTable: $db.posts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PostsTableOrderingComposer(
              $db: $db,
              $table: $db.posts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LocationPostsTableOrderingComposer get locationPostId {
    final $$LocationPostsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.locationPostId,
        referencedTable: $db.locationPosts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocationPostsTableOrderingComposer(
              $db: $db,
              $table: $db.locationPosts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SimpleLocationPointsTableOrderingComposer get simpleLocationPointId {
    final $$SimpleLocationPointsTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.simpleLocationPointId,
            referencedTable: $db.simpleLocationPoints,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SimpleLocationPointsTableOrderingComposer(
                  $db: $db,
                  $table: $db.simpleLocationPoints,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$MyImagesTableAnnotationComposer
    extends Composer<_$MyDbContext, $MyImagesTable> {
  $$MyImagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get shortPath =>
      $composableBuilder(column: $table.shortPath, builder: (column) => column);

  GeneratedColumn<String> get fullPath =>
      $composableBuilder(column: $table.fullPath, builder: (column) => column);

  GeneratedColumn<String> get localFullPath => $composableBuilder(
      column: $table.localFullPath, builder: (column) => column);

  GeneratedColumn<String> get fileType =>
      $composableBuilder(column: $table.fileType, builder: (column) => column);

  GeneratedColumn<int> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<int> get width =>
      $composableBuilder(column: $table.width, builder: (column) => column);

  GeneratedColumn<double> get aspectRatio => $composableBuilder(
      column: $table.aspectRatio, builder: (column) => column);

  GeneratedColumn<int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  $$PostsTableAnnotationComposer get postId {
    final $$PostsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.postId,
        referencedTable: $db.posts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PostsTableAnnotationComposer(
              $db: $db,
              $table: $db.posts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LocationPostsTableAnnotationComposer get locationPostId {
    final $$LocationPostsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.locationPostId,
        referencedTable: $db.locationPosts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocationPostsTableAnnotationComposer(
              $db: $db,
              $table: $db.locationPosts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SimpleLocationPointsTableAnnotationComposer get simpleLocationPointId {
    final $$SimpleLocationPointsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.simpleLocationPointId,
            referencedTable: $db.simpleLocationPoints,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SimpleLocationPointsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.simpleLocationPoints,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$MyImagesTableTableManager extends RootTableManager<
    _$MyDbContext,
    $MyImagesTable,
    MyImage,
    $$MyImagesTableFilterComposer,
    $$MyImagesTableOrderingComposer,
    $$MyImagesTableAnnotationComposer,
    $$MyImagesTableCreateCompanionBuilder,
    $$MyImagesTableUpdateCompanionBuilder,
    (MyImage, $$MyImagesTableReferences),
    MyImage,
    PrefetchHooks Function(
        {bool postId, bool locationPostId, bool simpleLocationPointId})> {
  $$MyImagesTableTableManager(_$MyDbContext db, $MyImagesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MyImagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MyImagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MyImagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> shortPath = const Value.absent(),
            Value<String> fullPath = const Value.absent(),
            Value<String> localFullPath = const Value.absent(),
            Value<String> fileType = const Value.absent(),
            Value<int> height = const Value.absent(),
            Value<int> width = const Value.absent(),
            Value<double> aspectRatio = const Value.absent(),
            Value<int> type = const Value.absent(),
            Value<String?> postId = const Value.absent(),
            Value<String?> locationPostId = const Value.absent(),
            Value<String?> simpleLocationPointId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MyImagesCompanion(
            id: id,
            shortPath: shortPath,
            fullPath: fullPath,
            localFullPath: localFullPath,
            fileType: fileType,
            height: height,
            width: width,
            aspectRatio: aspectRatio,
            type: type,
            postId: postId,
            locationPostId: locationPostId,
            simpleLocationPointId: simpleLocationPointId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String shortPath,
            required String fullPath,
            required String localFullPath,
            required String fileType,
            required int height,
            required int width,
            required double aspectRatio,
            required int type,
            Value<String?> postId = const Value.absent(),
            Value<String?> locationPostId = const Value.absent(),
            Value<String?> simpleLocationPointId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MyImagesCompanion.insert(
            id: id,
            shortPath: shortPath,
            fullPath: fullPath,
            localFullPath: localFullPath,
            fileType: fileType,
            height: height,
            width: width,
            aspectRatio: aspectRatio,
            type: type,
            postId: postId,
            locationPostId: locationPostId,
            simpleLocationPointId: simpleLocationPointId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$MyImagesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {postId = false,
              locationPostId = false,
              simpleLocationPointId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (postId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.postId,
                    referencedTable: $$MyImagesTableReferences._postIdTable(db),
                    referencedColumn:
                        $$MyImagesTableReferences._postIdTable(db).id,
                  ) as T;
                }
                if (locationPostId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.locationPostId,
                    referencedTable:
                        $$MyImagesTableReferences._locationPostIdTable(db),
                    referencedColumn:
                        $$MyImagesTableReferences._locationPostIdTable(db).id,
                  ) as T;
                }
                if (simpleLocationPointId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.simpleLocationPointId,
                    referencedTable: $$MyImagesTableReferences
                        ._simpleLocationPointIdTable(db),
                    referencedColumn: $$MyImagesTableReferences
                        ._simpleLocationPointIdTable(db)
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
        ));
}

typedef $$MyImagesTableProcessedTableManager = ProcessedTableManager<
    _$MyDbContext,
    $MyImagesTable,
    MyImage,
    $$MyImagesTableFilterComposer,
    $$MyImagesTableOrderingComposer,
    $$MyImagesTableAnnotationComposer,
    $$MyImagesTableCreateCompanionBuilder,
    $$MyImagesTableUpdateCompanionBuilder,
    (MyImage, $$MyImagesTableReferences),
    MyImage,
    PrefetchHooks Function(
        {bool postId, bool locationPostId, bool simpleLocationPointId})>;

class $MyDbContextManager {
  final _$MyDbContext _db;
  $MyDbContextManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$PostsTableTableManager get posts =>
      $$PostsTableTableManager(_db, _db.posts);
  $$SimpleLocationPointsTableTableManager get simpleLocationPoints =>
      $$SimpleLocationPointsTableTableManager(_db, _db.simpleLocationPoints);
  $$LocationPostsTableTableManager get locationPosts =>
      $$LocationPostsTableTableManager(_db, _db.locationPosts);
  $$MyImagesTableTableManager get myImages =>
      $$MyImagesTableTableManager(_db, _db.myImages);
}
