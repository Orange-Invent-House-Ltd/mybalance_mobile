import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/provider.dart';
import '../../data/data_source.dart';
import '../../data/repository.dart';
import '../../logic/notification_notifier.dart';
import '../../models/notification_model.dart';

final _notifiDataSourceProvider = Provider<NotificationDataSource>((ref) {
  final client = ref.read(restClientAuthProvider);
  return NotificationDataSource(client: client);
});

final notificationRepoProvider = Provider<NotificationRepository>((ref) {
  final dataSource = ref.read(_notifiDataSourceProvider);

  return NotificationRepository(dataSource: dataSource);
});

// final notificationsProvider = FutureProvider.family
//     .autoDispose<List<Notification>, (String, String)>((ref, param) async {
//   final repo = ref.read(notificationRepoProvider);
//   return await repo.notifications(param.$1, param.$2);
// });

final notificationProvider =
    FutureProvider.autoDispose.family<Notification, String>((ref, id) async {
  final repo = ref.read(notificationRepoProvider);
  return await repo.notification(id);
});

final notificationsProvider =
    AsyncNotifierProvider<NotificationNotifier, List<Notification>>(
  NotificationNotifier.new,
);