import 'package:atakansimsek/page/dersler/gunler.dart';
import 'package:atakansimsek/page/giris/giris.dart';
import 'package:atakansimsek/util/model/dersmodel.dart';
import 'package:atakansimsek/util/services/base.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class DerslerSayfasi extends StatefulWidget {
  const DerslerSayfasi({super.key});

  @override
  State<DerslerSayfasi> createState() => _DerslerSayfasiState();
}

class _DerslerSayfasiState extends State<DerslerSayfasi> {
  final _textController = TextEditingController();
  final String dersEkle = 'Hoca Ekle';

  List<DersModel> allDers = [];

  @override
  void initState() {
    super.initState();
    getDers();
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
        title: const Text('Hocalar'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: allDers.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GunlerSayfasi(
                        dersModel: allDers[index],
                      ),
                    ),
                  );
                },
                leading: const Icon(Icons.book),
                title: Text(allDers[index].desAdi),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Ders Kitabı Adı'),
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
                      var dersID = const Uuid().v1();
                      var dersModel =
                          DersModel(dersID: dersID, desAdi: enteredText);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GirisSayfasi()),
                      );
                      if (_textController.text.isNotEmpty) {
                        await context
                            .read<HiveVeriTabani>()
                            .dersSave(dersModel);

                        // ignore: use_build_context_synchronously
                        await context.read<HiveVeriTabani>().gunSave(dersModel);
                      }
                    },
                    child: Text(dersEkle),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.book),
      ),
    );
  }

  Future<void> getDers() async {
    allDers = await context.read<HiveVeriTabani>().getAllDers();
    setState(() {});
  }
}
