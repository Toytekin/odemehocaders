import 'package:atakansimsek/page/odeme/odeme_giris.dart';
import 'package:atakansimsek/util/model/odenme_model.dart';
import 'package:atakansimsek/util/model/usermodel.dart';
import 'package:atakansimsek/util/services/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class OdemeEkleEkrani extends StatefulWidget {
  final UserModel userModel;
  const OdemeEkleEkrani({
    super.key,
    required this.userModel,
  });

  @override
  State<OdemeEkleEkrani> createState() => _OdemeEkleEkraniState();
}

class _OdemeEkleEkraniState extends State<OdemeEkleEkrani> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Odeme'),
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
                      var oddemeID = const Uuid().v1();
                      var odeme = OdemeModel(
                        userID: widget.userModel.userID,
                        odemeID: oddemeID,
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
