import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../config/routes/route_name.dart';
import '../../../config/themes/app_colors.dart';
import '../../../core/components/rest_client/rest_client.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/utils/extensions/string_extension.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/label_text_field.dart';
import '../../../core/widgets/overlay_loading.dart';
import '../../../core/widgets/sizedbox.dart';
import '../../../core/widgets/toast.dart';
import '../logic/auth_state.dart';
import './providers/provider.dart';

class ForgetPasswordView extends ConsumerStatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  ConsumerState<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends ConsumerState<ForgetPasswordView> {
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

  Future<void> _trySubmit(String email) async {
    if (_formKey.currentContext != null && _formKey.currentState!.validate()) {
      await ref.read(authProvider.notifier).forgetPassword(
            email,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoading = ref.watch(authProvider).maybeMap(
          orElse: () => false,
          processing: (_) => true,
        );
    final ThemeData theme = Theme.of(context);
    ref.listen<AuthState>(
      authProvider,
      (prev, next) {
        next.maybeMap(
          error: (value) {
            log("from: ${ModalRoute.of(context)!.settings.name!}");

            String errorMessage = 'An error occurred';
            if (value.error is RestClientException) {
              final ff = value.error as RestClientException;
              errorMessage = ff.message;
              log(errorMessage);
            }
            AppToast.error(errorMessage);
          },
          idle: (value) {
            if (value.status == AuthenticationStatus.unauthenticated &&
                prev?.maybeMap(processing: (_) => true, orElse: () => false) ==
                    true) {
              // if (context.mounted) {
              context.pushNamed(
                RouteName.checkEmail,
                queryParameters: {'email': _emailController.text},
              );
              // }
            }
          },
          orElse: () {},
        );
      },
    );
    return Scaffold(
      appBar: CustomAppBar(
        theme: theme,
        onBack: () => context.go(RouteName.signIn.toPath()),
      ),
      body: OverlayLoading(
        isLoading: isLoading,
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
                    height: 50.r,
                    width: 50.r,
                  ),
                  const Height(32),
                  Text(
                    'Forgot Password?',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.b300,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                    ),
                  ),
                  const Height(8),
                  Text(
                    'No worries, we\'ll send you reset instructions',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: AppColors.g200),
                  ),
                  const Height(32),
                  LabelTextField(
                    controller: _emailController,
                    label: 'Email',
                    validator: Validator.emailValidator,
                  ),
                  const Height(24),
                  SizedBox(
                    width: double.infinity,
                    height: 44.h,
                    child: ValueListenableBuilder(
                      valueListenable: _emailController,
                      child: const Text('Reset Password'),
                      builder: (context, value, child) {
                        return ElevatedButton(
                          onPressed:
                              Validator.isEmailValid(_emailController.text)
                                  ? () async {
                                      await _trySubmit(_emailController.text);
                                      if (context.mounted) {}
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
