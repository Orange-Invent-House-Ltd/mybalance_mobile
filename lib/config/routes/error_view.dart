import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/routes/route_name.dart';
import '../../../core/utils/extensions/string_extension.dart';

class ErrorView extends ConsumerWidget {
  const ErrorView({super.key, required this.location});
  final String location;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '404',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16.0),
          Text(location),
          Wrap(
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.go(RouteName.signIn.toPath());
                },
                child: const Text('go to Login'),
              ),
              const SizedBox(width: 32.0),
              ElevatedButton(
                onPressed: () {
                  context.go(RouteName.dashboard.toPath());
                },
                child: const Text('go to Home'),
              ),
              const SizedBox(width: 32.0),
              ElevatedButton(
                onPressed: () {
                  context.go(RouteName.onboard.toPath());
                },
                child: const Text('go to onboarding'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
