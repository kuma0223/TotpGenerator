import 'package:shared_preferences/shared_preferences.dart';

class Setting{
  static var step = 60;
  static var length = 8;
  static var key = "";
  static var keyType = "Base16";

  static load() async{
    var sp = await SharedPreferences.getInstance();
    step = sp.getInt("step") ?? 60;
    length = sp.getInt("length") ?? 8;
    key = sp.getString("key") ?? "";
    keyType = sp.getString("keyType") ?? "Base16";
  }
  static save() async{
    var sp = await SharedPreferences.getInstance();
    sp.setInt("step", step);
    sp.setInt("length", length);
    sp.setString("key", key);
    sp.setString("keyType", keyType);
  }
}