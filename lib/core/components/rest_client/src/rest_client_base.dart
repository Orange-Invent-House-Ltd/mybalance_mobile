import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';

import './exception/network_exception.dart';
import './rest_client.dart';

@immutable
abstract base class RestClientBase implements RestClient {
  /// {@macro rest_client}
  RestClientBase({required String baseUrl}) : baseUri = Uri.parse(baseUrl);

  /// The base url for the client
  final Uri baseUri;

  static final _jsonUTF8 = json.fuse(utf8);

  /// Encodes [body] to JSON and then to UTF8
  @protected
  @visibleForTesting
  List<int> encodeBody(Map<String, Object?> body) {
    try {
      return _jsonUTF8.encode(body);
    } on Object catch (e, stackTrace) {
      Error.throwWithStackTrace(
        ClientException(message: 'Error occured during encoding $e'),
        stackTrace,
      );
    }
  }

  /// Builds [Uri] from [path], [queryParams] and [baseUri]
  @protected
  @visibleForTesting
  Uri buildUri({required String path, Map<String, Object?>? queryParams}) {
    final finalPath = '${baseUri.path}$path';
    return baseUri.replace(
      path: finalPath,
      queryParameters: {
        ...baseUri.queryParameters,
        if (queryParams != null) ...queryParams,
      },
    );
  }

  /// Decodes [body] from JSON \ UTF8
  @protected
  @visibleForTesting
  FutureOr<Map<String, Object?>?>
      decodeResponse(
    Object? body, {
    int? statusCode,
  }) async {
    if (body == null) return null;
    try {
      Map<String, Object?> result;
      if (body is Map<String, dynamic>) {
        result = body;
      } else {
        throw WrongResponseTypeException(
          message: 'Unexpected response body type: ${body.runtimeType}',
          statusCode: statusCode,
        );
      }
      // TODO: Ask the backend team to provide a consistent error response
      if (result
          case {
            'success': false,
            'message': String message,
            'data': Map<String, dynamic>? error,
          }) {
        throw CustomBackendException(
          message: message,
          error: error,
          statusCode: statusCode,
        );
      }

      if (result
          case {
            'success': true,
            'data': final Map<String, dynamic>? data,
            'meta': final Map<String, dynamic>? meta,
          }) {
        return {
          'data': data,
          'meta': meta,
        };
      }

      return null;
    } on RestClientException {
      rethrow;
    } on Object catch (e, stackTrace) {
      Error.throwWithStackTrace(
        ClientException(
          message: 'Error occured during decoding',
          statusCode: statusCode,
          cause: e,
        ),
        stackTrace,
      );
    }
  }
}
