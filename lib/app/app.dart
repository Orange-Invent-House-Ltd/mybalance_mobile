import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

import '../config/routes/route_config.dart';
import '../config/themes/app_theme.dart';
import '../core/constants/localization/localization.dart';

class MyBalanceApp extends ConsumerWidget {
  const MyBalanceApp({super.key});

  static final _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return ToastificationWrapper(
          child: MaterialApp.router(
            title: 'My Balance',
            // debugShowCheckedModeBanner: false,
            // showSemanticsDebugger: true,
            localizationsDelegates: Localization.localizationDelegates,
            supportedLocales: Localization.supportedLocales,
            theme: AppTheme.lightTheme(),
            routerConfig: ref.watch(goRouterProvider),
            builder: (context, child) => MediaQuery.withClampedTextScaling(
              key: _globalKey,
              minScaleFactor: 1.0,
              maxScaleFactor: 1.0,
              child: child!,
            ),
          ),
        );
      },
    );
  }
}
