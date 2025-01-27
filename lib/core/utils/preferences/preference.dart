import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageProvider<T> {
  Future<void> setValue(String key, T value);
  FutureOr<T?> getValue(String key);
  Future<void> removeValue(String key);
}

class SharedPreferencesProvider<T extends Object>
    implements StorageProvider<T> {
  final SharedPreferences _sharedPreferences;

  SharedPreferencesProvider(this._sharedPreferences);

  @override
  Future<void> setValue(String key, T value) => switch (value) {
        final int value => _sharedPreferences.setInt(key, value),
        final double value => _sharedPreferences.setDouble(key, value),
        final String value => _sharedPreferences.setString(key, value),
        final bool value => _sharedPreferences.setBool(key, value),
        final Iterable<String> value => _sharedPreferences.setStringList(
            key,
            value.toList(),
          ),
        _ => throw Exception(
            '$T is not a valid type for a preferences entry value.',
          ),
      };

  @override
  T? getValue(String key) {
    final value = _sharedPreferences.get(key);
    if (value == null) return null;
    if (value is T) return value;

    throw Exception(
      'The value of $key is not of type ${T.runtimeType.toString()}',
    );
  }

  @override
  Future<void> removeValue(String key) async {
    await _sharedPreferences.remove(key);
  }
}

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
