// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoryAdapter extends TypeAdapter<Story> {
  @override
  final int typeId = 7;

  @override
  Story read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Story(
      mediaId: fields[0] as String,
      takenAt: fields[1] as int,
      mediaType: fields[2] as String,
      mediaUrl: fields[3] as String,
      viewersCount: fields[4] as int,
      viewers: (fields[5] as List).cast<Friend>(),
    );
  }

  @override
  void write(BinaryWriter writer, Story obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.mediaId)
      ..writeByte(1)
      ..write(obj.takenAt)
      ..writeByte(2)
      ..write(obj.mediaType)
      ..writeByte(3)
      ..write(obj.mediaUrl)
      ..writeByte(4)
      ..write(obj.viewersCount)
      ..writeByte(5)
      ..write(obj.viewers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
