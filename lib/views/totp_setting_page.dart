import 'package:flutter/material.dart';
import 'package:totp_generator/classes/setting.dart';

class TotpSettingPage extends StatefulWidget{
  final TotpParam param;

  const TotpSettingPage(this.param, {Key? key}) : super(key: key);

  @override
  State<TotpSettingPage> createState() => _TotpSettingPageState();  
}

class _TotpSettingPageState extends State<TotpSettingPage>{
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: panel(),
      )
    );
  }

  Widget panel(){
    var pa = widget.param;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Label("設定名 -Name"),
        TextFormField(
          initialValue: pa.name,
          onChanged: (s)=>setState(()=>pa.name = s),
        ),

        const SizedBox(height: 20),
        const _Label("変更間隔 -Time step"),
        DropdownButton(
          items: const [
            DropdownMenuItem(value: 30, child: Text("30s")),
            DropdownMenuItem(value: 60, child: Text("60s")),
          ],
          value: pa.step,
          onChanged: (i)=>setState(()=>pa.step = i ?? 30),
        ),


        const SizedBox(height: 20),
        const _Label("パスワード長 -Length"),
        DropdownButton(
          items: const [
            DropdownMenuItem(value: 6, child: Text("6")),
            DropdownMenuItem(value: 8, child: Text("8")),
          ],
          value: pa.length,
          onChanged: (i)=>setState(()=>pa.length = i ?? 6),
        ),
        
        const SizedBox(height: 20),
        const _Label("鍵種別 -Key type"),
        DropdownButton(
          items: const [
            DropdownMenuItem(value: "Base16", child: Text("Base16")),
            DropdownMenuItem(value: "Base32", child: Text("Bas32")),
            DropdownMenuItem(value: "ASCII", child: Text("ASCII")),
          ],
          value: pa.keyType,
          onChanged: (s)=>setState(()=>pa.keyType = s ?? "Base16"),
        ),

        const SizedBox(height: 20),
        const _Label("生成鍵 -Key value"),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          maxLines: null,
          initialValue: pa.key,
          onChanged: (s)=>setState(()=>pa.key = s),
        ),

        const SizedBox(height: 40),
        ButtonBar(
          children: [
            ElevatedButton(child: const Text("OK"), onPressed: ()=>{}),
            ElevatedButton(child: const Text("Cancel"), onPressed: ()=>{}),
          ],
        ),

        const SizedBox(height: 40),
        ButtonBar(
          children: [
            _DeleteButton(child: const Text("Delete"), onPressed: ()=>{}),
          ],
        )
      ]
    );
  }
}

class _DeleteButton extends ElevatedButton{
  static final ButtonStyle _style = ElevatedButton.styleFrom(side: const BorderSide(color: Colors.red, width: 1));
  _DeleteButton({super.child, super.onPressed}) : super(style: _style);
}

class _Label extends Text{
  const _Label(super.data) : super(style: const TextStyle(color: Colors.black45, fontSize: 14));
}