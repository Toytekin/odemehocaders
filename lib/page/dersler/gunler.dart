import 'package:atakansimsek/page/dersler/dersler.dart';
import 'package:atakansimsek/page/dersler/gun.dart';
import 'package:atakansimsek/page/giris/giris.dart';
import 'package:atakansimsek/util/model/dersmodel.dart';
import 'package:flutter/material.dart';

class GunlerSayfasi extends StatefulWidget {
  final DersModel dersModel;
  const GunlerSayfasi({
    super.key,
    required this.dersModel,
  });

  @override
  State<GunlerSayfasi> createState() => _GunlerSayfasiState();
}

class _GunlerSayfasiState extends State<GunlerSayfasi> {
  List<String> gunAdlari = [
    'Pazartesi',
    'Salı',
    'Çarşamba',
    'Perşembe',
    'Cuma',
    'Cumartesi',
    'Pazar'
  ];

  @override
  void initState() {
    super.initState();
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
                  builder: (context) => const DerslerSayfasi(),
                ),
              );
            },
            icon: const Icon(Icons.arrow_back)),
        title: Row(
          children: [
            Text(widget.dersModel.desAdi),
            const Spacer(),
          ],
        ),
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
      body: GridView.builder(
        itemCount: gunAdlari.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GunSayfasi(
                    dersModel: widget.dersModel,
                    gun: gunAdlari[index],
                  ),
                ),
              );
            },
            child: Card(
              child: Center(
                child: Text(
                  gunAdlari[index],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
