import 'package:shared_preferences/shared_preferences.dart';

class Setting{
  static var key = "";
  static var step = 60;
  static var length = 8;

  static load() async{
    var sp = await SharedPreferences.getInstance();
    key = sp.getString("key") ?? "";
    step = sp.getInt("step") ?? 60;
    length = sp.getInt("length") ?? 8;
  }
  static save() async{
    var sp = await SharedPreferences.getInstance();
    sp.setString("key", key);
    sp.setInt("step", step);
    sp.setInt("length", length);
  }
}