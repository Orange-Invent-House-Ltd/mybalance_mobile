import 'package:dio/dio.dart';

mixin RetryRequestMixin {
  /// Retries the request.
  Future<Response> retryRequest(
    RequestOptions requestOptions, [
    Dio? dio,
  ]) async {
    final $dio = dio ?? Dio();

    try {
      final response = await $dio.request(
        requestOptions.path,
        options: Options(
          method: requestOptions.method,
          headers: requestOptions.headers,
          responseType: requestOptions.responseType,
          contentType: requestOptions.contentType,
          followRedirects: requestOptions.followRedirects,
          validateStatus: requestOptions.validateStatus,
          receiveDataWhenStatusError: requestOptions.receiveDataWhenStatusError,
          sendTimeout: requestOptions.sendTimeout,
          receiveTimeout: requestOptions.receiveTimeout,
          extra: requestOptions.extra,
        ),
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        cancelToken: requestOptions.cancelToken,
        onReceiveProgress: requestOptions.onReceiveProgress,
        onSendProgress: requestOptions.onSendProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
