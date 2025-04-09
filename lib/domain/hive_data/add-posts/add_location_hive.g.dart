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
    return AddLocationHive();
  }

  @override
  void write(BinaryWriter writer, AddLocationHive obj) {
    writer.writeByte(0);
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
