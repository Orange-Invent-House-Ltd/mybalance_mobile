import './storage_provider.dart';

class InMemoryStorageProvider implements StorageProvider<String> {
  final Map<String, String> _storage = {};

  @override
  Future<void> setValue(String key, String value) async {
    _storage[key] = value;
  }

  @override
  Future<String?> getValue(String key) async {
    return _storage[key];
  }

  @override
  Future<void> removeValue(String key) async {
    _storage.remove(key);
  }
}
