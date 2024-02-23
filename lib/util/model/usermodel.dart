import 'package:hive/hive.dart';

part 'usermodel.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(1)
  String userID;
  @HiveField(2)
  String userAD;
  @HiveField(3)
  String userSoyAD;
  @HiveField(4)
  String userNumber;
  @HiveField(5)
  String userDogumTarihi;
  @HiveField(6)
  String? userKayitTarihi = '';
  @HiveField(7)
  String? userOdemeTarihi = '';
  @HiveField(8)
  bool userOdemeYapti = false;
  @HiveField(9)
  String? odemeMiktari = '';
  @HiveField(10)
  String okul;
  UserModel({
    required this.userID,
    required this.userAD,
    required this.userSoyAD,
    required this.userNumber,
    required this.userDogumTarihi,
    this.userKayitTarihi,
    this.userOdemeTarihi,
    required this.userOdemeYapti,
    this.odemeMiktari,
    required this.okul,
  });
}
