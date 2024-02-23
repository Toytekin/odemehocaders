// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dersmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DersModelAdapter extends TypeAdapter<DersModel> {
  @override
  final int typeId = 2;

  @override
  DersModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DersModel(
      dersID: fields[0] as String,
      desAdi: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DersModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.dersID)
      ..writeByte(1)
      ..write(obj.desAdi);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DersModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
