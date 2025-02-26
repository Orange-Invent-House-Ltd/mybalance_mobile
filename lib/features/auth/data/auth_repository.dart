import '../../../core/components/rest_client/rest_client.dart';

abstract interface class AuthRepository implements AuthStatusSource {
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> register(String email, String password);
  Future<void> signOut();
  Future<void> forgetPassword(String email);
}

