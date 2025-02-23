import 'dart:async';

abstract class StorageProvider<T> {
  Future<void> setValue(String key, T value);
  FutureOr<T?> getValue(String key);
  Future<void> removeValue(String key);
}