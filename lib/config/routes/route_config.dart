import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/components/rest_client/rest_client.dart';
import '../../core/utils/extensions/string_extension.dart';
import '../../core/widgets/loading_page.dart';
import '../../features/auth/views/provider.dart';
import '../../features/auth/views/views.dart';
import '../../features/onboarding/views/views.dart';
import '../../features/dashboard/views/views.dart';
import './error_view.dart';
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
      // redirect: RedirectBuilder({
      //   RedirectIfAuthenticatedGuard(),
      //   RedirectIfUnauthenticatedGuard(),
      // }).call,
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
          builder: (_, __) => const OnboardStoryView(),
        ),
        GoRoute(
          name: RouteName.loading,
          path: RouteName.loading.toPath(),
          pageBuilder: (_, __) => const NoTransitionPage(child: LoadingPage()),
        ),
        GoRoute(
          name: RouteName.signIn,
          path: RouteName.signIn.toPath(),
          builder: (_, __) => const SigninView(),
        ),
        GoRoute(
          name: RouteName.signUp,
          path: RouteName.signUp.toPath(),
          builder: (_, __) => const SignupView(),
        ),
        GoRoute(
          name: RouteName.forgetPassword,
          path: RouteName.forgetPassword.toPath(),
          builder: (_, __) => const ForgetPasswordView(),
        ),
        GoRoute(
          name: RouteName.checkEmail,
          path: RouteName.checkEmail.toPath(),
          builder: (_, state) {
            final String email = state.uri.queryParameters['email']!;
            return CheckYourMailView(email: email);
          },
        ),
        GoRoute(
          name: RouteName.dashboard,
          path: RouteName.dashboard.toPath(),
          builder: (_, __) => const DashboardView(),
          routes: [
            GoRoute(
              name: RouteName.createLink,
              path: RouteName.createLink,
              builder: (_, __) => const CreateLinkView(),
            ),
            GoRoute(
              name: RouteName.depositMoney,
              path: RouteName.depositMoney,
              builder: (_, __) => const DeposiitMoneyView(),
            ),
          ],
        ),
      ],
    );
  },
);
