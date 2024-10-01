import '../../../core/components/rest_client/rest_client.dart';
import '../../../core/components/rest_client/src/rest_client.dart';

abstract interface class AuthDataSource {
  Future<Token> signInWithEmailAndPassword(String email, String password);
  Future<bool> register(String email, String password);
}

class AuthDataSourceImpl implements AuthDataSource {
  final RestClient _restClient;

  AuthDataSourceImpl({required RestClient restClient})
      : _restClient = restClient;

  @override
  Future<Token> signInWithEmailAndPassword(
      String email, String password) async {
    final response = await _restClient.post(
      '/login',
      body: {
        'email': email,
        'password': password,
      },
    );
    if (response
        case {
          "tokens": {
            "refresh": final String refreshToken,
            "access": final String accessToken,
          }
        }) {
      return Token(accessToken, refreshToken);
    }
    throw Exception();
  }

  @override
  Future<bool> register(String email, String password) async {
    final response = await _restClient.post(
      '/register',
      body: {
        'email': email,
        'password': password,
      },
    );

    return response == null;
  }
}
