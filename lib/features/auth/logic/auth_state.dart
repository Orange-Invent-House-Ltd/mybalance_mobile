import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/components/rest_client/rest_client.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.idle({
    required AuthenticationStatus status,
  }) = _Idle;

  const factory AuthState.processing({
    required AuthenticationStatus status,
  }) = _Processing;

  const factory AuthState.error({
    required AuthenticationStatus status,
    required Object error,
  }) = _Error;
}
