import '../../components/rest_client/rest_client.dart';

class BankDataSource {
  final RestClient _restClient;

  BankDataSource({required RestClient restClient}) : _restClient = restClient;
  Future<List<dynamic>> getBanksList() async {
    final response = await _restClient.get('/shared/banks');
    // log('from bank data source $response');
    return response?['data'] as List? ?? [];
  }
}
