import 'package:atakansimsek/page/odeme/guncelle.dart';
import 'package:atakansimsek/page/odeme/odeme_giris.dart';
import 'package:atakansimsek/util/model/odenme_model.dart';
import 'package:atakansimsek/util/model/usermodel.dart';
import 'package:atakansimsek/util/services/base.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OdemeGuncelleGiris extends StatefulWidget {
  final UserModel userModel;
  final OdemeModel odemeModel;
  const OdemeGuncelleGiris({
    super.key,
    required this.odemeModel,
    required this.userModel,
  });

  @override
  State<OdemeGuncelleGiris> createState() => _OdemeGuncelleGirisState();
}

class _OdemeGuncelleGirisState extends State<OdemeGuncelleGiris> {
  final String appbarTitile = 'Ödeme Güncelle';
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(appbarTitile),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: SizedBox(
                width: size.height / 2,
                height: size.height / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.userModel.userAD}  ${widget.userModel.userSoyAD}',
                      style: const TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(widget.userModel.okul),
                    Text(widget.userModel.userNumber),
                    Text(
                      '${widget.odemeModel.miktar} TL',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 17, 86, 19),
                      ),
                    ),
                    Text(formatDate(widget.odemeModel.tarihi)),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OdemelerSayfasi(
                          userModel: widget.userModel,
                        ),
                      ),
                    );

                    await context
                        .read<HiveVeriTabani>()
                        .odemeDelete(widget.odemeModel);
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text('Sil'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OdemeGuncelle(
                            odemeModel: widget.odemeModel,
                            userModel: widget.userModel),
                      ),
                    );
                  },
                  icon: const Icon(Icons.update),
                  label: const Text('Güncelle'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString();
    return '$day.$month.$year';
  }
}
