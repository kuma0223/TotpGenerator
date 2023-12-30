import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:totp_generator/components/datetime_select.dart';
import 'package:totp_generator/components/xbutton.dart';
import 'package:totp_generator/main.dart';

class GeneratePage extends StatefulWidget{
  const GeneratePage({super.key});
  
  @override
  State<GeneratePage> createState() => _GeneratePageState();
}

class _GeneratePageState extends State<GeneratePage>{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        header(),
        Expanded(child: Text("expand")),
        footer(),
      ],
    );
  }

  Widget header(){
    return Row(
      children: [
        Expanded(
          child: XButton(text: MyApp.param.name, transparent: true, onPressed: ()=>{}),
        ),
        XButton(child: const Icon(Icons.settings), transparent: true, onPressed: ()=>{}),
      ]
    );
  }
  
  Widget footer(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _GenerateButton(onPressed: ()=>{}),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DatetimeSelect(time: DateTime.now(), onChanged: (v)=>{}),
              const SizedBox(width: 5),
              ElevatedButton(child: const Text("Now"), onPressed: ()=>{}),
            ],),
        ),
      ],
    );
  }
}

class _GenerateButton extends ElevatedButton {
  const _GenerateButton({super.onPressed}) : super(
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.arrow_upward),
        Text("GENERATE"),
      ],
    ),
  );
}