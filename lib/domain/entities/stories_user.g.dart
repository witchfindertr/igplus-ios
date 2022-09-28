// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stories_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoriesUserAdapter extends TypeAdapter<StoriesUser> {
  @override
  final int typeId = 6;

  @override
  StoriesUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoriesUser(
      owner: fields[0] as StoryOwner,
      id: fields[1] as String,
      expiringAt: fields[2] as int,
      latestReelMedia: fields[3] as int,
      seen: fields[4] as int,
      stories: (fields[5] as List).cast<Story>(),
    );
  }

  @override
  void write(BinaryWriter writer, StoriesUser obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.owner)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.expiringAt)
      ..writeByte(3)
      ..write(obj.latestReelMedia)
      ..writeByte(4)
      ..write(obj.seen)
      ..writeByte(5)
      ..write(obj.stories);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoriesUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StoryOwnerAdapter extends TypeAdapter<StoryOwner> {
  @override
  final int typeId = 5;

  @override
  StoryOwner read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoryOwner(
      id: fields[0] as String,
      username: fields[1] as String,
      profilePicUrl: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StoryOwner obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.profilePicUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoryOwnerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
