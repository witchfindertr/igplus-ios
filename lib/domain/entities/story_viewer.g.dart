// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_viewer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoryViewerAdapter extends TypeAdapter<StoryViewer> {
  @override
  final int typeId = 8;

  @override
  StoryViewer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoryViewer(
      id: fields[0] as String,
      mediaId: fields[1] as String,
      hasLiked: fields[2] as bool,
      followedBy: fields[3] as bool,
      following: fields[4] as bool,
      user: fields[5] as Friend,
    );
  }

  @override
  void write(BinaryWriter writer, StoryViewer obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.mediaId)
      ..writeByte(2)
      ..write(obj.hasLiked)
      ..writeByte(3)
      ..write(obj.followedBy)
      ..writeByte(4)
      ..write(obj.following)
      ..writeByte(5)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoryViewerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
