import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';

import 'app_startup_failed.dart';
import 'app_startup_loading.dart';
import 'provider.dart';

class AppStartupWidget extends ConsumerWidget {
  const AppStartupWidget({super.key, required this.onLoaded});
  final WidgetBuilder onLoaded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStartupState = ref.watch(appStartupProvider);
    return appStartupState.when(
      data: (_) => ToastificationWrapper(child: onLoaded(context)),
      error: (error, stackTrace) => AppStartupErrorWidget(
        error: error,
        stackTrace: stackTrace,
        retryInitialization: () async {
          ref.invalidate(appStartupProvider);
        },
      ),
      loading: () => const AppStartupLoadingWidget(),
    );
  }
}
