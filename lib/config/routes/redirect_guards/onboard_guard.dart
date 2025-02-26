import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:mybalanceapp/core/utils/extensions/string_extension.dart';

import '../route_name.dart';
import 'redirect_builder.dart';

final class RedirectIfOnboarded extends Guard {
  RedirectIfOnboarded(this.isOnboarded);
  final bool isOnboarded;

  @override
  Pattern get matchPattern => RegExp(RouteName.onboard.toPath());

  @override
  String? redirect(BuildContext context, GoRouterState state) {
    return isOnboarded ? RouteName.signIn.toPath() : null;
  }
}
