import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/routes/route_config.dart';
import '../config/themes/app_theme.dart';
import '../core/constants/localization/localization.dart';

class MyBalanceApp extends ConsumerWidget {
  const MyBalanceApp({super.key});

  static final _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'My Balance',
      // showSemanticsDebugger: true,
      localizationsDelegates: Localization.localizationDelegates,
      supportedLocales: Localization.supportedLocales,
      theme: AppTheme.lightTheme(),
      routerConfig: ref.watch(goRouterProvider),
      builder: (context, child) => MediaQuery.withClampedTextScaling(
        key: _globalKey,
        minScaleFactor: 1.0,
        maxScaleFactor: 2.0,
        child: child!,
      ),
    );
  }
}
