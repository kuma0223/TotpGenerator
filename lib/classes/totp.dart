import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

class TOTPGenerator{

  /// タイムステップ
  final int step;
  ///パスワード長
  final int length;
  ///ハッシュキー
  final String key;
  ///キー種別
  final String keyType;

  static final List<String> _base32Chars = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N"
    , "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "2", "3", "4", "5", "6", "7"];

  TOTPGenerator({
    required this.length,
    required this.step,
    required this.key,
    required this.keyType});

  String generate(DateTime d){
    List<int> keyBytes;
    switch(keyType){
      case "ASCII": keyBytes = ascii.encode(key); break;
      case "Base16": keyBytes = _decodeHex(key); break;
      case "Base32": keyBytes = _decodeBase32(key); break;
      default: keyBytes = _decodeHex(key); break;
    }
    var hmac = Hmac(sha1, keyBytes);
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

  List<int> _decodeBase32(String txt){
    var dict = <String, int>{};
    for(int i=0; i<_base32Chars.length; i++){
      dict[_base32Chars[i]] = i;
      dict[_base32Chars[i].toLowerCase()] = i;
    }

    var ret = <int>[];
    void setBit(int i, int v){
      var idx = i ~/ 8;
      var bit = 8 - (i % 8) - 1;
      if(ret.length <= idx) ret.add(0);
      ret[idx] |= v << bit;
    }
    
    var count = 0;
    for(int i=0; i<txt.length; i++){
      var c = txt.substring(i, i+1);
      if(c == "=") break;
      var v = dict[c]!;
      setBit(count++, (v >> 4) & 1);
      setBit(count++, (v >> 3) & 1);
      setBit(count++, (v >> 2) & 1);
      setBit(count++, (v >> 1) & 1);
      setBit(count++, (v >> 0) & 1);
    }
    return ret;
  }
}