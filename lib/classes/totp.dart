import 'dart:math';
import 'package:crypto/crypto.dart';

class TOTPGenerator{

  /// タイムステップ
  final int step;

  ///パスワード長
  final int length;

  ///SEEDキー
  final String key;

  TOTPGenerator({
    required this.length,
    required this.step,
    required this.key});

  String generate(DateTime d){
    var hmac = Hmac(sha1, _decodeHex(key));
    var pows = pow(10, length);

    var seed = d.millisecondsSinceEpoch ~/ 1000 ~/ step;
    var input = seed.toRadixString(16).padLeft(16, "0");
    var hash  = hmac.convert(_decodeHex(input)).bytes;
    
    var offset = hash[hash.length-1] & 0x0f;
    var x = ((hash[offset] & 0x7f) << 24)
      | ((hash[offset+1] & 0xff) << 16)
      | ((hash[offset+2] & 0xff) << 8)
      | ((hash[offset+3] & 0xff) << 0);
    
    return "${x % pows}".padLeft(length, "0");
  }

  List<int> _decodeHex(String hex){
    if(hex.length % 2 == 1) hex = "0$hex";
    var ret = <int>[];
    for(int i=0; i<hex.length/2; i++){
      ret.add(int.parse(hex.substring(i*2, i*2+2), radix: 16));
    }
    return ret;
  }
}