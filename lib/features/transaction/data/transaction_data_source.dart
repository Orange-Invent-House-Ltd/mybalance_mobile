import 'dart:developer';

import '../../../core/components/rest_client/rest_client.dart';

class TransactionDataSource {
  TransactionDataSource({required RestClient restClient})
      : _restClient = restClient;
  final RestClient _restClient;

  Future<List> fetchTransactions(
    int page,
    int size,
  ) async {
    final response = await _restClient.get('/transaction/', queryParams: {
      'page': '$page',
      'size': '$size',
    });
    final data = response!['data'] as List;
    log(data.runtimeType.toString());
    return data;
  }

  Future<Map<String, dynamic>> fetchTransaction(String id) async {
    final response = await _restClient.get('/transaction/link/$id');
    final data = response!['data'] as Map<String, dynamic>;
    return data;
  }
}
