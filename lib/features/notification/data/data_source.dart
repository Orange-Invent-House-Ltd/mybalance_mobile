import '../../../core/components/rest_client/rest_client.dart';

class NotificationDataSource {
  NotificationDataSource({required RestClient client}) : _client = client;

  final RestClient _client;

  Future<List> getNotifications(String page, String size) async {
    final response = await _client
        .get('/notifications/', queryParams: {'page': page, "size": size});

    final notifications = response!['data'] as List;
    return notifications;
  }

  Future<Map<String, dynamic>> getNotification(String id) async {
    final response = await _client.get('/notifications/$id');
    final notification = response!['data'] as Map<String, dynamic>;
    return notification;
  }
}
