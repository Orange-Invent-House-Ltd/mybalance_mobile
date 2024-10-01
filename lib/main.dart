import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mybalanceapp/app/app.dart';

import 'app/app_startup.dart';

void main() {
  runApp(
    ProviderScope(
      child: AppStartupWidget(
        onLoaded: (context) => const MyBalanceApp(),
      ),
    ),
  );
}
