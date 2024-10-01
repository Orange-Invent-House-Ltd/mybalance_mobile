import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/provider.dart';

final appStartupProvider = FutureProvider<void>((ref) async {
  ref.onDispose(() {
    ref.invalidate(sharedPrefProvider);
  });
  await Future.wait([
    ref.watch(sharedPrefProvider.future),
  ]);
});
