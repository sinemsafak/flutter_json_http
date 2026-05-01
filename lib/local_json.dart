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
    arabalarJsonOku();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Json Islemleri'),
      ), // AppBar
      body: const Center(),
    ); // Scaffold
  }
    arabalarJsonOku() async {
    String okunanString=await DefaultAssetBundle.of(context).loadString('assets/data/arabalar.json');

    var jsonObject=jsonDecode(okunanString);
    //debugPrint(okunanString);
    //debugPrint("******************");
    /*
    List arabaListesi=jsonObject;
    debugPrint(arabaListesi[1]['model'][0]['fiyat'].toString());*/

    List<Araba> tumArabalar=(jsonObject as List).map((arabaMap) => Araba.fromJson(arabaMap)).toList();
    debugPrint(tumArabalar[0].model[0].modelAdi);
    debugPrint(tumArabalar.length.toString());
  }
}