import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/components/rest_client/rest_client.dart';
import '../data/data.dart';
import './auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthNotifier({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState.idle(
          status: AuthenticationStatus.unauthenticated,
        )) {
    _authRepository.authStatus.listen((status) {
      state = AuthState.idle(status: status);
    });
  }

 

  Future<void> signInWithEmailAndPassword(
      String email, String password) async {
    state = AuthState.processing(status: state.status);

    try {
      await _authRepository.signInWithEmailAndPassword(email, password);
      state = const AuthState.idle(status: AuthenticationStatus.authenticated);
    } catch (e) {
      state = AuthState.error(
        status: AuthenticationStatus.unauthenticated,
        error: e,
      );
    }
  }

  Future<void> signOut() async {
    state = AuthState.processing(status: state.status);

    try {
      await _authRepository.signOut();
      state =
          const AuthState.idle(status: AuthenticationStatus.unauthenticated);
    } catch (e) {
      state = AuthState.error(
        status: AuthenticationStatus.unauthenticated,
        error: e,
      );
    }
  }
}
