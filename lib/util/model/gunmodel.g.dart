// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gunmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GunModelAdapter extends TypeAdapter<GunModel> {
  @override
  final int typeId = 3;

  @override
  GunModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GunModel(
      gunID: fields[0] as String,
      gunAdi: fields[1] as String,
      gunSaati: fields[2] as String,
      gunDolumu: fields[3] as bool,
      dersID: fields[4] as String,
      userModel: fields[5] as UserModel?,
    );
  }

  @override
  void write(BinaryWriter writer, GunModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.gunID)
      ..writeByte(1)
      ..write(obj.gunAdi)
      ..writeByte(2)
      ..write(obj.gunSaati)
      ..writeByte(3)
      ..write(obj.gunDolumu)
      ..writeByte(4)
      ..write(obj.dersID)
      ..writeByte(5)
      ..write(obj.userModel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GunModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
