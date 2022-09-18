import 'package:flutter/material.dart';
import 'package:totp_generator/classes/setting.dart';
import 'package:totp_generator/classes/totp.dart';

class GenerateView extends StatefulWidget{
  const GenerateView({super.key});

  @override
  State<GenerateView> createState() => _GenerateViewState();
}

class _GenerateViewState extends State<GenerateView>{
  var _generatedValue = "";

  void _generateCode(){
    setState((){
      var gen = TOTPGenerator(
        key: Setting.key, keyType: Setting.keyType,
        length: Setting.length, step: Setting.step);
      try{
        _generatedValue = gen.generate(DateTime.now());
      } catch(e){
        _generatedValue = "------";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        SizedBox(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _CodeBlock(_generatedValue),
              const SizedBox( height: 30),
              _GenerateButton(onPressed:_generateCode),
            ],
          ),
        ),
      ]
    );
  }
}

class _GenerateButton extends StatelessWidget{
  final void Function()? onPressed;

  const _GenerateButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.green)
      ),
      child: const Padding(
        padding: EdgeInsets.all(5),
        child: Text("コード生成", style: TextStyle(fontSize: 26)),
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget{
  final String text;

  const _CodeBlock(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueGrey)
      ),
      child: SelectableText(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 36),
      ),
    );
  }
}