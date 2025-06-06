import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/profile/models/profile.dart';
import './components/database/database.dart';
import './components/rest_client/rest_client.dart';
import './constants/config.dart';

// Storage Providers

final sharedPrefProvider = FutureProvider<SharedPreferences>((_) async {
  return await SharedPreferences.getInstance();
});

final _secureStorageProvider = Provider<FlutterSecureStorage>(
  (_) => const FlutterSecureStorage(),
);

final _memoryProvider = Provider<InMemoryStorageProvider>((_) {
  return InMemoryStorageProvider();
});

final _sharedProvider = Provider<StorageProvider>((ref) {
  final sharedPreferences = ref.watch(sharedPrefProvider).maybeWhen(
        data: (data) => data,
        orElse: () => null,
      );
  if (sharedPreferences == null) {
    return ref.read(_memoryProvider);
  }
  return SharedPreferencesProvider(sharedPreferences);
});

final _secureProvider = Provider<StorageProvider>((ref) {
  final storage = ref.read(_secureStorageProvider);
  return FlutterSecureStorageProvider(storage);
});

final sharedDaoProvider = Provider<PreferencesDao>((ref) {
  final storageProvider = ref.watch(_sharedProvider);
  return PreferencesDao(storageProvider: storageProvider);
});

final secureDaoProvider = Provider<PreferencesDao>((ref) {
  final storageProvider = ref.watch(_secureProvider);
  return PreferencesDao(storageProvider: storageProvider);
});

final memoryDaoProvider = Provider<PreferencesDao>((ref) {
  final storageProvider = ref.watch(_memoryProvider);
  return PreferencesDao(storageProvider: storageProvider);
});

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  final storageProvider = ref.watch(_secureProvider);
  final tokenStorage = TokenStorage(storageProvider: storageProvider);
  ref.onDispose(() => tokenStorage.close());
  return tokenStorage;
});

// Dio Providers

final _dioProvider = Provider<Dio>((_) {
  final Dio dio = Dio();
  dio.options.baseUrl = Constants.apiBaseUrl;
  return dio;
});

final dioAuthProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.options.baseUrl = Constants.apiBaseUrl;
  dio.options.headers['Content-Type'] = 'application/json';
  dio.options.headers['Accept'] = 'application/json';

  // final authorizationClient = ref.watch(authorizationClientProvider);
  // if (!dio.interceptors.any((i) => i is DioAuthInterceptor)) {
  //   dio.interceptors.add(DioAuthInterceptor(
  //     tokenStorage: tokenStorage,
  //     authorizationClient: authorizationClient,
  //   ));
  // }

  // dio.interceptors.add(LogInterceptor());

  return dio;
});

final restClientProvider = Provider<RestClientDio>((ref) {
  final dio = ref.read(_dioProvider);
  final tokenStorage = ref.watch(tokenStorageProvider);
  final preferenceDao = ref.watch(sharedDaoProvider);
  return RestClientDio(
    dio: dio,
    tokenStorage: tokenStorage,
    preferencesDao: preferenceDao,
  );
});

final restClientAuthProvider = Provider<RestClientDio>((ref) {
  final dio = ref.watch(dioAuthProvider);
  final tokenStorage = ref.watch(tokenStorageProvider);
  final preferenceDao = ref.watch(sharedDaoProvider);
  return RestClientDio(
    dio: dio,
    tokenStorage: tokenStorage,
    preferencesDao: preferenceDao,
    withAuthHeader: true,
  );
});

final testProvider = FutureProvider<Profile>((ref) async {
  final restClient = ref.read(restClientAuthProvider);
  final profile = await restClient.get('/auth/profile');
  final proile = Profile.fromJson(profile!['data']);
  log(profile['data'].toString());
  log(proile.toString());
  return proile;
});
