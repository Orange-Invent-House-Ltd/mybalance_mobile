import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mybalanceapp/features/auth/data/data.dart';

import '../../../core/provider.dart';
import '../logic/auth_notifier.dart';
import '../logic/auth_state.dart';

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
  );
});

final authProvider =
    StateNotifierProvider.autoDispose<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return AuthNotifier(
    authRepository: authRepository,
  );
});
