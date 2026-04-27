import 'dart:convert';

import 'package:flutter/material.dart';

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
    debugPrint(okunanString);
    debugPrint("******************");
    List arabaListesi=jsonObject;
    debugPrint(arabaListesi[1]['model'][0]['fiyat'].toString());
  }
}