// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_full_account_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserFullAccountHiveAdapter extends TypeAdapter<UserFullAccountHive> {
  @override
  final int typeId = 12;

  @override
  UserFullAccountHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserFullAccountHive(
      id: fields[7] as String,
      avatar: fields[8] as MyImageGroupHive?,
      username: fields[9] as String,
      displayName: fields[10] as String,
      isFollowing: fields[11] as bool,
      dataCreationTime: fields[4] as DateTime,
      friendsCount: fields[6] as int,
      followersCount: fields[5] as int,
      birthDate: fields[0] as DateTime?,
      email: fields[1] as String?,
      phoneNumber: fields[2] as String?,
      likesCount: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, UserFullAccountHive obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.birthDate)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.phoneNumber)
      ..writeByte(3)
      ..write(obj.likesCount)
      ..writeByte(4)
      ..write(obj.dataCreationTime)
      ..writeByte(5)
      ..write(obj.followersCount)
      ..writeByte(6)
      ..write(obj.friendsCount)
      ..writeByte(7)
      ..write(obj.id)
      ..writeByte(8)
      ..write(obj.avatar)
      ..writeByte(9)
      ..write(obj.username)
      ..writeByte(10)
      ..write(obj.displayName)
      ..writeByte(11)
      ..write(obj.isFollowing);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserFullAccountHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
