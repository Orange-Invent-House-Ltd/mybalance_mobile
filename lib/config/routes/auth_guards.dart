import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../core/components/rest_client/rest_client.dart';
import '../../core/utils/extensions/context_extension.dart';
import '../../core/utils/extensions/string_extension.dart';
import '../../features/auth/views/provider.dart';
import './redirect_builder.dart';
import './route_name.dart';

final class RedirectIfAuthenticatedGuard extends Guard {
  // matches login and signup routes
  @override
  Pattern get matchPattern => RegExp(r'^/(login|signup)$');

  @override
  String? redirect(BuildContext context, GoRouterState state) {
    final auth = context.read(authProvider);
    debugPrint('authenticated');
    debugPrint('auth.status: ${auth.status}');

    if (auth.status == AuthenticationStatus.authenticated) {
      return RouteName.dashboard.toPath();
    }

    return null;
  }
}

final class RedirectIfUnauthenticatedGuard extends Guard {
  // matches dashboard and settings routes
  @override
  Pattern get matchPattern => RegExp(r'^/(login|signup|onboard)$');

  @override
  bool get invertRedirect => true;

  @override
  String? redirect(BuildContext context, GoRouterState state) {
    final auth = context.read(authProvider);
    // print('unauthenticated');
    // print('auth.status: ${auth.status}');

    if (auth.status == AuthenticationStatus.unauthenticated) {
      return RouteName.signIn.toPath();
    }

    return null;
  }
}
