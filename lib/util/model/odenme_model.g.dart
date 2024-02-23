// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'odenme_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OdemeModelAdapter extends TypeAdapter<OdemeModel> {
  @override
  final int typeId = 4;

  @override
  OdemeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OdemeModel(
      userID: fields[0] as String,
      odemeID: fields[1] as String,
      tarihi: fields[2] as DateTime,
      miktar: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, OdemeModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.userID)
      ..writeByte(1)
      ..write(obj.odemeID)
      ..writeByte(2)
      ..write(obj.tarihi)
      ..writeByte(3)
      ..write(obj.miktar);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OdemeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
