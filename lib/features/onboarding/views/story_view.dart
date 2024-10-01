import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/routes/route_name.dart';
import '../../../core/utils/extensions/string_extension.dart';

class OnboardStoryView extends StatefulWidget {
  const OnboardStoryView({super.key});

  @override
  State<OnboardStoryView> createState() => _OnboardStoryViewState();
}

class _OnboardStoryViewState extends State<OnboardStoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Onboard Story View'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => context.go(RouteName.signIn.toPath()),
            child: const Text('Complete Onboarding'),
          ),
        ],
      ),
    );
  }
}
