import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../config/routes/route_name.dart';
import '../../../config/themes/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/utils/extensions/string_extension.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/app_rich_text.dart';
import '../../../core/widgets/label_text_field.dart';
import '../../../core/widgets/overlay_loading.dart';

class SigninView extends StatefulWidget {
  const SigninView({super.key});

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  late GlobalKey<FormState> _formKey;
  late final TextEditingController _emailController, _passwordController;
  late ValueNotifier<bool> _passwordObscure;
  late ValueNotifier<bool> _isBuyer;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordObscure = ValueNotifier(false);
    _isBuyer = ValueNotifier(false);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordObscure.dispose();
    _isBuyer.dispose();
    super.dispose();
  }

  void _trySignin(String email, String password) {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      context.go(RouteName.dashboard.toPath());
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: OverlayLoading(
          isLoading: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        AppAssets.logo,
                        height: 50,
                        width: 50,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Log in to your account',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: AppColors.b300,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    ValueListenableBuilder(
                      valueListenable: _isBuyer,
                      builder: (context, value, child) {
                        return Text(
                          'Welcome back! Please enter your ${value ? 'buyer' : 'seller'} details and access your dashboard.',
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: AppColors.g200),
                        );
                      },
                    ),
                    const SizedBox(height: 16.0),
                    LabelTextField(
                      controller: _emailController,
                      validator: (value) => Validator.emailValidator(value),
                      label: 'Email',
                      hintText: 'test@test.com',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 20),
                    ValueListenableBuilder(
                        valueListenable: _passwordObscure,
                        builder: (context, value, child) {
                          return LabelTextField(
                            controller: _passwordController,
                            label: 'Password',
                            textInputAction: TextInputAction.done,
                            obscureText: !value,
                            suffixIcon: IconButton(
                              onPressed: () {
                                _passwordObscure.value =
                                    !_passwordObscure.value;
                              },
                              icon: Icon(
                                value
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                            ),
                          );
                        }),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () => context.push(
                          RouteName.forgetPassword.toPath(),
                        ),
                        child: Text(
                          'Forgot Password?',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: AppColors.g300,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: double.infinity,
                      child: ListenableBuilder(
                          listenable: Listenable.merge(
                            [_emailController, _passwordController],
                          ),
                          builder: (context, child) {
                            return ElevatedButton(
                              onPressed: _emailController.text.isEmpty ||
                                      _passwordController.text.isEmpty
                                  ? null
                                  : () {
                                      _trySignin(
                                        _emailController.text,
                                        _passwordController.text,
                                      );
                                    },
                              child: const Text('Login'),
                            );
                          }),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: AppRichText(
                        onSecondaryTap: () {
                          context.go(RouteName.signUp.toPath());
                        },
                        primaryText: 'Don\'t have an account?',
                        secondaryText: 'Create one',
                      ),
                    ),
                    const SizedBox(height: 32),
                    Align(
                      alignment: Alignment.center,
                      child: AppRichText(
                        onSecondaryTap: () {},
                        primaryText: 'Can\'t verify my email?',
                        secondaryText: 'Verify now',
                        secondaryColor: AppColors.p400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
