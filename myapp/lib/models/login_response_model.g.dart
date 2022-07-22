// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class loginResponseModelAdapter extends TypeAdapter<loginResponseModel> {
  @override
  final int typeId = 0;

  @override
  loginResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return loginResponseModel(
      error: fields[0] as dynamic,
      status: fields[1] as dynamic,
      token: fields[2] as dynamic,
      success: fields[3] as dynamic,
      userName: fields[4] as dynamic,
      userId: fields[5] as dynamic,
      usertype: fields[6] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, loginResponseModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.error)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.token)
      ..writeByte(3)
      ..write(obj.success)
      ..writeByte(4)
      ..write(obj.userName)
      ..writeByte(5)
      ..write(obj.userId)
      ..writeByte(6)
      ..write(obj.usertype);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is loginResponseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
