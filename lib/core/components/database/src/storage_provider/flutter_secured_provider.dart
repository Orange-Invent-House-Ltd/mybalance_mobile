import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import './storage_provider.dart';

class FlutterSecureStorageProvider implements StorageProvider<String> {
  final FlutterSecureStorage _secureStorage;

  FlutterSecureStorageProvider(this._secureStorage);

  @override
  Future<void> setValue(String key, String? value) async {
    await _secureStorage.write(key: key, value: value);
  }

  @override
  Future<String?> getValue(String key) async {
    return await _secureStorage.read(key: key);
  }

  @override
  Future<void> removeValue(String key) async {
    await _secureStorage.delete(key: key);
  }
}