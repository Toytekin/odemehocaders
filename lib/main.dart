import 'package:atakansimsek/page/giris/giris.dart';
import 'package:atakansimsek/util/model/dersmodel.dart';
import 'package:atakansimsek/util/model/gunmodel.dart';
import 'package:atakansimsek/util/model/odenme_model.dart';
import 'package:atakansimsek/util/model/usermodel.dart';
import 'package:atakansimsek/util/services/base.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await Hive.initFlutter();

  //DErs Veri tabanı
  Hive.registerAdapter(DersModelAdapter());
  await Hive.openBox<DersModel>('ders');
  //Ogrenci Veri Tabanı
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>('users');
  //Gun Veri Tabanı
  Hive.registerAdapter(GunModelAdapter());
  await Hive.openBox<GunModel>('guns');

  //Odemem Veri tabani
  Hive.registerAdapter(OdemeModelAdapter());
  await Hive.openBox<OdemeModel>('odeme');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HiveVeriTabani(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Özel Ders Uygulamam',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const GirisSayfasi(),
    );
  }
}
