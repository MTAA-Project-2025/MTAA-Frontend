// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_image_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddImageHiveAdapter extends TypeAdapter<AddImageHive> {
  @override
  final int typeId = 7;

  @override
  AddImageHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddImageHive(
      imagePath: fields[0] as String,
      position: fields[1] as int,
      isAspectRatioError: fields[2] as bool,
      aspectRatioPreset: fields[3] as CropAspectRatioPresetCustomHive?,
      origImagePath: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AddImageHive obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.imagePath)
      ..writeByte(1)
      ..write(obj.position)
      ..writeByte(2)
      ..write(obj.isAspectRatioError)
      ..writeByte(3)
      ..write(obj.aspectRatioPreset)
      ..writeByte(4)
      ..write(obj.origImagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddImageHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
