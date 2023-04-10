import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';

extension StringExtended on String {
  int fashHash() {
    var hash = 0xcbf29ce484222325;

    var i = 0;
    while (i < length) {
      final codeUnit = codeUnitAt(i++);
      hash ^= codeUnit >> 8;
      hash *= 0x100000001b3;
      hash ^= codeUnit & 0xFF;
      hash *= 0x100000001b3;
    }

    return hash;
  }

  String encrypt(String key) {
    final encrypter = _encrypter(key);
    final iv = IV.fromLength(16);

    final encrypted = encrypter.encrypt(this, iv: iv).bytes;
    return String.fromCharCodes(encrypted);
  }

  String decrypt(String key) {
    final encrypter = _encrypter(key);
    final iv = IV.fromLength(16);

    final uint8List = Uint8List.fromList(codeUnits);
    return encrypter.decrypt(Encrypted(uint8List), iv: iv);
  }

  Encrypter _encrypter(String key) {
    final algKey = Key.fromUtf8("${key}abcd");
    return Encrypter(AES(algKey, mode: AESMode.ctr, padding: null));
  }

  String normalizer() {
    return replaceAll(RegExp(r'&amp;|nbsp;'), ' ');
  }
}
