// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../repository/simple_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SimpleUserAdapter extends TypeAdapter<SimpleUser> {
  @override
  final int typeId = 1;

  @override
  SimpleUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SimpleUser(
      userId: fields[0] as String,
      email: fields[1] as String,
      password: fields[2] as String,
      imagePath: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SimpleUser obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SimpleUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
