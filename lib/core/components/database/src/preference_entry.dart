import './storage_provider/storage_provider.dart';

abstract base class PreferencesEntry<T extends Object> {
  const PreferencesEntry();

  String get key;

  Future<T?> read();

  Future<void> set(T value);

  Future<void> remove();

  Future<void> setIfNullRemove(T? value) =>
      value == null ? remove() : set(value);
}

final class TypedEntry<T extends Object> extends PreferencesEntry<T> {
  final StorageProvider _storageProvider;
  @override
  final String key;

  TypedEntry({required this.key, required StorageProvider storageProvider})
      : _storageProvider = storageProvider;

  @override
  Future<T?> read() async {
    return await _storageProvider.getValue(key);
  }

  @override
  Future<void> set(T value) async {
    await _storageProvider.setValue(key, value);
  }

  @override
  Future<void> remove() async {
    await _storageProvider.removeValue(key);
  }
}
