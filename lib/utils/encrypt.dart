import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/asymmetric/oaep.dart';
import 'package:pointycastle/asymmetric/rsa.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';

class AESResObj {
  String iv;
  String encrypted;

  AESResObj(this.iv, this.encrypted);
}

AESResObj encryptWithAES(String plaintext, List<int> key) {
  final keyBytes = encrypt.Key.fromBase64(base64.encode(key));
  final iv = encrypt.IV.fromLength(16);
  // 创建 AES 加密器
  final encrypter = encrypt.Encrypter(encrypt.AES(keyBytes, mode: encrypt.AESMode.cbc));

  final encrypted = encrypter.encrypt(plaintext, iv: iv);
  return AESResObj(iv.base64, encrypted.base64);
}

RSAPublicKey parsePublicKeyFromPem(String publicKeyString) {
  String publicKeyPem = publicKeyString.replaceAll("-----BEGIN PUBLIC KEY-----", "")
      .replaceAll("-----END PUBLIC KEY-----", "")
      .replaceAll("\n", "");
  // 使用 PointyCastle 从 DER 编码的字节数组中提取 RSAPublicKey 对象
  RSAPublicKey publicKey = RsaKeyHelper().parsePublicKeyFromPem(publicKeyPem);
  return publicKey;
}

List<int> generateRandomKey(int length) {
  final random = Random.secure();
  return List<int>.generate(length, (_) => random.nextInt(256));
}

String encryptWithRSA(String plaintext, RSAPublicKey publicKey) {
  final encryptor = OAEPEncoding(RSAEngine())
    ..init(
      true,
      PublicKeyParameter<RSAPublicKey>(publicKey),
    );
  final input = Uint8List.fromList(utf8.encode(plaintext));
  return base64.encode(_processInBlocks(encryptor, input));
}

Uint8List _processInBlocks(AsymmetricBlockCipher engine, Uint8List input) {
  final numBlocks = (input.length / engine.inputBlockSize).ceil();
  final output = Uint8List(numBlocks * engine.outputBlockSize);
  var offset = 0;

  for (var i = 0; i < numBlocks; i++) {
    final chunk = input.sublist(
      i * engine.inputBlockSize,
      (i + 1) * engine.inputBlockSize < input.length
          ? (i + 1) * engine.inputBlockSize
          : input.length,
    );
    offset += engine.processBlock(chunk, 0, chunk.length, output, offset);
  }
  return output.sublist(0, offset);
}