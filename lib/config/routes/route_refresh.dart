import 'dart:async';

import 'package:flutter/foundation.dart';

class GoRouterRefreshStream<T> extends ChangeNotifier {
  GoRouterRefreshStream(Stream<T> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
