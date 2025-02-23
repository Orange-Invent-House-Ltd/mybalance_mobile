import './preference_entry.dart';
import './storage_provider/storage_provider.dart';

base class PreferencesDao {
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

