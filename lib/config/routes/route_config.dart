import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/shared/widgets/loading_page.dart';
import '../../core/utils/extensions/string_extension.dart';
import '../../features/auth/views/providers/provider.dart';
import '../../features/auth/views/views.dart';
import '../../features/core/views/views.dart';
import '../../features/dispute/views/views.dart';
import '../../features/notification/views/views.dart';
import '../../features/onboarding/views/provider/provider.dart';
import '../../features/onboarding/views/views.dart';
import '../../features/transaction/views/views.dart';
import './error_view.dart';
import './redirect_guards/guards.dart';
import './route_name.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>(
  (ref) {
    final authStatusStream = ref.watch(authRepositoryProvider).authStatus;
    // final authStatusAsync = ref.watch(authStatusProvider);
    final authStatusAsync = ref.watch(authProvider);
    final onboardedStatusAsync = ref.watch(onboardedStatusProvider);

    final authStatus = authStatusAsync.status;
    final isOnboarded = onboardedStatusAsync.value ?? false;

    final refreshNotifier = GoRouterRefreshStream(authStatusStream);
    ref.onDispose(refreshNotifier.dispose);
    return GoRouter(
      debugLogDiagnostics: true,
      initialLocation: RouteName.onboard.toPath(),
      navigatorKey: navigatorKey,
      redirect: (context, state) => RedirectBuilder({
        RedirectIfOnboarded(isOnboarded),
        RedirectIfAuthenticatedGuard(authStatus),
        RedirectIfUnauthenticatedGuard(authStatus),
      }).call(context, state),
      refreshListenable: refreshNotifier,
      errorBuilder: (_, state) {
        final location = state.matchedLocation;
        return ErrorView(location: location);
      },
      routes: [
        GoRoute(
          name: RouteName.onboard,
          path: RouteName.onboard.toPath(),
          builder: (_, __) => const OnboardStoryView(),
          // redirect:
        ),
        GoRoute(
          name: RouteName.loading,
          path: RouteName.loading.toPath(),
          pageBuilder: (_, state) {
            final String loadFrom = state.uri.queryParameters['loadingFrom']!;
            return NoTransitionPage(
              child: LoadingPage(loadFrom: loadFrom),
            );
          },
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
              builder: (_, __) => const DepositMoneyView(),
            ),
            GoRoute(
              name: RouteName.unlockMoney,
              path: RouteName.unlockMoney,
              builder: (_, __) => const UnlockMoneyView(),
            ),
            GoRoute(
              name: RouteName.withdrawMoney,
              path: RouteName.withdrawMoney,
              builder: (_, __) => const WithdrawMoneyView(),
            ),
            GoRoute(
              name: RouteName.withdrawFunds,
              path: RouteName.withdrawFunds,
              builder: (_, __) => const WithdrawMoneyView(),
            ),
            GoRoute(
              name: RouteName.quickAction,
              path: RouteName.quickAction,
              builder: (_, state) {
                final String? indexString = state.uri.queryParameters['index'];
                final int? index = int.tryParse(indexString ?? '');
                return QuickActionsView(index: index);
              },
            ),
          ],
        ),
        GoRoute(
          name: RouteName.notification,
          path: RouteName.notification.toPath(),
          builder: (_, __) => const NotificatificationsView(),
        ),
        GoRoute(
          name: RouteName.transactionHistory,
          path: RouteName.transactionHistory.toPath(),
          builder: (_, __) => const TransactionHistoryView(),
        ),
        GoRoute(
          name: RouteName.transactionDetails,
          path: RouteName.transactionDetails.toPath(),
          builder: (_, state) {
            final id = state.uri.queryParameters['id']!;
            return ViewTransDetail(id: id);
          },
        ),
        GoRoute(
          name: RouteName.disputeResolutionRaise,
          path: RouteName.disputeResolutionRaise.toPath(),
          builder: (_, state) {
            final String? transId = state.uri.queryParameters['id'];
            return DisputeResolutionRaiseView(transactionId: transId);
          },
        ),
        GoRoute(
          name: RouteName.disputeResolution,
          path: RouteName.disputeResolution.toPath(),
          builder: (_, __) => const DisputeResolutionView(),
          routes: [
            GoRoute(
              name: RouteName.disputeResolutionChat,
              path: '${RouteName.disputeResolutionChat}:id',
              builder: (_, state) {
                final String? id = state.pathParameters['id'];
                return DisputeResolutionChatView(id: id);
              },
            ),
          ],
        ),
        GoRoute(
          name: RouteName.profile,
          path: RouteName.profile.toPath(),
          builder: (_, __) => const ProfileView(),
        ),
        GoRoute(
          name: RouteName.settings,
          path: RouteName.settings.toPath(),
          builder: (_, __) => const SettingsView(),
        ),
      ],
    );
  },
);
