import 'package:atakansimsek/page/dersler/gunler.dart';
import 'package:atakansimsek/page/giris/giris.dart';
import 'package:atakansimsek/util/model/dersmodel.dart';
import 'package:atakansimsek/util/model/gunmodel.dart';
import 'package:atakansimsek/util/model/usermodel.dart';
import 'package:atakansimsek/util/services/base.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GunSayfasi extends StatefulWidget {
  final DersModel dersModel;
  final String gun;
  const GunSayfasi({
    super.key,
    required this.dersModel,
    required this.gun,
  });

  @override
  State<GunSayfasi> createState() => _GunSayfasiState();
}

class _GunSayfasiState extends State<GunSayfasi> {
  List<GunModel> gunlerGetir = [];
  List<UserModel> kisiler = [];
  final String uyariMesaji = 'Gün Boşaltılsın mı?';

  final DateTime _selectedDate = DateTime.now();

  final String mesaj =
      'Lütfen tüm alanları doldurduğunuza emin olduktan sonra tekrar deneyin !!!!';

  String formatDate(DateTime date) {
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString().substring(2);
    return '$day.$month.$year';
  }

  @override
  void initState() {
    super.initState();
    gunleriCek();
    getAlUsers();
  }

  Future<void> gunleriCek() async {
    gunlerGetir = await context
        .read<HiveVeriTabani>()
        .getFilterGuns(widget.dersModel, widget.gun);

    setState(() {});
  }

  Future<void> getAlUsers() async {
    kisiler = await context.read<HiveVeriTabani>().getAllUsers();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.gun),
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
        body: Center(
          child: ListView.builder(
            itemCount: gunlerGetir.length,
            itemBuilder: (context, index) {
              var gunData = gunlerGetir[index];

              return InkWell(
                onTap: () {
                  if (gunData.gunDolumu == false) {
                    diyalog(context, gunData);
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(uyariMesaji),
                          actions: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent),
                              onPressed: () async {
                                var gunModel = GunModel(
                                  gunID: gunData.gunID,
                                  gunAdi: gunData.gunAdi,
                                  gunSaati: gunData.gunSaati,
                                  gunDolumu: false,
                                  dersID: gunData.dersID,
                                  userModel: null,
                                );
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const GirisSayfasi(),
                                    ),
                                    (route) => false);
                                await context
                                    .read<HiveVeriTabani>()
                                    .gunUpdate(gunModel);
                              },
                              child: const Text(
                                'Evet',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Hayır'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Card(
                  color: gunData.gunDolumu ? Colors.redAccent : Colors.white,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(gunData.gunSaati),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              if (gunData.userModel != null) ...[
                                Text(
                                  ' ${gunData.userModel!.userAD} ${gunData.userModel!.userSoyAD}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Kayıt Tarihi : ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(gunData.userModel!.userKayitTarihi ??
                                        ''),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Ödeme Durumu : ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    gunData.userModel!.userOdemeYapti
                                        ? const Text('Yaptı')
                                        : const Text('Yapmadı'),
                                  ],
                                ),
                              ] else
                                const SizedBox(),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }

  Future<dynamic> diyalog(BuildContext context, GunModel gunData) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Kişi Listesi'),
          content: SingleChildScrollView(
            child: ListBody(
              children: kisiler
                  .map(
                    (kisi) => ListTile(
                      onTap: () async {
                        var updateGun = GunModel(
                          gunID: gunData.gunID,
                          gunAdi: gunData.gunAdi,
                          gunSaati: gunData.gunSaati,
                          gunDolumu: true,
                          dersID: gunData.dersID,
                          userModel: kisi,
                        );
                        var kisiUpdate = UserModel(
                            userID: kisi.userID,
                            userAD: kisi.userAD,
                            userSoyAD: kisi.userSoyAD,
                            userNumber: kisi.userNumber,
                            userDogumTarihi: kisi.userDogumTarihi,
                            userOdemeYapti: kisi.userOdemeYapti,
                            okul: kisi.okul,
                            userKayitTarihi: formatDate(_selectedDate));
                        await context
                            .read<HiveVeriTabani>()
                            .userSave(kisiUpdate);
                        // ignore: use_build_context_synchronously
                        await context
                            .read<HiveVeriTabani>()
                            .gunUpdate(updateGun);

                        // ignore: use_build_context_synchronously
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  GunlerSayfasi(dersModel: widget.dersModel),
                            ),
                            (route) => false);
                      },
                      title: Text('${kisi.userAD}  ${kisi.userSoyAD}'),
                    ),
                  )
                  .toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Diyalog ekranını kapat
              },
              child: const Text('Kapat'),
            ),
          ],
        );
      },
    );
  }
}
