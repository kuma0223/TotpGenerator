import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Setting{
  List<TotpParam> params = [];
  int selected = 0;

  Future<void> load() async{
    var sp = await SharedPreferences.getInstance();
    Map<String, dynamic> obj = jsonDecode(sp.getString("setting") ?? "{}");
    params = List.from((obj["params"] as List?)?.map((e) => TotpParam.fromJson(e)) ?? []);
    selected = obj["selected"] ?? 0;
  }
  Future<void> save() async{
    var sp = await SharedPreferences.getInstance();
    var obj = {
      "params": params,
      "selected": selected,
    };
    sp.setString("setting", jsonEncode(obj));
  }
}

class TotpParam{
  var name = "Empty Token";
  var step = 60;
  var length = 8;
  var key = "";
  /// Base16 | Base32 | ASCII
  var keyType = "Base16";

  TotpParam();

  TotpParam.fromJson(Map<String, dynamic> x){
    name = x["name"] ?? name;
    step = x["step"] ?? step;
    length = x["length"] ?? length;
    key = x["key"] ?? key;
    keyType = x["keyType"] ?? keyType;
  }

  dynamic toJson(){
    return {
      "name" : name,
      "step" : step,
      "length" : length,
      "key" : key,
      "keyType" : keyType,
    };
  }

  TotpParam copy(){
    return TotpParam.fromJson(jsonDecode(jsonEncode(this)));
  }
}
