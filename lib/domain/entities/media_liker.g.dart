// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_liker.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MediaLikerAdapter extends TypeAdapter<MediaLiker> {
  @override
  final int typeId = 9;

  @override
  MediaLiker read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MediaLiker(
      id: fields[0] as String,
      mediaId: fields[1] as String,
      user: fields[2] as Friend,
    );
  }

  @override
  void write(BinaryWriter writer, MediaLiker obj) {
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
      other is MediaLikerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
