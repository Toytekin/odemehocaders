import 'package:hive/hive.dart';
part 'odenme_model.g.dart';

@HiveType(typeId: 4)
class OdemeModel {
  @HiveField(0)
  String userID;
  @HiveField(1)
  String odemeID;
  @HiveField(2)
  DateTime tarihi;

  @HiveField(3)
  int miktar;
  OdemeModel({
    required this.userID,
    required this.odemeID,
    required this.tarihi,
    required this.miktar,
  });

  int compareTo(OdemeModel other) {
    return tarihi.compareTo(other.tarihi);
  }
}
