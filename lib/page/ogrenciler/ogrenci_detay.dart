import 'package:atakansimsek/page/giris/giris.dart';
import 'package:atakansimsek/page/odeme/odeme_giris.dart';
import 'package:atakansimsek/page/ogrenciler/ogrenci_ekle.dart';
import 'package:atakansimsek/util/model/usermodel.dart';
import 'package:atakansimsek/util/services/base.dart';
import 'package:atakansimsek/util/widget/sbt_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OgrenciDetaySayfasi extends StatefulWidget {
  final UserModel userModel;
  const OgrenciDetaySayfasi({
    super.key,
    required this.userModel,
  });

  @override
  State<OgrenciDetaySayfasi> createState() => _OgrenciDetaySayfasiState();
}

class _OgrenciDetaySayfasiState extends State<OgrenciDetaySayfasi> {
  final DateTime _selectedDate = DateTime.now();

  final String dgmtarihi = 'Doğum Tarihi';
  final String tel = 'Telefon Numarası';
  final String kayitTarihi = 'Kayıt Tarihi';
  final String odemeTarihi = 'Ödeme Tarihi';
  final String odemeYap = 'Ödeme Tamamlandı';
  final String odemeMiktari = 'Ödeme Al';
  final String guncelle = 'Güncelle';
  final String okul = 'Okul';
  final String kisiSil = 'Sil';

  final TextEditingController _textController = TextEditingController();

  String formatDate(DateTime date) {
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString().substring(2);
    return '$day.$month.$year';
  }

  @override
  void initState() {
    super.initState();
    // Check for phone call support.
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {});
    });
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(widget.userModel.userAD + widget.userModel.userSoyAD),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Kişi Silinsin mi?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pop(); // Diyalog ekranını kapat
                            },
                            child: const Text('İptal'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await context
                                  .read<HiveVeriTabani>()
                                  .userDelete(widget.userModel);
                              setState(() {});
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => const GirisSayfasi(),
                                  ),
                                  (route) => false);
                            },
                            child: Text(kisiSil),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                ))
          ],
        ),
        body: Center(
          child: Column(
            children: [
              SbtCard(
                title: dgmtarihi,
                subTitle: widget.userModel.userDogumTarihi,
                icon: const Icon(Icons.cake),
              ),
              InkWell(
                onTap: () {
                  _makePhoneCall(widget.userModel.userNumber);
                },
                child: SbtCard(
                  title: tel,
                  subTitle: widget.userModel.userNumber,
                  icon: const Icon(Icons.phone),
                ),
              ),
              SbtCard(
                title: okul,
                subTitle: widget.userModel.okul,
                icon: const Icon(Icons.school_rounded),
              ),
              SbtCard(
                title: kayitTarihi,
                subTitle: widget.userModel.userKayitTarihi ?? '',
                icon: const Icon(Icons.date_range),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OdemelerSayfasi(userModel: widget.userModel),
                      ),
                    );
                  },
                  title: Text(odemeMiktari),
                  leading: const Icon(Icons.monetization_on),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OgrenciEkleSafasi(
                                userModel: widget.userModel,
                              ),
                            ),
                          );
                        },
                        child: Text(guncelle))
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  ElevatedButton odemeAlma(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Ödeme Miktarını Girin'),
                content: TextField(
                  controller: _textController,
                  decoration:
                      const InputDecoration(hintText: 'Bir şeyler yazın'),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Diyalog ekranını kapat
                    },
                    child: const Text('İptal'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // TextField'da girilen metni kullanabilirsiniz
                      String enteredText = _textController.text;
                      var newUser = UserModel(
                        userID: widget.userModel.userID,
                        userAD: widget.userModel.userAD,
                        userSoyAD: widget.userModel.userSoyAD,
                        userNumber: widget.userModel.userNumber,
                        okul: widget.userModel.okul,
                        userDogumTarihi: widget.userModel.userDogumTarihi,
                        userOdemeYapti: true,
                        userKayitTarihi: widget.userModel.userKayitTarihi ?? '',
                        odemeMiktari: enteredText,
                        userOdemeTarihi: formatDate(_selectedDate),
                      );
                      await context.read<HiveVeriTabani>().userSave(newUser);
                      setState(() {});
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const GirisSayfasi(),
                          ),
                          (route) => false);
                    },
                    child: Text(odemeYap),
                  ),
                ],
              );
            },
          );
        },
        child: Text(odemeYap));
  }
}
