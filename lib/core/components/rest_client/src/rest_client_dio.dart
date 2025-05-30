import 'dart:developer';

import 'package:dio/dio.dart';

import '../../database/database.dart';
import './exception/network_exception.dart';
import './rest_client_base.dart';

final class RestClientDio extends RestClientBase {
  RestClientDio({
    required Dio dio,
    required TokenStorage tokenStorage,
    required PreferencesDao preferencesDao,
    bool withAuthHeader = false,
  })  : _dio = dio,
        _tokenStorage = tokenStorage,
        _preferencesDao = preferencesDao,
        _withAuthHeader = withAuthHeader,
        super(baseUrl: dio.options.baseUrl);

  final Dio _dio;
  final TokenStorage _tokenStorage;
  final PreferencesDao _preferencesDao;
  final bool _withAuthHeader;

  Future<Map<String, dynamic>?> sendRequest<T extends Object>({
    required String path,
    required String method,
    Map<String, Object?>? body,
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParams,
  }) async {
    try {
      if (_withAuthHeader) {
        final token = await _tokenStorage.load();
        _dio.options.headers['Authorization'] = 'Bearer ${token?.accessToken}';
      }
      log('before uri: $path');
      final uri = buildUri(path: path, queryParams: queryParams);
      log('after uri: $uri');
      final options = Options(
        headers: headers,
        method: method,
        contentType: 'application/json',
        responseType: ResponseType.json,
      );
      final response = await _dio.request<T>(
        uri.toString(),
        data: body,
        options: options,
      );
      if (response.statusCode == 401) {
        log('in Here');
        PreferencesEntry<String> userTypeKey =
            _preferencesDao.stringEntry('userType');
        PreferencesEntry<String> userNameKey =
            _preferencesDao.stringEntry('userName');

        await _tokenStorage.clear();
        await userTypeKey.remove();
        await userNameKey.remove();
        return {};
      }
      final resp = await decodeResponse(
        response.data,
        statusCode: response.statusCode,
      );

      return resp;
    } on RestClientException {
      rethrow;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.unknown) {
        Error.throwWithStackTrace(
          ConnectionException(
            message:
                'Unknown Error please check internet connection or restart the app',
            statusCode: e.response?.statusCode,
            cause: e,
          ),
          e.stackTrace,
        );
      }
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        Error.throwWithStackTrace(
          ConnectionException(
            message:
                'Connection Error please check internet connectivity and try again',
            statusCode: e.response?.statusCode,
            cause: e,
          ),
          e.stackTrace,
        );
      }
      if (e.response != null) {
        final result = await decodeResponse(
          e.response?.data,
          statusCode: e.response?.statusCode,
        );

        return result;
      }
      Error.throwWithStackTrace(
        ClientException(
          message: e.toString(),
          statusCode: e.response?.statusCode,
          cause: e,
        ),
        e.stackTrace,
      );
    } on Object catch (e, stack) {
      log(e.toString());
      Error.throwWithStackTrace(
        ClientException(message: e.toString(), cause: e),
        stack,
      );
    }
  }

  @override
  Future<Map<String, dynamic>?> delete(
    String path, {
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParams,
  }) =>
      sendRequest(
        path: path,
        method: 'DELETE',
        headers: headers,
        queryParams: queryParams,
      );

  @override
  Future<Map<String, dynamic>?> get(
    String path, {
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParams,
  }) =>
      sendRequest(
        path: path,
        method: 'GET',
        headers: headers,
        queryParams: queryParams,
      );

  @override
  Future<Map<String, dynamic>?> patch(
    String path, {
    required Map<String, Object?> body,
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParams,
  }) =>
      sendRequest(
        path: path,
        method: 'PATCH',
        body: body,
        headers: headers,
        queryParams: queryParams,
      );

  @override
  Future<Map<String, dynamic>?> post(
    String path, {
    required Map<String, Object?> body,
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParams,
  }) =>
      sendRequest(
        path: path,
        method: 'POST',
        body: body,
        headers: headers,
        queryParams: queryParams,
      );

  @override
  Future<Map<String, dynamic>?> put(
    String path, {
    required Map<String, Object?> body,
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParams,
  }) =>
      sendRequest(
        path: path,
        method: 'PUT',
        body: body,
        headers: headers,
        queryParams: queryParams,
      );
}
