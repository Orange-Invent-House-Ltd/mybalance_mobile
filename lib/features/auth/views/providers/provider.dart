import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/components/rest_client/src/auth/authentication_status.dart';
import '../../../../core/provider.dart';
import '../../data/data.dart';
import '../../logic/auth_notifier.dart';
import '../../logic/auth_state.dart';

final authDataSourceProvider = Provider<AuthDataSource>((ref) {
  final restClient = ref.read(restClientProvider);
  return AuthDataSourceImpl(restClient: restClient);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final tokenStorage = ref.read(tokenStorageProvider);
  final authDataSource = ref.read(authDataSourceProvider);
  return AuthRepositoryImpl(
    authDataSource: authDataSource,
    tokenStorage: tokenStorage,
    preferencesDao: ref.read(sharedDaoProvider),
  );
});

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return AuthNotifier(
    authRepository: authRepository,
  );
});

// final goRouterRefreshProvider = Provider<GoRouterRefreshStream>((ref) {
//   final tokenStorage = ref.watch(tokenStorageProvider);
//   return GoRouterRefreshStream(tokenStorage);
// });

final authStatusProvider = StreamProvider<AuthenticationStatus>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStatus;
});