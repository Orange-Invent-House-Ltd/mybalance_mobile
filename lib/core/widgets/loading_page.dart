import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.w50,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CupertinoActivityIndicator(
            radius: 20.0,
            color: AppColors.p300,
          ),
          const SizedBox(
            height: 24.0,
            width: double.infinity,
          ),
          Text(
            'Loading! Please wait...',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.b300),
          ),
        ],
      ),
    );
  }
}
