import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:totp_generator/classes/setting.dart';

class SettingView extends StatefulWidget{
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView>{
  //static const _heddingStyle = TextStyle(color: Colors.green, fontWeight: FontWeight.bold);

  void save(Function() func){
    setState(func);
    Setting.save();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          _TextItem(
            title: "生成キー",
            value: Setting.key,
            onInputed: (value){
              if(value == null) return;
              save(()=>Setting.key=value);
            },
          ),
          
          _SelectItem(
            title: "キーフォーマット",
            value: Setting.keyType,
            options: const [["Base16", "Base16"], ["Base32", "Base32"], ["ASCII", "ASCII"]],
            onSelected: (value){
              if(value == null) return;
              save(()=>Setting.keyType=value);
            }
          ), 

          _SelectItem(
            title: "時間ステップ",
            value: "${Setting.step}秒",
            options: const [["30秒", 30], ["60秒", 60]],
            onSelected: (value){
              if(value == null) return;
              save(()=>Setting.step=value);
            }
          ), 

          _SelectItem(
            title: "パスワード長",
            value: "${Setting.length}",
            options: const [["6", 6], ["8", 8]],
            onSelected: (value){
              if(value == null) return;
              save(()=>Setting.length=value);
            }
          ),

          _SelectItem(
            title: "シード種類",
            value: SeedTypes.getName(Setting.seedType),
            options: [
              [SeedTypes.getName(SeedTypes.now), SeedTypes.now],
              [SeedTypes.getName(SeedTypes.shift), SeedTypes.shift],
              [SeedTypes.getName(SeedTypes.hold), SeedTypes.hold],
            ],
            onSelected: (value){
              if(value == null) return;
              save(()=>Setting.seedType=value);
            }
          ),

          Visibility(
            visible: Setting.seedType == SeedTypes.hold,
            child: _EpocSecItem(
              title: "指定日時",
              value: Setting.seedHoldTime,
              onInputed: (value){
                //if(value == null) return;
                save(()=>Setting.seedHoldTime=value);
              },
            ),
          ),

        ],
      ),
    );
  }
}

class _TextItem extends StatelessWidget{
  final String title;
  final String value;
  final Function(String?)? onInputed;

  const _TextItem({ required this.title, required this.value, this.onInputed });

  void pressed(BuildContext context) async{
    var tcontroller = TextEditingController(text: value);

    var ret = await showDialog(
      context: context,
      builder: (_) => Dialog(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: 250,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(
                controller: tcontroller,
                maxLines: 3,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: ()=> Navigator.pop(context, tcontroller.value.text),
                child: const Text("OK"))
            ]),
        ),
      )
    );
    onInputed?.call(ret);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(20),
        foregroundColor: Colors.black,
      ),
      onPressed: onInputed==null ? null : () => pressed(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black54)),
        ],
      ),
    );
  }
}

class _SelectItem extends StatelessWidget{
  final String title;
  final String value;
  final List<List> options;
  final Function(dynamic)? onSelected;

  const _SelectItem({required this.title, required this.value, required this.options, this.onSelected });
 
  void pressed(BuildContext context) async{
    var dialogOptions = options.map((x)=>SimpleDialogOption(
        child: Text(x[0]),
        onPressed: ()=>Navigator.pop(context, x[1]),
      )).toList();

      var ret = await showDialog(
        context: context,
        builder: (_) => SimpleDialog(
          title: Text(title),
          children: dialogOptions
        ),
      );
      onSelected?.call(ret);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(20),
        foregroundColor: Colors.black,
      ),
      onPressed: onSelected==null ? null : ()=>pressed(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black54)),
        ],
      ),
    );
  }
}

class _EpocSecItem extends StatelessWidget{
  final String title;
  final int value;
  final Function(int)? onInputed;

  const _EpocSecItem({required this.title, required this.value, this.onInputed });
 
  void pressed(BuildContext context) async{
    DatePicker.showDateTimePicker(
      context,
      minTime: DateTime.fromMicrosecondsSinceEpoch(0),
      onConfirm: (date) {
        onInputed?.call(date.millisecondsSinceEpoch);
      },
      currentTime: DateTime.fromMillisecondsSinceEpoch(value),
      locale: LocaleType.jp
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(20),
        foregroundColor: Colors.black,
      ),
      onPressed: onInputed==null ? null : () => pressed(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
          Text(toDateString(value), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black54)),
        ],
      ),
    );
  }

  String toDateString(int v){
    var d = DateTime.fromMillisecondsSinceEpoch(v);
    return "${d.year}/${d.month}/${d.day} "
      "${d.hour.toString().padLeft(2,"0")}:${d.minute.toString().padLeft(2,"0")}:${d.second.toString().padLeft(2,"0")}"; 
  }
}