import 'package:atakansimsek/page/giris/giris.dart';
import 'package:atakansimsek/page/odeme/odeme_ekle.dart';
import 'package:atakansimsek/page/odeme/odeme_guncelle.dart';
import 'package:atakansimsek/page/ogrenciler/ogrenciler.dart';
import 'package:atakansimsek/util/model/odenme_model.dart';
import 'package:atakansimsek/util/model/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class OdemelerSayfasi extends StatefulWidget {
  final UserModel userModel;
  const OdemelerSayfasi({
    super.key,
    required this.userModel,
  });

  @override
  State<OdemelerSayfasi> createState() => _OdemelerSayfasiState();
}

class _OdemelerSayfasiState extends State<OdemelerSayfasi> {
  var odemeHive = Hive.box<OdemeModel>('odeme');
  List<OdemeModel> odemeler = [];

  final String appbarTitle = 'Ödemeler';

  @override
  void initState() {
    super.initState();
    odemGtir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(appbarTitle),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OgrencilerSayfasi(),
                ),
              );
            },
            icon: const Icon(Icons.arrow_back)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GirisSayfasi(),
                  ),
                );
              },
              icon: const Icon(Icons.home))
        ],
      ),
      body: Center(
        child: odemeler.isNotEmpty
            ? ListView.builder(
                itemCount: odemeler.length,
                itemBuilder: (context, index) {
                  var odeme = odemeler[index];
                  var odemeSirasi = index + 1;

                  return Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OdemeGuncelleGiris(
                                odemeModel: odeme, userModel: widget.userModel),
                          ),
                        );
                      },
                      leading: Text(odemeSirasi.toString()),
                      title: Text(formatDate(odeme.tarihi)),
                      subtitle: Text(
                        '${odeme.miktar} TL',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              )
            : const SizedBox(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  OdemeEkleEkrani(userModel: widget.userModel),
            ),
          );
        },
        child: const Icon(Icons.attach_money),
      ),
    );
  }

  String formatDate(DateTime date) {
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString().substring(2);
    return '$day.$month.$year';
  }

  odemGtir() async {
    if (odemeHive.isEmpty) {
      debugPrint('VEri Yok');
    } else {
      for (var element in odemeHive.values) {
        if (element.userID == widget.userModel.userID) {
          odemeler.add(element);
        }
      }

      // Odemeleri tarihine göre sıralama
      odemeler.sort((a, b) => b.tarihi.compareTo(a.tarihi));
      setState(() {});
    }
  }
}
