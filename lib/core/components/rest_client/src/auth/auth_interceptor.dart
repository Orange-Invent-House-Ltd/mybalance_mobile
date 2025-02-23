import 'package:dio/dio.dart';

import '../../../database/src/storage_manager.dart';
import './token.dart';
import '../../../../utils/retry_request_mixin.dart';
import 'authentication_status.dart';
import 'authorization_client.dart';


/// AuthStatusSource is used to get the status of the authentication
abstract interface class AuthStatusSource {
  /// Stream of [AuthenticationStatus]
  Stream<AuthenticationStatus> get authStatus;
}

class DioAuthInterceptor extends Interceptor with RetryRequestMixin {
  DioAuthInterceptor({
    required this.tokenStorage,
    required this.authorizationClient,
    Dio? retryDio,
  }) : retryDio = retryDio ?? Dio() {
    tokenStorage.getStream()?.listen((newToken) => _token = newToken);
  }

  final Dio retryDio;
  final StorageManager<Token> tokenStorage;
  final AuthorizationClient<Token> authorizationClient;
  Token? _token;

  Future<Token?> _loadToken() async => _token;

  Map<String, String> _buildHeaders(Token token) => {
        'Authorization': 'Bearer ${token.accessToken}',
      };

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    var token = await _loadToken();

    if (token == null) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: const RevokeTokenException(
              'Token is not valid and cannot be refreshed'),
        ),
      );
    }

    if (await authorizationClient.isAccessTokenValid(token)) {
      final headers = _buildHeaders(token);
      options.headers.addAll(headers);
      return handler.next(options);
    }

    if (await authorizationClient.isRefreshTokenValid(token)) {
      try {
        token = await authorizationClient.refresh(token);
        await tokenStorage.save(token);
        final headers = _buildHeaders(token);
        options.headers.addAll(headers);
        return handler.next(options);
      } on RevokeTokenException catch (e) {
        await tokenStorage.clear();
        return handler.reject(
          DioException(
            requestOptions: options,
            error: e,
          ),
        );
      } on Object catch (e) {
        return handler.reject(
          DioException(
            requestOptions: options,
            error: e,
          ),
        );
      }
    }

    await tokenStorage.clear();
    return handler.reject(
      DioException(
        requestOptions: options,
        error: const RevokeTokenException(
            'Token is not valid and cannot be refreshed'),
      ),
    );
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    if (response.statusCode != 401) {
      return handler.next(response);
    }

    var token = await _loadToken();

    if (token == null) {
      return handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          error: const RevokeTokenException(
              'Token is not valid and cannot be refreshed'),
        ),
      );
    }

    final tokenFromHeaders =
        response.requestOptions.headers['Authorization']?.substring(7);

    if (tokenFromHeaders == null) {
      return handler.next(response);
    }

    if (tokenFromHeaders == token.accessToken) {
      if (await authorizationClient.isRefreshTokenValid(token)) {
        try {
          token = await authorizationClient.refresh(token);
          await tokenStorage.save(token);
          final headers = _buildHeaders(token);
          final newRequestOptions = response.requestOptions
            ..headers.addAll(headers);
          final newResponse = await retryRequest(newRequestOptions, retryDio);
          return handler.resolve(newResponse);
        } on RevokeTokenException catch (e) {
          await tokenStorage.clear();
          return handler.reject(
            DioException(
              requestOptions: response.requestOptions,
              error: e,
            ),
          );
        } on Object catch (e) {
          return handler.reject(
            DioException(
              requestOptions: response.requestOptions,
              error: e,
            ),
          );
        }
      }

      await tokenStorage.clear();
      return handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          error: const RevokeTokenException(
              'Token is not valid and cannot be refreshed'),
        ),
      );
    }

    final newResponse = await retryRequest(response.requestOptions);
    return handler.resolve(newResponse);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    var token = await _loadToken();

    if (token == null) {
      return handler.reject(err);
    }

    final tokenFromHeaders =
        err.requestOptions.headers['Authorization']?.substring(7);

    if (tokenFromHeaders == null) {
      return handler.next(err);
    }

    if (tokenFromHeaders == token.accessToken) {
      if (await authorizationClient.isRefreshTokenValid(token)) {
        try {
          token = await authorizationClient.refresh(token);
          await tokenStorage.save(token);
          final headers = _buildHeaders(token);
          final newRequestOptions = err.requestOptions..headers.addAll(headers);
          final newResponse = await retryRequest(newRequestOptions, retryDio);
          return handler.resolve(newResponse);
        } on RevokeTokenException catch (e) {
          await tokenStorage.clear();
          return handler.reject(
            DioException(
              requestOptions: err.requestOptions,
              error: e,
            ),
          );
        } on Object catch (e) {
          return handler.reject(
            DioException(
              requestOptions: err.requestOptions,
              error: e,
            ),
          );
        }
      }

      await tokenStorage.clear();
      return handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: const RevokeTokenException(
              'Token is not valid and cannot be refreshed'),
        ),
      );
    }

    final newResponse = await retryRequest(err.requestOptions);
    return handler.resolve(newResponse);
  }
}
