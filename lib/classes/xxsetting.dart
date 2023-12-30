import 'package:shared_preferences/shared_preferences.dart';

class XXSetting{
  static var step = 60;
  static var length = 8;
  static var key = "";
  /// Base16 | Base32 | ASCII
  static var keyType = "Base16";
  static var seedType = SeedTypes.now;
  static var seedShiftOffset = 0;
  static var seedHoldTime = 0;

  static load() async{
    var sp = await SharedPreferences.getInstance();
    step = sp.getInt("step") ?? 60;
    length = sp.getInt("length") ?? 8;
    key = sp.getString("key") ?? "";
    keyType = sp.getString("keyType") ?? "Base16";
    seedType = sp.getInt("seedType") ?? 0;
    seedShiftOffset = sp.getInt("seedShiftOffset") ?? 0;
    seedHoldTime = sp.getInt("seedHoldTime") ?? 0;
  }
  static save() async{
    var sp = await SharedPreferences.getInstance();
    sp.setInt("step", step);
    sp.setInt("length", length);
    sp.setString("key", key);
    sp.setString("keyType", keyType);
    sp.setInt("seedType", seedType);
    sp.setInt("seedShiftOffset", seedShiftOffset);
    sp.setInt("seedHoldTime", seedHoldTime);
  }
}

class SeedTypes{
  static const int now = 0;
  static const int shift = 1;
  static const int hold = 2;
  
  static String getName(int type){
    switch(type){
      case now: return "端末日時";
      case shift: return "端末日時 + X";
      case hold: return "指定日時";
      default: return "";
    }
  }
}