// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_image_group_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyImageGroupHiveAdapter extends TypeAdapter<MyImageGroupHive> {
  @override
  final int typeId = 1;

  @override
  MyImageGroupHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyImageGroupHive(
      id: fields[0] as String,
      title: fields[1] as String,
      position: fields[2] as int,
      images: (fields[3] as List).cast<MyImageHive>(),
    );
  }

  @override
  void write(BinaryWriter writer, MyImageGroupHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.position)
      ..writeByte(3)
      ..write(obj.images);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyImageGroupHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
