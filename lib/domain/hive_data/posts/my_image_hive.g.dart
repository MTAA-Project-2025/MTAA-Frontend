// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_image_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyImageHiveAdapter extends TypeAdapter<MyImageHive> {
  @override
  final int typeId = 0;

  @override
  MyImageHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyImageHive(
      id: fields[0] as String,
      shortPath: fields[1] as String,
      fullPath: fields[2] as String,
      fileType: fields[4] as String,
      height: fields[5] as int,
      width: fields[6] as int,
      aspectRatio: fields[7] as double,
      type: fields[8] as int,
      localPath: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MyImageHive obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.shortPath)
      ..writeByte(2)
      ..write(obj.fullPath)
      ..writeByte(3)
      ..write(obj.localPath)
      ..writeByte(4)
      ..write(obj.fileType)
      ..writeByte(5)
      ..write(obj.height)
      ..writeByte(6)
      ..write(obj.width)
      ..writeByte(7)
      ..write(obj.aspectRatio)
      ..writeByte(8)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyImageHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
