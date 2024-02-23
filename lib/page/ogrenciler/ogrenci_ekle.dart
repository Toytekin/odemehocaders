import 'package:atakansimsek/page/ogrenciler/ogrenciler.dart';
import 'package:atakansimsek/util/model/usermodel.dart';
import 'package:atakansimsek/util/services/base.dart';
import 'package:atakansimsek/util/widget/textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class OgrenciEkleSafasi extends StatefulWidget {
  final UserModel? userModel;
  const OgrenciEkleSafasi({
    super.key,
    this.userModel,
  });

  @override
  State<OgrenciEkleSafasi> createState() => _OgrenciEkleSafasiState();
}

class _OgrenciEkleSafasiState extends State<OgrenciEkleSafasi> {
  var adCntrl = TextEditingController();
  var soyAdCntrl = TextEditingController();
  var okulCntrl = TextEditingController();
  var telefonCntrl = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  DateTime _selectedDate2 = DateTime.now();

  final String mesaj =
      'Lütfen tüm alanları doldurduğunuza emin olduktan sonra tekrar deneyin !!!!';

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

  Future<DateTime?> _selectDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate2,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate2) {
      setState(() {
        _selectedDate2 = picked;
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
    if (widget.userModel != null) {
      adCntrl.text = widget.userModel!.userAD;
      soyAdCntrl.text = widget.userModel!.userSoyAD;
      okulCntrl.text = widget.userModel!.okul;
      telefonCntrl.text = widget.userModel!.userNumber;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Öğrenci Ekle Sayfasi'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SbtTextField(
                keybordTypr: true,
                controller: adCntrl,
                label: 'AD',
                widget: const Icon(Icons.person),
              ),
              SbtTextField(
                  keybordTypr: true,
                  controller: soyAdCntrl,
                  label: 'SOYAD',
                  widget: const Icon(Icons.person)),
              SbtTextField(
                  keybordTypr: false,
                  controller: telefonCntrl,
                  label: 'TEL',
                  widget: const Icon(Icons.phone)),
              SbtTextField(
                  keybordTypr: true,
                  controller: okulCntrl,
                  label: 'OKUL',
                  widget: const Icon(Icons.school_rounded)),
              datePickerDogumTarihi(context),
              datePickerKayitTarihi(context),
              ElevatedButton(
                  onPressed: () async {
                    if (adCntrl.text.isNotEmpty &&
                        soyAdCntrl.text.isNotEmpty &&
                        telefonCntrl.text.isNotEmpty &&
                        okulCntrl.text.isNotEmpty) {
                      var userID = const Uuid().v1();
                      UserModel newUser = UserModel(
                          userID: userID,
                          userAD: adCntrl.text,
                          userSoyAD: soyAdCntrl.text,
                          userNumber: telefonCntrl.text,
                          userDogumTarihi: formatDate(_selectedDate),
                          userKayitTarihi: formatDate(_selectedDate2),
                          okul: okulCntrl.text,
                          userOdemeYapti: false);
                      await context.read<HiveVeriTabani>().userSave(newUser);
                      fieldBosalt();
                      // ignore: use_build_context_synchronously
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OgrencilerSayfasi(),
                          ),
                          (route) => false);
                    } else {
                      diyalog(context);
                    }
                  },
                  child: const Text('Kaydet'))
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> diyalog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Card(
            child: ListTile(
              title: Text(mesaj),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Tamam'),
                  )
                ],
              ),
            ),
          ),
        );
      },
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

  Row datePickerKayitTarihi(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton.icon(
          onPressed: () async {
            final pickedDate = await _selectDate2(context);
            if (pickedDate != null) {
              setState(() {
                _selectedDate2 = pickedDate;
              });
            }
          },
          icon: const Icon(Icons.save),
          label: Text(
            formatDate(_selectedDate2),
          ),
        ),
      ],
    );
  }

  void fieldBosalt() {
    adCntrl.clear();
    soyAdCntrl.clear();
    telefonCntrl.clear();
    okulCntrl.clear();
  }
}
