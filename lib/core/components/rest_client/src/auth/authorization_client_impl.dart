import 'dart:async';

import '../../../../utils/jwt_decoder.dart';
import '../rest_client_dio.dart';
import './authorization_client.dart';
import './token.dart';

final class JWTAuthorizationClient implements AuthorizationClient<Token> {
  final RestClientDio _client;

  JWTAuthorizationClient(this._client);

  @override
  FutureOr<bool> isRefreshTokenValid(Token token) {
    final jwt = JWT(token.refreshToken);
    return jwt.isExpired();
  }

  @override
  FutureOr<bool> isAccessTokenValid(Token token) {
    final jwt = JWT(token.accessToken);
    return jwt.isExpired();
  }

  @override
  Future<Token> refresh(Token token) async {
    final json = await _client.post(
      '/auth/refresh',
      body: {'refresh': token.refreshToken},
    );

    if (json
        case {
          'access_token': final String aToken,
          'refresh_token': final String rToken,
        }) {
      return Token(aToken, rToken);
    }

    throw const RevokeTokenException('Invalid token');
  }
}
