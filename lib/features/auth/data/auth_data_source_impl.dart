import '../../../core/components/rest_client/rest_client.dart';
import './auth_data_source.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final RestClient _restClient;

  AuthDataSourceImpl({required RestClient restClient})
      : _restClient = restClient;

  @override
  Future<(Token token, String userType)> signInWithEmailAndPassword(
      String email, String password) async {
    final response = await _restClient.post(
      '/auth/login',
      body: {
        'email': email,
        'password': password,
      },
    );
    final Map<String, dynamic>? data =
        response?['data'] as Map<String, dynamic>?;
    // print(data);
    // print(data?['user']);
    if (data
        case {
          "token": final String accessToken,
          'user': {
            "isBuyer": final bool isBuyer,
            "isSeller": final bool isSeller,
            "isMerchant": final bool isMerchant,
            "metadata": {
              "flaggedStatus": final bool flaggedStatus,
              "deactivatedStatus": final bool deactivatedStatus,
            }
          },
        }) {
      if (flaggedStatus) {
        throw Exception('User is flagged');
      }
      if (deactivatedStatus) {
        throw Exception('User is deactivated');
      }
      late String userType;
      if (isBuyer) {
        userType = 'buyer';
      } else if (isSeller) {
        userType = 'seller';
      } else if (isMerchant) {
        userType = 'merchant';
        throw Exception('Not allowed user type $userType');
      } else {
        userType = 'unknown';
        throw Exception('Not allowed user type $userType');
      }

      const String refreshToken = 'Not implemented';
      final Token token = Token(accessToken, refreshToken);
      return (token, userType);
    }
    throw Exception('Invalid response');
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

  @override
  Future<void> forgetPassword(String email) async {
    await _restClient.post(
      '/auth/forgot-password',
      body: {
        'email': email,
        "platform": "BASE_PLATFORM",
      },
    );
  }
}
