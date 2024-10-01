import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/components/rest_client/rest_client.dart';
import '../../core/utils/extensions/string_extension.dart';
import '../../features/auth/views/provider.dart';
import '../../features/auth/views/views.dart';
import '../../features/onboarding/views/views.dart';
import './auth_guards.dart';
import './error_view.dart';
import './redirect_builder.dart';
import './route_name.dart';
import './route_refresh.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>(
  (ref) {
    final authStream = ref.watch(authRepositoryProvider).authStatus;
    return GoRouter(
      debugLogDiagnostics: true,
      initialLocation: RouteName.onboard.toPath(),
      navigatorKey: _navigatorKey,
      redirect: RedirectBuilder({
        RedirectIfAuthenticatedGuard(),
        RedirectIfUnauthenticatedGuard(),
      }).call,
      refreshListenable:
          GoRouterRefreshStream<AuthenticationStatus>(authStream),
      errorBuilder: (_, state) {
        final location = state.matchedLocation;
        return ErrorView(location: location);
      },
      routes: [
        GoRoute(
          name: RouteName.onboard,
          path: RouteName.onboard.toPath(),
          builder: (context, state) => const OnboardStoryView(),
        ),
        GoRoute(
          name: RouteName.signIn,
          path: RouteName.signIn.toPath(),
          builder: (context, state) => const SigninView(),
        ),
        GoRoute(
          name: RouteName.signUp,
          path: RouteName.signUp.toPath(),
          builder: (context, state) => const SignupView(),
        ),
      ],
    );
  },
);
