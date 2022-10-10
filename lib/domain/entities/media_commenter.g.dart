// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_commenter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MediaCommenterAdapter extends TypeAdapter<MediaCommenter> {
  @override
  final int typeId = 10;

  @override
  MediaCommenter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MediaCommenter(
      id: fields[0] as String,
      mediaId: fields[1] as String,
      user: fields[2] as Friend,
    );
  }

  @override
  void write(BinaryWriter writer, MediaCommenter obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.mediaId)
      ..writeByte(2)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MediaCommenterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
