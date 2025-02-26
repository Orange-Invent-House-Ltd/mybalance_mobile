import '../../../core/components/rest_client/rest_client.dart';

abstract interface class AuthDataSource {
  Future<(Token, String)> signInWithEmailAndPassword(
      String email, String password);
  Future<bool> register(String email, String password);
  Future<void> forgetPassword(String email);
}
