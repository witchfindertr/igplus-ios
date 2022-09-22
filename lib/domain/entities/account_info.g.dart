// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountInfoAdapter extends TypeAdapter<AccountInfo> {
  @override
  final int typeId = 4;

  @override
  AccountInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountInfo(
      igUserId: fields[0] as String,
      username: fields[1] as String,
      isPrivate: fields[2] as bool,
      picture: fields[3] as String,
      followers: fields[4] as int,
      followings: fields[5] as int,
      contactPhoneNumber: fields[6] as String?,
      phoneCountryCode: fields[7] as String?,
      publicPhoneNumber: fields[8] as String?,
      publicEmail: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AccountInfo obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.igUserId)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.isPrivate)
      ..writeByte(3)
      ..write(obj.picture)
      ..writeByte(4)
      ..write(obj.followers)
      ..writeByte(5)
      ..write(obj.followings)
      ..writeByte(6)
      ..write(obj.contactPhoneNumber)
      ..writeByte(7)
      ..write(obj.phoneCountryCode)
      ..writeByte(8)
      ..write(obj.publicPhoneNumber)
      ..writeByte(9)
      ..write(obj.publicEmail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
