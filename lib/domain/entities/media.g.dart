// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MediaAdapter extends TypeAdapter<Media> {
  @override
  final int typeId = 2;

  @override
  Media read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Media(
      id: fields[0] as int,
      text: fields[1] as String,
      mediaType: fields[2] as int,
      code: fields[3] as String,
      url: fields[4] as String,
      commentsCount: fields[5] as int,
      likeCount: fields[6] as int,
      viewCount: fields[7] as int,
      createdAt: fields[8] as String,
      topLikers: (fields[9] as List).cast<Friend>(),
      updatedOn: fields[10] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Media obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.mediaType)
      ..writeByte(3)
      ..write(obj.code)
      ..writeByte(4)
      ..write(obj.url)
      ..writeByte(5)
      ..write(obj.commentsCount)
      ..writeByte(6)
      ..write(obj.likeCount)
      ..writeByte(7)
      ..write(obj.viewCount)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.topLikers)
      ..writeByte(10)
      ..write(obj.updatedOn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MediaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
