// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_post_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddPostHiveAdapter extends TypeAdapter<AddPostHive> {
  @override
  final int typeId = 5;

  @override
  AddPostHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddPostHive(
      location: fields[0] as AddLocationHive?,
      description: fields[1] as String,
      images: (fields[2] as List).cast<AddImageHive>(),
      scheduledDate: fields[3] as DateTime?,
      id: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AddPostHive obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.location)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.images)
      ..writeByte(3)
      ..write(obj.scheduledDate)
      ..writeByte(4)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddPostHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
