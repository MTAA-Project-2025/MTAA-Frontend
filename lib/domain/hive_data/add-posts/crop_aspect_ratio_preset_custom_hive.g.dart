// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crop_aspect_ratio_preset_custom_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CropAspectRatioPresetCustomHiveAdapter
    extends TypeAdapter<CropAspectRatioPresetCustomHive> {
  @override
  final int typeId = 8;

  @override
  CropAspectRatioPresetCustomHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CropAspectRatioPresetCustomHive(
      width: fields[0] as int,
      height: fields[1] as int,
      name: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CropAspectRatioPresetCustomHive obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.width)
      ..writeByte(1)
      ..write(obj.height)
      ..writeByte(2)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CropAspectRatioPresetCustomHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
