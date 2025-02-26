import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../core/components/rest_client/src/auth/authentication_status.dart';

class GoRouterRefreshStream<T> extends ChangeNotifier {
  GoRouterRefreshStream(Stream<AuthenticationStatus> authStatus) {
    _subscription = authStatus.listen((_) => notifyListeners());
  }

  late final StreamSubscription<AuthenticationStatus> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
