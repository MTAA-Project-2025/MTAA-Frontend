// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_point_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SimplePointHiveAdapter extends TypeAdapter<SimplePointHive> {
  @override
  final int typeId = 9;

  @override
  SimplePointHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SimplePointHive(
      id: fields[0] as String,
      postId: fields[1] as String?,
      longitude: fields[2] as double,
      latitude: fields[3] as double,
      type: fields[4] as int,
      zoomLevel: fields[5] as int,
      childCount: fields[6] as int,
      image: fields[7] as MyImageHive?,
    );
  }

  @override
  void write(BinaryWriter writer, SimplePointHive obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.postId)
      ..writeByte(2)
      ..write(obj.longitude)
      ..writeByte(3)
      ..write(obj.latitude)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.zoomLevel)
      ..writeByte(6)
      ..write(obj.childCount)
      ..writeByte(7)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SimplePointHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
