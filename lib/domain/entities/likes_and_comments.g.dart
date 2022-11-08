// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'likes_and_comments.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LikesAndCommentsAdapter extends TypeAdapter<LikesAndComments> {
  @override
  final int typeId = 11;

  @override
  LikesAndComments read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LikesAndComments(
      total: fields[0] as int,
      likesCount: fields[1] as int,
      commentsCount: fields[2] as int,
      followedBy: fields[3] as bool,
      following: fields[4] as bool,
      user: fields[5] as Friend,
    );
  }

  @override
  void write(BinaryWriter writer, LikesAndComments obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.total)
      ..writeByte(1)
      ..write(obj.likesCount)
      ..writeByte(2)
      ..write(obj.commentsCount)
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
      other is LikesAndCommentsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
