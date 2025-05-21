import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/themes/app_colors.dart';
import '../../../core/components/rest_client/src/exception/network_exception.dart';
import '../../../core/shared/widgets/custom_app_bar.dart';
import '../../../core/shared/widgets/label_text_field.dart';
import '../../../core/shared/widgets/overlay_loading.dart';
import '../../../core/shared/widgets/sizedbox.dart';
import '../../../core/shared/widgets/toast.dart';
import '../../../core/utils/validators.dart';
import 'provider/profile_provider.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  @override
  ConsumerState<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  late TextEditingController _oldPasswordController,
      _newPasswordController,
      _retypePasswordController,
      _oldPhoneController,
      _newPhoneController,
      _retypePhoneController;
  late GlobalKey<FormState> _passwordFormKey;
  late GlobalKey<FormState> _phoneFormKey;

  @override
  void initState() {
    super.initState();
    _passwordFormKey = GlobalKey<FormState>();
    _phoneFormKey = GlobalKey<FormState>();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _retypePasswordController = TextEditingController();
    _oldPhoneController = TextEditingController();
    _newPhoneController = TextEditingController();
    _retypePhoneController = TextEditingController();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _retypePasswordController.dispose();
    _oldPhoneController.dispose();
    _newPhoneController.dispose();
    _retypePhoneController.dispose();
    showChangePassword.dispose();
    showChangePhone.dispose();
    super.dispose();
  }

  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  final ValueNotifier<bool> showChangePassword = ValueNotifier<bool>(true);
  final ValueNotifier<bool> showChangePhone = ValueNotifier<bool>(false);

  Future<void> _tryChangePassword(
      String currentPassword, String password, String confirmPassword) async {
    if (_passwordFormKey.currentState != null &&
        _passwordFormKey.currentState!.validate()) {
      _isLoading.value = true;
      final provider = ref.read(
          changePasswordProvider((currentPassword, password, currentPassword)));
      provider.when(
        data: (_) => AppToast.success('Password Successfully changed'),
        loading: () => _isLoading.value = true,
        error: (error, stackTrace) {
          error as RestClientException;
          AppToast.error('${error.message}: password is incorrect');
        },
      );
      _isLoading.value = false;
    }
  }

  Future<void> _tryChangePhone(String oldPhone, String newPhone) async {
    if (_phoneFormKey.currentState != null &&
        _phoneFormKey.currentState!.validate()) {
      _isLoading.value = true;
      final provider = ref.read(changePhoneProvider(newPhone));
      provider.when(
        data: (_) => AppToast.success('Phone number Successfully changed'),
        error: (error, stackTrace) {
          error as RestClientException;
          // AppToast.error('${error.message}: password is incorrect');
        },
        loading: () => _isLoading.value = true,
      );
      _isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        theme: theme,
        text: 'Settings',
      ),
      body: ValueListenableBuilder(
          valueListenable: _isLoading,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Text(
                  'Make changes to your number, password and so on.',
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: AppColors.g500),
                ),
                const Height(32),
                SettingsButton(
                  onTap: () {
                    showChangePhone.value = false;
                    showChangePassword.value = !showChangePassword.value;
                  },
                  title: 'Change Password',
                  isCurrent: showChangePassword,
                ),
                const Height(24),
                ValueListenableBuilder(
                    valueListenable: showChangePassword,
                    builder: (context, value, child) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        switchInCurve: Curves.easeInOutCubicEmphasized,
                        switchOutCurve: Curves.easeInOutCubicEmphasized,
                        transitionBuilder: (widget, animation) {
                          return SizeTransition(
                            sizeFactor: animation,
                            child: FadeTransition(
                              opacity: animation,
                              child: widget,
                            ),
                          );
                        },
                        child: value
                            ? _buildChangePassword(theme)
                            : const SizedBox.shrink(),
                      );
                    }),
                SettingsButton(
                  onTap: () {
                    showChangePassword.value = false;
                    showChangePhone.value = !showChangePhone.value;
                  },
                  title: 'Change Phone',
                  isCurrent: showChangePhone,
                  icon: Icons.phone_outlined,
                ),
                const Height(24),
                ValueListenableBuilder(
                  valueListenable: showChangePhone,
                  builder: (context, value, child) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      switchInCurve: Curves.easeInOutCubicEmphasized,
                      switchOutCurve: Curves.easeInOutCubicEmphasized,
                      transitionBuilder: (widget, animation) {
                        return SizeTransition(
                          sizeFactor: animation,
                          child: FadeTransition(
                            opacity: animation,
                            child: widget,
                          ),
                        );
                      },
                      child: value
                          ? _buildChangePhone(theme)
                          : const SizedBox.shrink(),
                    );
                  },
                ),
              ],
            ),
          ),
          builder: (context, value, child) {
            return OverlayLoading(isLoading: value, child: child!);
          }),
    );
  }

  Form _buildChangePhone(ThemeData theme) {
    return Form(
      key: _phoneFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Change Phone',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 17.sp,
              color: AppColors.b300,
            ),
          ),
          const Height(12),
          Text(
            'Use the form below to change your phone.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.g500,
            ),
          ),
          const Height(16),
          LabelTextField(
            controller: _oldPhoneController,
            label: 'Old Phone number',
            hintText: '+234 000 0000 000',
            obscureText: true,
          ),
          const Height(16),
          LabelTextField(
            controller: _newPhoneController,
            label: 'New Phone number',
            hintText: '+234 000 0000 000',
            obscureText: true,
            validator: (value) => Validator.phoneValidator(value),
          ),
          const Height(16),
          LabelTextField(
            controller: _retypePhoneController,
            label: 'Retype Phone number',
            hintText: '+234 000 0000 000',
            obscureText: true,
            validator: (value) {
              debugPrint('Value: $value');
              return Validator.confirmPhoneValidator(
                value,
                _newPhoneController.text,
              );
            },
          ),
          const Height(24),
          SizedBox(
            width: double.infinity,
            child: ListenableBuilder(
              listenable: Listenable.merge([
                _oldPhoneController,
                _newPhoneController,
                _retypePhoneController,
              ]),
              builder: (context, child) {
                return ElevatedButton(
                  onPressed: _oldPhoneController.text.isEmpty ||
                          _newPhoneController.text.isEmpty ||
                          _retypePhoneController.text.isEmpty
                      ? null
                      : () async {
                          await _tryChangePhone(
                            _oldPasswordController.text,
                            _newPasswordController.text,
                          );
                        },
                  child: const Text('Change Phone'),
                );
              },
            ),
          ),
          const Height(32),
        ],
      ),
    );
  }

  Form _buildChangePassword(ThemeData theme) {
    return Form(
      key: _passwordFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Change Password',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 17.sp,
              color: AppColors.b300,
            ),
          ),
          const Height(12),
          Text(
            'Use the form below to change your password.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.g500,
            ),
          ),
          const Height(16),
          LabelTextField(
            controller: _oldPasswordController,
            label: 'Old Password',
            hintText: 'e.g Albert',
            obscureText: true,
          ),
          const Height(16),
          LabelTextField(
            controller: _newPasswordController,
            label: 'New Password',
            hintText: 'e.g Albert',
            obscureText: true,
            validator: (value) => Validator.passwordValidator(value),
          ),
          const Height(16),
          LabelTextField(
            controller: _retypePasswordController,
            label: 'Retype Password',
            hintText: 'e.g Albert',
            obscureText: true,
            validator: (value) {
              debugPrint('Value: $value');
              return Validator.confirmPasswordValidator(
                value,
                _newPasswordController.text,
              );
            },
          ),
          const Height(24),
          Text.rich(
            TextSpan(
              text: 'Note: ',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xff667085),
              ),
              children: [
                TextSpan(
                  text:
                      'Clicking on change password will log you out of MyBalance.',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const Height(24),
          SizedBox(
            width: double.infinity,
            child: ListenableBuilder(
                listenable: Listenable.merge([
                  _oldPasswordController,
                  _newPasswordController,
                  _retypePasswordController,
                ]),
                builder: (context, child) {
                  return ElevatedButton(
                    onPressed: _oldPasswordController.text.isEmpty ||
                            _newPasswordController.text.isEmpty ||
                            _retypePasswordController.text.isEmpty
                        ? null
                        : () async {
                            await _tryChangePassword(
                              _oldPasswordController.text,
                              _newPasswordController.text,
                              _retypePasswordController.text,
                            );
                          },
                    child: const Text('Change Password'),
                  );
                }),
          ),
          const Height(24),
        ],
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    super.key,
    required this.onTap,
    required this.title,
    required this.isCurrent,
    this.icon,
  });
  final GestureTapCallback onTap;
  final String title;
  final ValueNotifier<bool> isCurrent;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(color: AppColors.g75, width: 0.5),
            vertical: BorderSide(color: AppColors.g75, width: 0.5),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 20),
          child: ValueListenableBuilder(
              valueListenable: isCurrent,
              builder: (context, value, child) {
                return Row(
                  children: [
                    Icon(
                      icon ?? Icons.visibility_off_outlined,
                      color: value ? AppColors.p300 : AppColors.g300,
                    ),
                    const Width(12),
                    Text(
                      title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontSize: 13.sp,
                        color: value ? AppColors.p300 : AppColors.g300,
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
