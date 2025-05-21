import '../models/notification_model.dart';
import './data_source.dart';

class NotificationRepository {
  NotificationRepository({required NotificationDataSource dataSource})
      : _dataSource = dataSource;
  final NotificationDataSource _dataSource;

  Future<List<Notification>> notifications(String page, String size) async {
    final notifi = await _dataSource.getNotifications(page, size);
    final notifications = notifi
        .whereType<Map<String, dynamic>>()
        .map((json) => Notification.fromJson(json))
        .toList();
    return notifications;
  }

  Future<Notification> notification(String id) async {
    final notifi = await _dataSource.getNotification(id);
    final notification = Notification.fromJson(notifi);
    return notification;
  }
}
