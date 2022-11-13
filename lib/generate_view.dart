import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:totp_generator/classes/setting.dart';
import 'package:totp_generator/classes/totp.dart';

class GenerateView extends StatefulWidget{
  const GenerateView({super.key});

  @override
  State<GenerateView> createState() => _GenerateViewState();
}

class _GenerateViewState extends State<GenerateView>{
  String _generatedValue = "";
  DateTime? _generatedTime;
  Timer? _timer;
  int _limit = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 100), timerTick);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void timerTick(Timer timer){
    if(_generatedValue.isEmpty) return;
    var step = Setting.step;
    var start = DateTime.fromMillisecondsSinceEpoch(_generatedTime!.millisecondsSinceEpoch ~/ 1000 ~/ step * step * 1000);
    var span = DateTime.now().difference(start);
    setState((){
      _limit = max(Setting.step - span.inSeconds, 0);
      if(_limit == 0){
        _generatedValue = "";
        //_generatedTime = null;
      }
    });
  }

  void _generateCode(){
    setState((){
      var gen = TOTPGenerator(
        key: Setting.key, keyType: Setting.keyType,
        length: Setting.length, step: Setting.step);
      try{
        var now = DateTime.now();
        _generatedValue = gen.generate(now);
        _generatedTime = now;
      } catch(e){
        _generatedValue = "------";
      }
    });
  }

  void _copyCode(){
    if(_generatedValue == "") return;
    Clipboard.setData(ClipboardData(text:_generatedValue));
    const snackBar = SnackBar(content: Text('パスワードをコピーしました'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
              Row(
                children: [
                  _TimeLimit(_limit),
                  Expanded(child: Container()),
                  IconButton(icon: const Icon(Icons.content_copy), onPressed: _copyCode),
                ],
              ),
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
        //backgroundColor: MaterialStatePropertyAll(Colors.green)
      ),
      child: const Padding(
        padding: EdgeInsets.all(5),
        child: Text("パスワード生成", style: TextStyle(fontSize: 26)),
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

class _TimeLimit extends StatelessWidget{
  final int limit;

  const _TimeLimit(this.limit);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Icon(Icons.update, color: Colors.blueGrey),
        const SizedBox(width: 2),
        Text(limit>0 ? "$limit" : "", textAlign: TextAlign.right, style: const TextStyle(fontSize: 20)),
      ],
    );
  }
}