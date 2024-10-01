import 'package:mybalanceapp/core/components/database/src/token_storage.dart';

import '../../../core/components/rest_client/rest_client.dart';
import './auth_data_source.dart';

abstract interface class AuthRepository implements AuthStatusSource {
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> register(String email, String password);
  Future<void> signOut();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;
  final TokenStorage _tokenStorage;

  AuthRepositoryImpl(
      {required AuthDataSource authDataSource,
      required TokenStorage tokenStorage})
      : _authDataSource = authDataSource,
        _tokenStorage = tokenStorage;

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    final token =
        await _authDataSource.signInWithEmailAndPassword(email, password);
    token;
  }

  @override
  Future<void> register(String email, String password) async {
    await _authDataSource.register(email, password);
  }

  @override
  Future<void> signOut() async {
    await _tokenStorage.clear();
  }

  @override
  Stream<AuthenticationStatus> get authStatus => _tokenStorage.getStream().map(
        (token) => token != null
            ? AuthenticationStatus.authenticated
            : AuthenticationStatus.unauthenticated,
      );
}
