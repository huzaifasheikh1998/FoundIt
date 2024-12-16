import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart' as pp;
import 'package:path/path.dart';

abstract class LocalStorage<T> {
  final String fileName;
  final T value;

  const LocalStorage({
    required this.fileName,
    required this.value,
  });

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> save() async {
    await _storage.write(key: fileName, value: jsonEncode(value));
  }

  Future<T> readFromFile() async {
    String? content;
    try {
      content = await _storage.read(key: fileName);
    } catch (e) {
      log(e.toString());
    }
    return content != null ? jsonDecode(content) as T : value;
  }

  Future<void> clearLocal() async {
    await _storage.delete(key: fileName);
  }

  Future<void> clear();
  Future<void> init();
}

Future<void> deletePreviousStorage() async {
  File file = File(
      join((await pp.getApplicationSupportDirectory()).path, 'first_launch'));
  if (!file.existsSync()) {
    await FlutterSecureStorage().deleteAll();
    file.createSync();
  }
}
