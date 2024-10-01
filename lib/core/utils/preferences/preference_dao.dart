import 'preference.dart';

abstract base class PreferencesEntry<T extends Object> {
  const PreferencesEntry();

  String get key;

  Future<T?> read();

  Future<void> set(T value);

  Future<void> remove();

  Future<void> setIfNullRemove(T? value) =>
      value == null ? remove() : set(value);
}

abstract base class PreferencesDao {
  final StorageProvider _storageProvider;

  const PreferencesDao({required StorageProvider storageProvider})
      : _storageProvider = storageProvider;

  PreferencesEntry<bool> boolEntry(String key) => TypedEntry<bool>(
        key: key,
        storageProvider: _storageProvider,
      );

  PreferencesEntry<double> doubleEntry(String key) => TypedEntry<double>(
        key: key,
        storageProvider: _storageProvider,
      );

  PreferencesEntry<int> intEntry(String key) => TypedEntry<int>(
        key: key,
        storageProvider: _storageProvider,
      );

  PreferencesEntry<String> stringEntry(String key) => TypedEntry<String>(
        key: key,
        storageProvider: _storageProvider,
      );

  PreferencesEntry<Iterable<String>> iterableStringEntry(String key) =>
      TypedEntry<Iterable<String>>(
        key: key,
        storageProvider: _storageProvider,
      );
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
