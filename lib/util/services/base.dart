import 'package:atakansimsek/util/model/dersmodel.dart';
import 'package:atakansimsek/util/model/gunmodel.dart';
import 'package:atakansimsek/util/model/odenme_model.dart';
import 'package:atakansimsek/util/model/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

abstract class BaseClass {
  Future<void> userSave(UserModel userModel);
  Future<void> dersSave(DersModel dersModel);
  Future<void> gunSave(DersModel dersModel);
  Future<void> userDelete(UserModel userModel);
}

//
//
//
class HiveVeriTabani extends BaseClass with ChangeNotifier {
  var userHive = Hive.box<UserModel>('users');
  var dersHive = Hive.box<DersModel>('ders');
  var gunHive = Hive.box<GunModel>('guns');
  var odemeHive = Hive.box<OdemeModel>('odeme');

//USER
  @override
  Future<void> userSave(UserModel userModel) async {
    await userHive.put(userModel.userID, userModel);
  }

  @override
  Future<void> userDelete(UserModel userModel) async {
    await userHive.delete(userModel.userID);
  }

  Future<List<UserModel>> getAllUsers() async {
    List<UserModel> allUsers = [];
    if (userHive.isNotEmpty) {
      for (var element in userHive.values) {
        allUsers.add(element);
      }

      return allUsers;
    } else {
      return allUsers;
    }
  }

  // DERS
  @override
  Future<void> dersSave(DersModel dersModel) async {
    await dersHive.put(dersModel.dersID, dersModel);
  }

  Future<List<DersModel>> getAllDers() async {
    List<DersModel> allDers = [];

    if (dersHive.isNotEmpty) {
      for (var element in dersHive.values) {
        allDers.add(element);
      }
      return allDers;
    } else {
      return allDers;
    }
  }
//GUN

  @override
  Future<void> gunSave(DersModel dersModel) async {
    List<String> gunAdlari = [
      'Pazartesi',
      'Salı',
      'Çarşamba',
      'Perşembe',
      'Cuma',
      'Cumartesi',
      'Pazar'
    ];

    for (String gunAdi in gunAdlari) {
      for (int saat = 9; saat <= 20; saat++) {
        String saatString = '$saat:00-${saat + 1}:00';
        var gunID = const Uuid().v1();
        var gun = GunModel(
            gunID: gunID,
            gunAdi: gunAdi,
            gunSaati: saatString,
            dersID: dersModel.dersID,
            gunDolumu: false);
        debugPrint(gun.toString());
        await gunHive.put(gunID, gun);
      }
    }
  }

  Future<void> gunUpdate(GunModel gunModel) async {
    await gunHive.put(gunModel.gunID, gunModel);
  }

  Future<List<GunModel>> getFilterGuns(DersModel dersModel, String gun) async {
    List<GunModel> allGuns = [];

    if (gunHive.isNotEmpty) {
      for (var element in gunHive.values) {
        if (element.gunAdi == gun && element.dersID == dersModel.dersID) {
          allGuns.add(element);
        }
      }
      return allGuns;
    } else {
      return allGuns;
    }
  }

//Odeme

  Future<void> odemeEkle(OdemeModel odemeModel) async {
    await odemeHive.put(odemeModel.odemeID, odemeModel);
  }

  Future<void> odemeDelete(OdemeModel odemeModel) async {
    await odemeHive.delete(odemeModel.odemeID);
  }

  Future<List<OdemeModel>> getOdemeler(UserModel userModel) async {
    List<OdemeModel> odemler = [];
    print('11111');
    if (odemeHive.isNotEmpty) {
      print('222222');

      for (var element in odemeHive.values) {
        if (element.userID == userModel.userID) {
          odemeHive.add(element);
        }
      }
      return odemler;
    } else {
      return odemler;
    }
  }
}
