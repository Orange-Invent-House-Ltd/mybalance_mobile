import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../core/components/rest_client/src/auth/authentication_status.dart';
import '../../../core/utils/extensions/string_extension.dart';
import '../route_name.dart';
import './redirect_builder.dart';

final class RedirectIfAuthenticatedGuard extends Guard {
  RedirectIfAuthenticatedGuard(this.authStatus);
  final AuthenticationStatus authStatus;

  // matches login and signup routes
  @override
  Pattern get matchPattern => RegExp(RouteName.signIn.toPath());

  @override
  String? redirect(BuildContext context, GoRouterState state) {
    debugPrint('authenticated');
    debugPrint('status: $authStatus');
    return authStatus == AuthenticationStatus.authenticated
        ? RouteName.dashboard.toPath()
        : null;
  }
}

final class RedirectIfUnauthenticatedGuard extends Guard {
  RedirectIfUnauthenticatedGuard(this.authStatus);
  final AuthenticationStatus authStatus;

  // matches dashboard and settings routes
  @override
  Pattern get matchPattern =>
      RegExp(r'^/(signup|signup|onboard|forget-password|check-email)$');

  @override
  bool get invertRedirect => true;

  @override
  String? redirect(BuildContext context, GoRouterState state) {
    debugPrint('unauthenticated');
    debugPrint('status: $authStatus');
    return authStatus == AuthenticationStatus.unauthenticated
        ? RouteName.signIn.toPath()
        : null;
  }
}
