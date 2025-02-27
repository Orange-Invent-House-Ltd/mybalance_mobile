import 'dart:developer';

import '../../../core/components/database/database.dart';
import '../../../core/components/rest_client/rest_client.dart';
import './auth_data_source.dart';
import './auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;
  final TokenStorage _tokenStorage;
  final PreferencesDao _preferencesDao;

  AuthRepositoryImpl(
      {required AuthDataSource authDataSource,
      required TokenStorage tokenStorage,
      required PreferencesDao preferencesDao})
      : _authDataSource = authDataSource,
        _tokenStorage = tokenStorage,
        _preferencesDao = preferencesDao;

  PreferencesEntry<String> get userTypeKey =>
      _preferencesDao.stringEntry('userType');

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    final (token, userType) =
        await _authDataSource.signInWithEmailAndPassword(email, password);
    await _tokenStorage.save(token);
    userTypeKey.set(userType);
    log('User signed in as $userType');
    log('access token ${token.accessToken}');
  }

  @override
  Future<void> register(String email, String password) async {
    await _authDataSource.register(email, password);
  }

  @override
  Future<void> signOut() async {
    await _tokenStorage.clear();
    await userTypeKey.remove();
  }

  @override
  Stream<AuthenticationStatus> get authStatus async* {
    // First, check if a token is already stored
    final token = await _tokenStorage.load();
    yield token != null
        ? AuthenticationStatus.authenticated
        : AuthenticationStatus.unauthenticated;

    // Then, listen to changes in token storage
    yield* _tokenStorage.getStream().map(
          (token) => token != null
              ? AuthenticationStatus.authenticated
              : AuthenticationStatus.unauthenticated,
        );
  }

  @override
  Future<void> forgetPassword(String email) async {
    await _authDataSource.forgetPassword(email);
  }
}
