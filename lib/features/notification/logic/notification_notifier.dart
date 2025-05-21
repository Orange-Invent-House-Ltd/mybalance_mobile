// notification_pagination_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/notification_model.dart';
import '../views/provider/notification_provider.dart';

class NotificationNotifier extends AsyncNotifier<List<Notification>> {
  final int _pageSize = 10;
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isFetchingMore = false;

  List<Notification> _allNotifications = [];

  @override
  Future<List<Notification>> build() async {
    return _fetchPage(reset: true);
  }

  Future<List<Notification>> _fetchPage({bool reset = false}) async {
    final repo = ref.read(notificationRepoProvider);

    if (reset) {
      _currentPage = 1;
      _hasMore = true;
      _allNotifications = [];
    }

    final fetched = await repo.notifications(_currentPage.toString(), _pageSize.toString());

    if (fetched.length < _pageSize) {
      _hasMore = false;
    }

    if (reset) {
      _allNotifications = fetched;
    } else {
      _allNotifications.addAll(fetched);
    }

    _currentPage++;
    return _allNotifications;
  }

  bool get hasMore => _hasMore;

  Future<void> loadMore() async {
    if (!_hasMore || _isFetchingMore) return;

    _isFetchingMore = true;

    try {
      final updatedList = await _fetchPage();
      state = AsyncData(updatedList);
    } catch (e, st) {
      state = AsyncError(e, st);
    } finally {
      _isFetchingMore = false;
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchPage(reset: true));
  }
}


