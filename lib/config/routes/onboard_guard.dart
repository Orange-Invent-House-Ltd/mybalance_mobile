import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'redirect_builder.dart';

final class RedirectIfOnboarded extends Guard {
  @override
  Pattern get matchPattern => RegExp('onboard');

  @override
  String? redirect(BuildContext context, GoRouterState state) {
    // TODO: implement redirect
    throw UnimplementedError();
  }
}
