// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'full_post_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FullPostHiveAdapter extends TypeAdapter<FullPostHive> {
  @override
  final int typeId = 2;

  @override
  FullPostHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FullPostHive(
      id: fields[0] as String,
      description: fields[1] as String,
      images: (fields[2] as List).cast<MyImageGroupHive>(),
      owner: fields[3] as SimpleUserHive,
      likesCount: fields[4] as int,
      commentsCount: fields[5] as int,
      isLiked: fields[6] as bool,
      locationId: fields[7] as String?,
      dataCreationTime: fields[8] as DateTime?,
      isLocal: fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, FullPostHive obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.images)
      ..writeByte(3)
      ..write(obj.owner)
      ..writeByte(4)
      ..write(obj.likesCount)
      ..writeByte(5)
      ..write(obj.commentsCount)
      ..writeByte(6)
      ..write(obj.isLiked)
      ..writeByte(7)
      ..write(obj.locationId)
      ..writeByte(8)
      ..write(obj.dataCreationTime)
      ..writeByte(9)
      ..write(obj.isLocal);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FullPostHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
