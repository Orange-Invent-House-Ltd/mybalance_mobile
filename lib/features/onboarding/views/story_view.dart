import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/routes/route_name.dart';
import '../../../core/utils/extensions/string_extension.dart';
import '../../../core/shared/widgets/sizedbox.dart';
import 'provider/provider.dart';

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
          const Height(20),
          Consumer(builder: (context, ref, child) {
            return ElevatedButton(
              onPressed: () {
                ref.read(onboardSetProvider);
                context.go(RouteName.signIn.toPath());
              },
              child: const Text('Complete Onboarding'),
            );
          }),
        ],
      ),
    );
  }
}
