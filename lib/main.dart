import 'package:flutter/material.dart';
import 'package:totp_generator/classes/setting.dart';
import 'package:totp_generator/generate_view.dart';
import 'package:totp_generator/setting_view.dart';

void main() async{
  runApp(const MyApp());
  await Setting.load();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TOTP Generator',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child:  Scaffold(
        bottomNavigationBar: Container(
          color: Colors.green,
          child: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.pin)),
              Tab(icon: Icon(Icons.settings)),
            ]
          ),
        ),
        body: const TabBarView(
          children: [
            GenerateView(),
            SettingView(),
          ],
        ),
      ),
    );
  }
}