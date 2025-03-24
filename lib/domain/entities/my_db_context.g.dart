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
  static const VerificationMeta _avatarIdMeta =
      const VerificationMeta('avatarId');
  @override
  late final GeneratedColumn<String> avatarId = GeneratedColumn<String>(
      'avatar_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
        avatarId,
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
    if (data.containsKey('avatar_id')) {
      context.handle(_avatarIdMeta,
          avatarId.isAcceptableOrUnknown(data['avatar_id']!, _avatarIdMeta));
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
  Set<GeneratedColumn> get $primaryKey => const {};
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
      avatarId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}avatar_id']),
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
  final String? avatarId;
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
      this.avatarId,
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
    if (!nullToAbsent || avatarId != null) {
      map['avatar_id'] = Variable<String>(avatarId);
    }
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
      avatarId: avatarId == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarId),
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
      avatarId: serializer.fromJson<String?>(json['avatarId']),
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
      'avatarId': serializer.toJson<String?>(avatarId),
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
          Value<String?> avatarId = const Value.absent(),
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
        avatarId: avatarId.present ? avatarId.value : this.avatarId,
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
      avatarId: data.avatarId.present ? data.avatarId.value : this.avatarId,
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
          ..write('avatarId: $avatarId, ')
          ..write('currentUser: $currentUser, ')
          ..write('isSimple: $isSimple, ')
          ..write('isTempRecommendation: $isTempRecommendation')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      username,
      displayName,
      birthDate,
      status,
      lastSeen,
      dataCreationTime,
      avatarId,
      currentUser,
      isSimple,
      isTempRecommendation);
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
          other.avatarId == this.avatarId &&
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
  final Value<String?> avatarId;
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
    this.avatarId = const Value.absent(),
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
    this.avatarId = const Value.absent(),
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
    Expression<String>? avatarId,
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
      if (avatarId != null) 'avatar_id': avatarId,
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
      Value<String?>? avatarId,
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
      avatarId: avatarId ?? this.avatarId,
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
    if (avatarId.present) {
      map['avatar_id'] = Variable<String>(avatarId.value);
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
          ..write('avatarId: $avatarId, ')
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
  static const VerificationMeta _currentUserMeta =
      const VerificationMeta('currentUser');
  @override
  late final GeneratedColumn<String> currentUser = GeneratedColumn<String>(
      'current_user', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, ownerId, dataCreationTime, currentUser];
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
  Set<GeneratedColumn> get $primaryKey => const {};
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
      currentUser: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}current_user'])!,
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
  final String currentUser;
  const Post(
      {required this.id,
      required this.ownerId,
      required this.dataCreationTime,
      required this.currentUser});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['owner_id'] = Variable<String>(ownerId);
    map['data_creation_time'] = Variable<DateTime>(dataCreationTime);
    map['current_user'] = Variable<String>(currentUser);
    return map;
  }

  PostsCompanion toCompanion(bool nullToAbsent) {
    return PostsCompanion(
      id: Value(id),
      ownerId: Value(ownerId),
      dataCreationTime: Value(dataCreationTime),
      currentUser: Value(currentUser),
    );
  }

  factory Post.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Post(
      id: serializer.fromJson<String>(json['id']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      dataCreationTime: serializer.fromJson<DateTime>(json['dataCreationTime']),
      currentUser: serializer.fromJson<String>(json['currentUser']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ownerId': serializer.toJson<String>(ownerId),
      'dataCreationTime': serializer.toJson<DateTime>(dataCreationTime),
      'currentUser': serializer.toJson<String>(currentUser),
    };
  }

  Post copyWith(
          {String? id,
          String? ownerId,
          DateTime? dataCreationTime,
          String? currentUser}) =>
      Post(
        id: id ?? this.id,
        ownerId: ownerId ?? this.ownerId,
        dataCreationTime: dataCreationTime ?? this.dataCreationTime,
        currentUser: currentUser ?? this.currentUser,
      );
  Post copyWithCompanion(PostsCompanion data) {
    return Post(
      id: data.id.present ? data.id.value : this.id,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      dataCreationTime: data.dataCreationTime.present
          ? data.dataCreationTime.value
          : this.dataCreationTime,
      currentUser:
          data.currentUser.present ? data.currentUser.value : this.currentUser,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Post(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('dataCreationTime: $dataCreationTime, ')
          ..write('currentUser: $currentUser')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ownerId, dataCreationTime, currentUser);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Post &&
          other.id == this.id &&
          other.ownerId == this.ownerId &&
          other.dataCreationTime == this.dataCreationTime &&
          other.currentUser == this.currentUser);
}

class PostsCompanion extends UpdateCompanion<Post> {
  final Value<String> id;
  final Value<String> ownerId;
  final Value<DateTime> dataCreationTime;
  final Value<String> currentUser;
  final Value<int> rowid;
  const PostsCompanion({
    this.id = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.dataCreationTime = const Value.absent(),
    this.currentUser = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PostsCompanion.insert({
    required String id,
    required String ownerId,
    required DateTime dataCreationTime,
    required String currentUser,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        ownerId = Value(ownerId),
        dataCreationTime = Value(dataCreationTime),
        currentUser = Value(currentUser);
  static Insertable<Post> custom({
    Expression<String>? id,
    Expression<String>? ownerId,
    Expression<DateTime>? dataCreationTime,
    Expression<String>? currentUser,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerId != null) 'owner_id': ownerId,
      if (dataCreationTime != null) 'data_creation_time': dataCreationTime,
      if (currentUser != null) 'current_user': currentUser,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PostsCompanion copyWith(
      {Value<String>? id,
      Value<String>? ownerId,
      Value<DateTime>? dataCreationTime,
      Value<String>? currentUser,
      Value<int>? rowid}) {
    return PostsCompanion(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      dataCreationTime: dataCreationTime ?? this.dataCreationTime,
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
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (dataCreationTime.present) {
      map['data_creation_time'] = Variable<DateTime>(dataCreationTime.value);
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
    return (StringBuffer('PostsCompanion(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('dataCreationTime: $dataCreationTime, ')
          ..write('currentUser: $currentUser, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MyImageGroupsTable extends MyImageGroups
    with TableInfo<$MyImageGroupsTable, MyImageGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MyImageGroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
      'position', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _postIdMeta = const VerificationMeta('postId');
  @override
  late final GeneratedColumn<String> postId = GeneratedColumn<String>(
      'post_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES posts (id)'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, title, position, postId, userId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'my_image_groups';
  @override
  VerificationContext validateIntegrity(Insertable<MyImageGroup> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('post_id')) {
      context.handle(_postIdMeta,
          postId.isAcceptableOrUnknown(data['post_id']!, _postIdMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  MyImageGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MyImageGroup(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}position'])!,
      postId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}post_id']),
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id']),
    );
  }

  @override
  $MyImageGroupsTable createAlias(String alias) {
    return $MyImageGroupsTable(attachedDatabase, alias);
  }
}

class MyImageGroup extends DataClass implements Insertable<MyImageGroup> {
  final String id;
  final String title;
  final int position;
  final String? postId;
  final String? userId;
  const MyImageGroup(
      {required this.id,
      required this.title,
      required this.position,
      this.postId,
      this.userId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['position'] = Variable<int>(position);
    if (!nullToAbsent || postId != null) {
      map['post_id'] = Variable<String>(postId);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    return map;
  }

  MyImageGroupsCompanion toCompanion(bool nullToAbsent) {
    return MyImageGroupsCompanion(
      id: Value(id),
      title: Value(title),
      position: Value(position),
      postId:
          postId == null && nullToAbsent ? const Value.absent() : Value(postId),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
    );
  }

  factory MyImageGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MyImageGroup(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      position: serializer.fromJson<int>(json['position']),
      postId: serializer.fromJson<String?>(json['postId']),
      userId: serializer.fromJson<String?>(json['userId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'position': serializer.toJson<int>(position),
      'postId': serializer.toJson<String?>(postId),
      'userId': serializer.toJson<String?>(userId),
    };
  }

  MyImageGroup copyWith(
          {String? id,
          String? title,
          int? position,
          Value<String?> postId = const Value.absent(),
          Value<String?> userId = const Value.absent()}) =>
      MyImageGroup(
        id: id ?? this.id,
        title: title ?? this.title,
        position: position ?? this.position,
        postId: postId.present ? postId.value : this.postId,
        userId: userId.present ? userId.value : this.userId,
      );
  MyImageGroup copyWithCompanion(MyImageGroupsCompanion data) {
    return MyImageGroup(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      position: data.position.present ? data.position.value : this.position,
      postId: data.postId.present ? data.postId.value : this.postId,
      userId: data.userId.present ? data.userId.value : this.userId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MyImageGroup(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('position: $position, ')
          ..write('postId: $postId, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, position, postId, userId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MyImageGroup &&
          other.id == this.id &&
          other.title == this.title &&
          other.position == this.position &&
          other.postId == this.postId &&
          other.userId == this.userId);
}

class MyImageGroupsCompanion extends UpdateCompanion<MyImageGroup> {
  final Value<String> id;
  final Value<String> title;
  final Value<int> position;
  final Value<String?> postId;
  final Value<String?> userId;
  final Value<int> rowid;
  const MyImageGroupsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.position = const Value.absent(),
    this.postId = const Value.absent(),
    this.userId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MyImageGroupsCompanion.insert({
    required String id,
    required String title,
    required int position,
    this.postId = const Value.absent(),
    this.userId = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        position = Value(position);
  static Insertable<MyImageGroup> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<int>? position,
    Expression<String>? postId,
    Expression<String>? userId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (position != null) 'position': position,
      if (postId != null) 'post_id': postId,
      if (userId != null) 'user_id': userId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MyImageGroupsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<int>? position,
      Value<String?>? postId,
      Value<String?>? userId,
      Value<int>? rowid}) {
    return MyImageGroupsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      position: position ?? this.position,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (postId.present) {
      map['post_id'] = Variable<String>(postId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MyImageGroupsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('position: $position, ')
          ..write('postId: $postId, ')
          ..write('userId: $userId, ')
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
  static const VerificationMeta _myImageGroupIdMeta =
      const VerificationMeta('myImageGroupId');
  @override
  late final GeneratedColumn<String> myImageGroupId = GeneratedColumn<String>(
      'my_image_group_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES my_image_groups (id)'));
  static const VerificationMeta _postIdMeta = const VerificationMeta('postId');
  @override
  late final GeneratedColumn<String> postId = GeneratedColumn<String>(
      'post_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES posts (id)'));
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
        myImageGroupId,
        postId
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
    if (data.containsKey('my_image_group_id')) {
      context.handle(
          _myImageGroupIdMeta,
          myImageGroupId.isAcceptableOrUnknown(
              data['my_image_group_id']!, _myImageGroupIdMeta));
    } else if (isInserting) {
      context.missing(_myImageGroupIdMeta);
    }
    if (data.containsKey('post_id')) {
      context.handle(_postIdMeta,
          postId.isAcceptableOrUnknown(data['post_id']!, _postIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
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
      myImageGroupId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}my_image_group_id'])!,
      postId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}post_id']),
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
  final String myImageGroupId;
  final String? postId;
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
      required this.myImageGroupId,
      this.postId});
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
    map['my_image_group_id'] = Variable<String>(myImageGroupId);
    if (!nullToAbsent || postId != null) {
      map['post_id'] = Variable<String>(postId);
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
      myImageGroupId: Value(myImageGroupId),
      postId:
          postId == null && nullToAbsent ? const Value.absent() : Value(postId),
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
      myImageGroupId: serializer.fromJson<String>(json['myImageGroupId']),
      postId: serializer.fromJson<String?>(json['postId']),
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
      'myImageGroupId': serializer.toJson<String>(myImageGroupId),
      'postId': serializer.toJson<String?>(postId),
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
          String? myImageGroupId,
          Value<String?> postId = const Value.absent()}) =>
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
        myImageGroupId: myImageGroupId ?? this.myImageGroupId,
        postId: postId.present ? postId.value : this.postId,
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
      myImageGroupId: data.myImageGroupId.present
          ? data.myImageGroupId.value
          : this.myImageGroupId,
      postId: data.postId.present ? data.postId.value : this.postId,
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
          ..write('myImageGroupId: $myImageGroupId, ')
          ..write('postId: $postId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, shortPath, fullPath, localFullPath,
      fileType, height, width, aspectRatio, type, myImageGroupId, postId);
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
          other.myImageGroupId == this.myImageGroupId &&
          other.postId == this.postId);
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
  final Value<String> myImageGroupId;
  final Value<String?> postId;
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
    this.myImageGroupId = const Value.absent(),
    this.postId = const Value.absent(),
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
    required String myImageGroupId,
    this.postId = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        shortPath = Value(shortPath),
        fullPath = Value(fullPath),
        localFullPath = Value(localFullPath),
        fileType = Value(fileType),
        height = Value(height),
        width = Value(width),
        aspectRatio = Value(aspectRatio),
        type = Value(type),
        myImageGroupId = Value(myImageGroupId);
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
    Expression<String>? myImageGroupId,
    Expression<String>? postId,
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
      if (myImageGroupId != null) 'my_image_group_id': myImageGroupId,
      if (postId != null) 'post_id': postId,
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
      Value<String>? myImageGroupId,
      Value<String?>? postId,
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
      myImageGroupId: myImageGroupId ?? this.myImageGroupId,
      postId: postId ?? this.postId,
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
    if (myImageGroupId.present) {
      map['my_image_group_id'] = Variable<String>(myImageGroupId.value);
    }
    if (postId.present) {
      map['post_id'] = Variable<String>(postId.value);
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
          ..write('myImageGroupId: $myImageGroupId, ')
          ..write('postId: $postId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocationsTable extends Locations
    with TableInfo<$LocationsTable, Location> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'locations';
  @override
  VerificationContext validateIntegrity(Insertable<Location> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Location map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Location(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
    );
  }

  @override
  $LocationsTable createAlias(String alias) {
    return $LocationsTable(attachedDatabase, alias);
  }
}

class Location extends DataClass implements Insertable<Location> {
  final String id;
  const Location({required this.id});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    return map;
  }

  LocationsCompanion toCompanion(bool nullToAbsent) {
    return LocationsCompanion(
      id: Value(id),
    );
  }

  factory Location.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Location(
      id: serializer.fromJson<String>(json['id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
    };
  }

  Location copyWith({String? id}) => Location(
        id: id ?? this.id,
      );
  Location copyWithCompanion(LocationsCompanion data) {
    return Location(
      id: data.id.present ? data.id.value : this.id,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Location(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => id.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Location && other.id == this.id);
}

class LocationsCompanion extends UpdateCompanion<Location> {
  final Value<String> id;
  final Value<int> rowid;
  const LocationsCompanion({
    this.id = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocationsCompanion.insert({
    required String id,
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<Location> custom({
    Expression<String>? id,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocationsCompanion copyWith({Value<String>? id, Value<int>? rowid}) {
    return LocationsCompanion(
      id: id ?? this.id,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationsCompanion(')
          ..write('id: $id, ')
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
  late final $MyImageGroupsTable myImageGroups = $MyImageGroupsTable(this);
  late final $MyImagesTable myImages = $MyImagesTable(this);
  late final $LocationsTable locations = $LocationsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [users, posts, myImageGroups, myImages, locations];
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  required String id,
  required String username,
  required String displayName,
  required DateTime birthDate,
  required String status,
  required DateTime lastSeen,
  required DateTime dataCreationTime,
  Value<String?> avatarId,
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
  Value<String?> avatarId,
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

  static MultiTypedResultKey<$MyImageGroupsTable, List<MyImageGroup>>
      _myImageGroupsRefsTable(_$MyDbContext db) =>
          MultiTypedResultKey.fromTable(db.myImageGroups,
              aliasName:
                  $_aliasNameGenerator(db.users.id, db.myImageGroups.userId));

  $$MyImageGroupsTableProcessedTableManager get myImageGroupsRefs {
    final manager = $$MyImageGroupsTableTableManager($_db, $_db.myImageGroups)
        .filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_myImageGroupsRefsTable($_db));
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

  ColumnFilters<String> get avatarId => $composableBuilder(
      column: $table.avatarId, builder: (column) => ColumnFilters(column));

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

  Expression<bool> myImageGroupsRefs(
      Expression<bool> Function($$MyImageGroupsTableFilterComposer f) f) {
    final $$MyImageGroupsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.myImageGroups,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MyImageGroupsTableFilterComposer(
              $db: $db,
              $table: $db.myImageGroups,
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

  ColumnOrderings<String> get avatarId => $composableBuilder(
      column: $table.avatarId, builder: (column) => ColumnOrderings(column));

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

  GeneratedColumn<String> get avatarId =>
      $composableBuilder(column: $table.avatarId, builder: (column) => column);

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

  Expression<T> myImageGroupsRefs<T extends Object>(
      Expression<T> Function($$MyImageGroupsTableAnnotationComposer a) f) {
    final $$MyImageGroupsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.myImageGroups,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MyImageGroupsTableAnnotationComposer(
              $db: $db,
              $table: $db.myImageGroups,
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
    PrefetchHooks Function({bool postsRefs, bool myImageGroupsRefs})> {
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
            Value<String?> avatarId = const Value.absent(),
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
            avatarId: avatarId,
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
            Value<String?> avatarId = const Value.absent(),
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
            avatarId: avatarId,
            currentUser: currentUser,
            isSimple: isSimple,
            isTempRecommendation: isTempRecommendation,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$UsersTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {postsRefs = false, myImageGroupsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (postsRefs) db.posts,
                if (myImageGroupsRefs) db.myImageGroups
              ],
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
                        typedResults: items),
                  if (myImageGroupsRefs)
                    await $_getPrefetchedData<User, $UsersTable, MyImageGroup>(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._myImageGroupsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0)
                                .myImageGroupsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
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
    PrefetchHooks Function({bool postsRefs, bool myImageGroupsRefs})>;
typedef $$PostsTableCreateCompanionBuilder = PostsCompanion Function({
  required String id,
  required String ownerId,
  required DateTime dataCreationTime,
  required String currentUser,
  Value<int> rowid,
});
typedef $$PostsTableUpdateCompanionBuilder = PostsCompanion Function({
  Value<String> id,
  Value<String> ownerId,
  Value<DateTime> dataCreationTime,
  Value<String> currentUser,
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

  static MultiTypedResultKey<$MyImageGroupsTable, List<MyImageGroup>>
      _myImageGroupsRefsTable(_$MyDbContext db) =>
          MultiTypedResultKey.fromTable(db.myImageGroups,
              aliasName:
                  $_aliasNameGenerator(db.posts.id, db.myImageGroups.postId));

  $$MyImageGroupsTableProcessedTableManager get myImageGroupsRefs {
    final manager = $$MyImageGroupsTableTableManager($_db, $_db.myImageGroups)
        .filter((f) => f.postId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_myImageGroupsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
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

  ColumnFilters<String> get currentUser => $composableBuilder(
      column: $table.currentUser, builder: (column) => ColumnFilters(column));

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

  Expression<bool> myImageGroupsRefs(
      Expression<bool> Function($$MyImageGroupsTableFilterComposer f) f) {
    final $$MyImageGroupsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.myImageGroups,
        getReferencedColumn: (t) => t.postId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MyImageGroupsTableFilterComposer(
              $db: $db,
              $table: $db.myImageGroups,
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

  ColumnOrderings<String> get currentUser => $composableBuilder(
      column: $table.currentUser, builder: (column) => ColumnOrderings(column));

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

  GeneratedColumn<String> get currentUser => $composableBuilder(
      column: $table.currentUser, builder: (column) => column);

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

  Expression<T> myImageGroupsRefs<T extends Object>(
      Expression<T> Function($$MyImageGroupsTableAnnotationComposer a) f) {
    final $$MyImageGroupsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.myImageGroups,
        getReferencedColumn: (t) => t.postId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MyImageGroupsTableAnnotationComposer(
              $db: $db,
              $table: $db.myImageGroups,
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
    PrefetchHooks Function(
        {bool ownerId, bool myImageGroupsRefs, bool myImagesRefs})> {
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
            Value<String> currentUser = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PostsCompanion(
            id: id,
            ownerId: ownerId,
            dataCreationTime: dataCreationTime,
            currentUser: currentUser,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String ownerId,
            required DateTime dataCreationTime,
            required String currentUser,
            Value<int> rowid = const Value.absent(),
          }) =>
              PostsCompanion.insert(
            id: id,
            ownerId: ownerId,
            dataCreationTime: dataCreationTime,
            currentUser: currentUser,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$PostsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {ownerId = false,
              myImageGroupsRefs = false,
              myImagesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (myImageGroupsRefs) db.myImageGroups,
                if (myImagesRefs) db.myImages
              ],
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
                  if (myImageGroupsRefs)
                    await $_getPrefetchedData<Post, $PostsTable, MyImageGroup>(
                        currentTable: table,
                        referencedTable:
                            $$PostsTableReferences._myImageGroupsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PostsTableReferences(db, table, p0)
                                .myImageGroupsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.postId == item.id),
                        typedResults: items),
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
    PrefetchHooks Function(
        {bool ownerId, bool myImageGroupsRefs, bool myImagesRefs})>;
typedef $$MyImageGroupsTableCreateCompanionBuilder = MyImageGroupsCompanion
    Function({
  required String id,
  required String title,
  required int position,
  Value<String?> postId,
  Value<String?> userId,
  Value<int> rowid,
});
typedef $$MyImageGroupsTableUpdateCompanionBuilder = MyImageGroupsCompanion
    Function({
  Value<String> id,
  Value<String> title,
  Value<int> position,
  Value<String?> postId,
  Value<String?> userId,
  Value<int> rowid,
});

final class $$MyImageGroupsTableReferences
    extends BaseReferences<_$MyDbContext, $MyImageGroupsTable, MyImageGroup> {
  $$MyImageGroupsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PostsTable _postIdTable(_$MyDbContext db) => db.posts
      .createAlias($_aliasNameGenerator(db.myImageGroups.postId, db.posts.id));

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

  static $UsersTable _userIdTable(_$MyDbContext db) => db.users
      .createAlias($_aliasNameGenerator(db.myImageGroups.userId, db.users.id));

  $$UsersTableProcessedTableManager? get userId {
    final $_column = $_itemColumn<String>('user_id');
    if ($_column == null) return null;
    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$MyImagesTable, List<MyImage>> _myImagesRefsTable(
          _$MyDbContext db) =>
      MultiTypedResultKey.fromTable(db.myImages,
          aliasName: $_aliasNameGenerator(
              db.myImageGroups.id, db.myImages.myImageGroupId));

  $$MyImagesTableProcessedTableManager get myImagesRefs {
    final manager = $$MyImagesTableTableManager($_db, $_db.myImages).filter(
        (f) => f.myImageGroupId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_myImagesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$MyImageGroupsTableFilterComposer
    extends Composer<_$MyDbContext, $MyImageGroupsTable> {
  $$MyImageGroupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnFilters(column));

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

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
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
        getReferencedColumn: (t) => t.myImageGroupId,
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

class $$MyImageGroupsTableOrderingComposer
    extends Composer<_$MyDbContext, $MyImageGroupsTable> {
  $$MyImageGroupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnOrderings(column));

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

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
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

class $$MyImageGroupsTableAnnotationComposer
    extends Composer<_$MyDbContext, $MyImageGroupsTable> {
  $$MyImageGroupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

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

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
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
        getReferencedColumn: (t) => t.myImageGroupId,
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

class $$MyImageGroupsTableTableManager extends RootTableManager<
    _$MyDbContext,
    $MyImageGroupsTable,
    MyImageGroup,
    $$MyImageGroupsTableFilterComposer,
    $$MyImageGroupsTableOrderingComposer,
    $$MyImageGroupsTableAnnotationComposer,
    $$MyImageGroupsTableCreateCompanionBuilder,
    $$MyImageGroupsTableUpdateCompanionBuilder,
    (MyImageGroup, $$MyImageGroupsTableReferences),
    MyImageGroup,
    PrefetchHooks Function({bool postId, bool userId, bool myImagesRefs})> {
  $$MyImageGroupsTableTableManager(_$MyDbContext db, $MyImageGroupsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MyImageGroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MyImageGroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MyImageGroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<int> position = const Value.absent(),
            Value<String?> postId = const Value.absent(),
            Value<String?> userId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MyImageGroupsCompanion(
            id: id,
            title: title,
            position: position,
            postId: postId,
            userId: userId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required int position,
            Value<String?> postId = const Value.absent(),
            Value<String?> userId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MyImageGroupsCompanion.insert(
            id: id,
            title: title,
            position: position,
            postId: postId,
            userId: userId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MyImageGroupsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {postId = false, userId = false, myImagesRefs = false}) {
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
                if (postId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.postId,
                    referencedTable:
                        $$MyImageGroupsTableReferences._postIdTable(db),
                    referencedColumn:
                        $$MyImageGroupsTableReferences._postIdTable(db).id,
                  ) as T;
                }
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable:
                        $$MyImageGroupsTableReferences._userIdTable(db),
                    referencedColumn:
                        $$MyImageGroupsTableReferences._userIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (myImagesRefs)
                    await $_getPrefetchedData<MyImageGroup, $MyImageGroupsTable,
                            MyImage>(
                        currentTable: table,
                        referencedTable: $$MyImageGroupsTableReferences
                            ._myImagesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$MyImageGroupsTableReferences(db, table, p0)
                                .myImagesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.myImageGroupId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$MyImageGroupsTableProcessedTableManager = ProcessedTableManager<
    _$MyDbContext,
    $MyImageGroupsTable,
    MyImageGroup,
    $$MyImageGroupsTableFilterComposer,
    $$MyImageGroupsTableOrderingComposer,
    $$MyImageGroupsTableAnnotationComposer,
    $$MyImageGroupsTableCreateCompanionBuilder,
    $$MyImageGroupsTableUpdateCompanionBuilder,
    (MyImageGroup, $$MyImageGroupsTableReferences),
    MyImageGroup,
    PrefetchHooks Function({bool postId, bool userId, bool myImagesRefs})>;
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
  required String myImageGroupId,
  Value<String?> postId,
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
  Value<String> myImageGroupId,
  Value<String?> postId,
  Value<int> rowid,
});

final class $$MyImagesTableReferences
    extends BaseReferences<_$MyDbContext, $MyImagesTable, MyImage> {
  $$MyImagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MyImageGroupsTable _myImageGroupIdTable(_$MyDbContext db) =>
      db.myImageGroups.createAlias($_aliasNameGenerator(
          db.myImages.myImageGroupId, db.myImageGroups.id));

  $$MyImageGroupsTableProcessedTableManager get myImageGroupId {
    final $_column = $_itemColumn<String>('my_image_group_id')!;

    final manager = $$MyImageGroupsTableTableManager($_db, $_db.myImageGroups)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_myImageGroupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

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

  $$MyImageGroupsTableFilterComposer get myImageGroupId {
    final $$MyImageGroupsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.myImageGroupId,
        referencedTable: $db.myImageGroups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MyImageGroupsTableFilterComposer(
              $db: $db,
              $table: $db.myImageGroups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

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

  $$MyImageGroupsTableOrderingComposer get myImageGroupId {
    final $$MyImageGroupsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.myImageGroupId,
        referencedTable: $db.myImageGroups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MyImageGroupsTableOrderingComposer(
              $db: $db,
              $table: $db.myImageGroups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

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

  $$MyImageGroupsTableAnnotationComposer get myImageGroupId {
    final $$MyImageGroupsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.myImageGroupId,
        referencedTable: $db.myImageGroups,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MyImageGroupsTableAnnotationComposer(
              $db: $db,
              $table: $db.myImageGroups,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

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
    PrefetchHooks Function({bool myImageGroupId, bool postId})> {
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
            Value<String> myImageGroupId = const Value.absent(),
            Value<String?> postId = const Value.absent(),
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
            myImageGroupId: myImageGroupId,
            postId: postId,
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
            required String myImageGroupId,
            Value<String?> postId = const Value.absent(),
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
            myImageGroupId: myImageGroupId,
            postId: postId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$MyImagesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({myImageGroupId = false, postId = false}) {
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
                if (myImageGroupId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.myImageGroupId,
                    referencedTable:
                        $$MyImagesTableReferences._myImageGroupIdTable(db),
                    referencedColumn:
                        $$MyImagesTableReferences._myImageGroupIdTable(db).id,
                  ) as T;
                }
                if (postId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.postId,
                    referencedTable: $$MyImagesTableReferences._postIdTable(db),
                    referencedColumn:
                        $$MyImagesTableReferences._postIdTable(db).id,
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
    PrefetchHooks Function({bool myImageGroupId, bool postId})>;
typedef $$LocationsTableCreateCompanionBuilder = LocationsCompanion Function({
  required String id,
  Value<int> rowid,
});
typedef $$LocationsTableUpdateCompanionBuilder = LocationsCompanion Function({
  Value<String> id,
  Value<int> rowid,
});

class $$LocationsTableFilterComposer
    extends Composer<_$MyDbContext, $LocationsTable> {
  $$LocationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));
}

class $$LocationsTableOrderingComposer
    extends Composer<_$MyDbContext, $LocationsTable> {
  $$LocationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));
}

class $$LocationsTableAnnotationComposer
    extends Composer<_$MyDbContext, $LocationsTable> {
  $$LocationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);
}

class $$LocationsTableTableManager extends RootTableManager<
    _$MyDbContext,
    $LocationsTable,
    Location,
    $$LocationsTableFilterComposer,
    $$LocationsTableOrderingComposer,
    $$LocationsTableAnnotationComposer,
    $$LocationsTableCreateCompanionBuilder,
    $$LocationsTableUpdateCompanionBuilder,
    (Location, BaseReferences<_$MyDbContext, $LocationsTable, Location>),
    Location,
    PrefetchHooks Function()> {
  $$LocationsTableTableManager(_$MyDbContext db, $LocationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocationsCompanion(
            id: id,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<int> rowid = const Value.absent(),
          }) =>
              LocationsCompanion.insert(
            id: id,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocationsTableProcessedTableManager = ProcessedTableManager<
    _$MyDbContext,
    $LocationsTable,
    Location,
    $$LocationsTableFilterComposer,
    $$LocationsTableOrderingComposer,
    $$LocationsTableAnnotationComposer,
    $$LocationsTableCreateCompanionBuilder,
    $$LocationsTableUpdateCompanionBuilder,
    (Location, BaseReferences<_$MyDbContext, $LocationsTable, Location>),
    Location,
    PrefetchHooks Function()>;

class $MyDbContextManager {
  final _$MyDbContext _db;
  $MyDbContextManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$PostsTableTableManager get posts =>
      $$PostsTableTableManager(_db, _db.posts);
  $$MyImageGroupsTableTableManager get myImageGroups =>
      $$MyImageGroupsTableTableManager(_db, _db.myImageGroups);
  $$MyImagesTableTableManager get myImages =>
      $$MyImagesTableTableManager(_db, _db.myImages);
  $$LocationsTableTableManager get locations =>
      $$LocationsTableTableManager(_db, _db.locations);
}
