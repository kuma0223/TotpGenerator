import 'dart:math';

import 'package:flutter/material.dart';
import 'package:totp_generator/classes/setting.dart';
import 'package:totp_generator/views/generate_page.dart';
import 'package:totp_generator/views/totp_setting_page.dart';

void main() async{
  var app = const MyApp();
  await app.load();
  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static Setting setting = Setting();
  static TotpParam param = TotpParam();

  Future<void> load() async{
    await setting.load();
    if(setting.params.isEmpty){
      setting.params.add(TotpParam());
    }
    setting.selected = min(setting.selected, setting.params.length-1);
    param = setting.params[setting.selected];
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'TOTP Generator',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GeneratePage()
      );
  }
}
