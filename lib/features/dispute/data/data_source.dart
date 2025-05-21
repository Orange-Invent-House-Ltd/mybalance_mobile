import '../../../core/components/rest_client/rest_client.dart';

class DisputeDataSource {
  DisputeDataSource({required RestClient client}) : _client = client;

  final RestClient _client;

  Future<Map<String, dynamic>> createDispute(Map<String, dynamic> data) async {
    final response = await _client.get("/dispute/");
    final dispute = response!['data'] as Map<String, dynamic>;
    return dispute;
  }

  Future<List> getAllDispute(String page, String size) async {
    final response = await _client.get('/dispute/');
    final disputes = response!['data'] as List;
    return disputes;
  }
}
