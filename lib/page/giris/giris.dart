// ignore_for_file: must_be_immutable

import 'package:atakansimsek/page/dersler/dersler.dart';
import 'package:atakansimsek/page/ogrenciler/ogrenciler.dart';
import 'package:flutter/material.dart';

class GirisSayfasi extends StatefulWidget {
  const GirisSayfasi({super.key});

  @override
  State<GirisSayfasi> createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {
  final String dersler = 'Dersler';
  final String ogrnciler = 'Öğrenciler';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            KartlarimWidget(
              color: Colors.greenAccent,
              label: dersler,
              widget: Icon(
                Icons.book,
                size: size.height / 12,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DerslerSayfasi(),
                  ),
                );
              },
            ),
            KartlarimWidget(
              color: Colors.orange,
              label: ogrnciler,
              widget: Icon(
                Icons.school,
                size: size.height / 12,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OgrencilerSayfasi()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class KartlarimWidget extends StatelessWidget {
  final String label;
  final Widget widget;
  void Function() onTap;
  final Color color;

  KartlarimWidget({
    super.key,
    required this.label,
    required this.widget,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          color: color,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget,
                Text(
                  label,
                  style: TextStyle(fontSize: size.height / 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
