// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usermodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      userID: fields[1] as String,
      userAD: fields[2] as String,
      userSoyAD: fields[3] as String,
      userNumber: fields[4] as String,
      userDogumTarihi: fields[5] as String,
      userKayitTarihi: fields[6] as String?,
      userOdemeTarihi: fields[7] as String?,
      userOdemeYapti: fields[8] as bool,
      odemeMiktari: fields[9] as String?,
      okul: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(1)
      ..write(obj.userID)
      ..writeByte(2)
      ..write(obj.userAD)
      ..writeByte(3)
      ..write(obj.userSoyAD)
      ..writeByte(4)
      ..write(obj.userNumber)
      ..writeByte(5)
      ..write(obj.userDogumTarihi)
      ..writeByte(6)
      ..write(obj.userKayitTarihi)
      ..writeByte(7)
      ..write(obj.userOdemeTarihi)
      ..writeByte(8)
      ..write(obj.userOdemeYapti)
      ..writeByte(9)
      ..write(obj.odemeMiktari)
      ..writeByte(10)
      ..write(obj.okul);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
