// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_position_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserPositionHiveAdapter extends TypeAdapter<UserPositionHive> {
  @override
  final int typeId = 10;

  @override
  UserPositionHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserPositionHive(
      latitude: fields[0] as double,
      longitude: fields[1] as double,
      accuracy: fields[2] as double,
      floor: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, UserPositionHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.latitude)
      ..writeByte(1)
      ..write(obj.longitude)
      ..writeByte(2)
      ..write(obj.accuracy)
      ..writeByte(3)
      ..write(obj.floor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserPositionHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
