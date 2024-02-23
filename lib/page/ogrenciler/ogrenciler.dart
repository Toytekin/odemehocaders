import 'package:atakansimsek/page/giris/giris.dart';
import 'package:atakansimsek/page/ogrenciler/ogrenci_detay.dart';
import 'package:atakansimsek/page/ogrenciler/ogrenci_ekle.dart';
import 'package:atakansimsek/util/model/usermodel.dart';
import 'package:atakansimsek/util/services/base.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OgrencilerSayfasi extends StatefulWidget {
  const OgrencilerSayfasi({super.key});

  @override
  State<OgrencilerSayfasi> createState() => _OgrencilerSayfasiState();
}

class _OgrencilerSayfasiState extends State<OgrencilerSayfasi> {
  List<UserModel> allUsers = [];
  final String mesaj = 'Henüz öğrenci eklenmedi';
  @override
  void initState() {
    super.initState();
    getAlUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GirisSayfasi(),
                ),
              );
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Öğrenciler'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GirisSayfasi()),
              );
            },
            icon: const Icon(Icons.home),
          )
        ],
      ),
      body: SafeArea(
          child: Center(
        child: ListView.builder(
          itemCount: allUsers.length,
          itemBuilder: (context, index) {
            var user = allUsers[index];

            if (allUsers.isNotEmpty) {
              return Card(
                color: user.userOdemeYapti ? Colors.amber : Colors.white,
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              OgrenciDetaySayfasi(userModel: user)),
                    );
                  },
                  title: Text('${user.userAD}  ${user.userSoyAD}'),
                  subtitle: Text(user.userNumber),
                  leading: const Icon(Icons.person),
                ),
              );
            } else {
              return Center(
                child: Text(mesaj),
              );
            }
          },
        ),
      )),
      floatingActionButton: floatButon(context),
    );
  }

  FloatingActionButton floatButon(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OgrenciEkleSafasi()),
        );
      },
      child: const Icon(Icons.person_add_alt_1),
    );
  }

  Future<void> getAlUsers() async {
    allUsers = await context.read<HiveVeriTabani>().getAllUsers();
    setState(() {});
  }
}
