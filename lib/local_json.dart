import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_json_http/model/araba_model.dart';

class LocalJson extends StatefulWidget {
  const LocalJson({Key? key}) : super(key: key);

  @override
  State<LocalJson> createState() => _LocalJsonState();
}

class _LocalJsonState extends State<LocalJson> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Local Json Islemleri')), // AppBar
      body: FutureBuilder<List<Araba>>(
        future: arabalarJsonOku(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Araba> arabaListesi = snapshot.data!;
            return ListView.builder(
              itemCount: arabaListesi.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(arabaListesi[index].arabaAdi),
                  subtitle: Text(arabaListesi[index].ulke),
                  leading: CircleAvatar(
                    child: Text(arabaListesi[index].model[0].fiyat.toString()),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    ); // Scaffold
  }

  Future<List<Araba>> arabalarJsonOku() async {
    try {
      await Future.delayed(const Duration(seconds: 5), (){
        return Future.error( '5 saniye sonraa hata çıktı' );
      });
      String okunanString = await DefaultAssetBundle.of(
        context,
      ).loadString('assets/data/arabalar.json');

      var jsonObject = jsonDecode(okunanString);
      //debugPrint(okunanString);
      //debugPrint("******************");
      /*
    List arabaListesi=jsonObject;
    debugPrint(arabaListesi[1]['model'][0]['fiyat'].toString());*/

      List<Araba> tumArabalar = (jsonObject as List)
          .map((arabaMap) => Araba.fromJson(arabaMap))
          .toList();
      debugPrint(tumArabalar.length.toString());

      return tumArabalar;
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e.toString());
    }
  }
}
