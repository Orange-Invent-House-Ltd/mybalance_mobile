import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../config/routes/route_name.dart';
import '../../../config/themes/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/label_text_field.dart';
import '../../../core/widgets/overlay_loading.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailController;
  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.b300,
        elevation: 0,
      ),
      body: OverlayLoading(
        isLoading: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppAssets.logo,
                    height: 50,
                    width: 50,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Forgot Password?',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.b300,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'No worries, we\'ll send you reset instructions',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: AppColors.g200),
                  ),
                  const SizedBox(height: 32),
                  LabelTextField(
                    controller: _emailController,
                    label: 'Email',
                    validator: Validator.emailValidator,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ValueListenableBuilder(
                      valueListenable: _emailController,
                      child: const Text('Reset Password'),
                      builder: (context, value, child) {
                        return ElevatedButton(
                          onPressed:
                              Validator.isEmailValid(_emailController.text)
                                  ? () {
                                      context.pushNamed(
                                        RouteName.checkEmail,
                                        queryParameters: {
                                          'email': _emailController.text
                                        },
                                      );
                                    }
                                  : null,
                          child: child,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
