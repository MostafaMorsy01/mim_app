import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const storage = FlutterSecureStorage();

  static Future<String?> readByKey(String key) async {
    String? value = await storage.read(key: key);
    if (value != null) {
      value = jsonDecode(value);
    }
    return value;
  }

  static Future<void> storeByKey(String key, dynamic value) async {
    await storage.write(key: key, value: jsonEncode(value));
  }

  static Future<void> deleteByKey(String key) async {
    await storage.delete(key: key);
  }

  static Future<void> deleteAll() async {
    await storage.deleteAll();
  }
}
