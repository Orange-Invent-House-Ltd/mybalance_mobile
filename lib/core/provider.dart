import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import './components/rest_client/rest_client.dart';
import './components/database/src/token_storage.dart';
import './utils/preferences/preference.dart';

final sharedPrefProvider = FutureProvider<SharedPreferences>((_) async {
  return SharedPreferences.getInstance();
});

final secureStorageProvider = Provider<FlutterSecureStorage>(
  (_) => const FlutterSecureStorage(),
);

final _dioProvider = Provider<Dio>((_) {
  final Dio dio = Dio();
  dio.options.baseUrl = 'https://jsonplaceholder.typicode.com';
  return dio;
});

final restClientProvider = Provider<RestClientDio>((ref) {
  final dio = ref.read(_dioProvider);
  return RestClientDio(dio: dio);
});

final authorizationClientProvider = Provider<AuthorizationClient<Token>>((ref) {
  final client = ref.read(restClientProvider);
  return JWTAuthorizationClient(client);
});

final secureProvider = Provider<StorageProvider>((ref) {
  final storage = ref.read(secureStorageProvider);
  return FlutterSecureStorageProvider(storage);
});

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  final storageProvider = ref.read(secureProvider);
  return TokenStorage(storageProvider: storageProvider);
});

final restClientAuthProvider = Provider<RestClientDio>((ref) {
  final dio = ref.read(_dioProvider);
  final tokenStorage = ref.watch(tokenStorageProvider);
  final authorizationClient = ref.watch(authorizationClientProvider);
  dio.interceptors.add(DioAuthInterceptor(
    tokenStorage: tokenStorage,
    authorizationClient: authorizationClient,
  ));
  return RestClientDio(dio: dio);
});
