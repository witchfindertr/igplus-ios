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
      url: fields[3] as String,
      commentsCount: fields[4] as int,
      likeCount: fields[5] as int,
      viewCount: fields[6] as int,
      createdAt: fields[7] as String,
      topLikers: (fields[8] as List).cast<Friend>(),
      updatedOn: fields[9] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Media obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.mediaType)
      ..writeByte(3)
      ..write(obj.url)
      ..writeByte(4)
      ..write(obj.commentsCount)
      ..writeByte(5)
      ..write(obj.likeCount)
      ..writeByte(6)
      ..write(obj.viewCount)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.topLikers)
      ..writeByte(9)
      ..write(obj.updatedOn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is MediaAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
