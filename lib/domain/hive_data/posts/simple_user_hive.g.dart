// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_user_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SimpleUserHiveAdapter extends TypeAdapter<SimpleUserHive> {
  @override
  final int typeId = 3;

  @override
  SimpleUserHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SimpleUserHive(
      id: fields[0] as String,
      username: fields[1] as String,
      displayName: fields[2] as String,
      avatar: fields[3] as MyImageGroupHive?,
    );
  }

  @override
  void write(BinaryWriter writer, SimpleUserHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.displayName)
      ..writeByte(3)
      ..write(obj.avatar);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SimpleUserHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
