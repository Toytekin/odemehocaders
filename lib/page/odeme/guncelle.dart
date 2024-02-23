import 'package:atakansimsek/page/giris/giris.dart';
import 'package:atakansimsek/page/odeme/odeme_giris.dart';
import 'package:atakansimsek/util/model/odenme_model.dart';
import 'package:atakansimsek/util/model/usermodel.dart';
import 'package:atakansimsek/util/services/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class OdemeGuncelle extends StatefulWidget {
  final UserModel userModel;
  final OdemeModel odemeModel;
  const OdemeGuncelle({
    super.key,
    required this.userModel,
    required this.odemeModel,
  });

  @override
  State<OdemeGuncelle> createState() => _OdemeGuncelleState();
}

class _OdemeGuncelleState extends State<OdemeGuncelle> {
  var miktarController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  Future<DateTime?> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1980),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      return picked;
    }
    return null;
  }

  String formatDate(DateTime date) {
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString().substring(2);
    return '$day.$month.$year';
  }

  @override
  void initState() {
    super.initState();
    miktarController.text = widget.odemeModel.miktar.toString();
    _selectedDate = widget.odemeModel.tarihi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ödeme  Güncelle'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GirisSayfasi()),
                );
              },
              icon: const Icon(Icons.home_filled))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: miktarController,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter.singleLineFormatter,
              ],
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Sadece Rakam Giriniz',
              ),
            ),
            datePickerDogumTarihi(context),
            ElevatedButton(
                onPressed: () async {
                  if (miktarController.text.isNotEmpty) {
                    int? sayi = int.tryParse(miktarController.text);

                    if (sayi != null) {
                      var odeme = OdemeModel(
                        userID: widget.userModel.userID,
                        odemeID: widget.odemeModel.odemeID,
                        tarihi: _selectedDate,
                        miktar: sayi,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                OdemelerSayfasi(userModel: widget.userModel)),
                      );
                      await context.read<HiveVeriTabani>().odemeEkle(odeme);
                    } else {
                      debugPrint('Geçersiz sayı formatı');
                    }
                  }
                },
                child: const Text('Ödemeyi Kaydet'))
          ],
        ),
      ),
    );
  }

  Row datePickerDogumTarihi(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton.icon(
          onPressed: () async {
            final pickedDate = await _selectDate(context);
            if (pickedDate != null) {
              setState(() {
                _selectedDate = pickedDate;
              });
            }
          },
          icon: const Icon(Icons.cake),
          label: Text(
            formatDate(_selectedDate),
          ),
        ),
      ],
    );
  }
}
