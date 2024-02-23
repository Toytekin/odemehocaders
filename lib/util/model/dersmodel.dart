import 'package:hive/hive.dart';

part 'dersmodel.g.dart';

@HiveType(typeId: 2)
class DersModel {
  @HiveField(0)
  String dersID;
  @HiveField(1)
  String desAdi;
  DersModel({
    required this.dersID,
    required this.desAdi,
  });
}
