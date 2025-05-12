// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_location_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddLocationHiveAdapter extends TypeAdapter<AddLocationHive> {
  @override
  final int typeId = 6;

  @override
  AddLocationHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddLocationHive(
      latitude: fields[0] as double,
      longitude: fields[1] as double,
      eventTime: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, AddLocationHive obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.latitude)
      ..writeByte(1)
      ..write(obj.longitude)
      ..writeByte(2)
      ..write(obj.eventTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddLocationHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
