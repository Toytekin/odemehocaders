import 'package:atakansimsek/util/model/usermodel.dart';
import 'package:hive/hive.dart';

part 'gunmodel.g.dart';

@HiveType(typeId: 3)
class GunModel {
  @HiveField(0)
  String gunID;
  @HiveField(1)
  String gunAdi;
  @HiveField(2)
  String gunSaati;
  @HiveField(3)
  bool gunDolumu = false;
  @HiveField(4)
  String dersID;
  @HiveField(5)
  UserModel? userModel;
  GunModel({
    required this.gunID,
    required this.gunAdi,
    required this.gunSaati,
    required this.gunDolumu,
    required this.dersID,
    this.userModel,
  });
}
