import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/provider.dart';
import '../../../../core/shared/models/bank_model.dart';
import '../../../../core/shared/provider.dart';
import '../../../../core/shared/widgets/custom_dropdown.dart';
import '../../../../core/shared/widgets/label_text_field.dart';
import '../../../../core/shared/widgets/sizedbox.dart';
import '../../../../core/utils/validators.dart';
import '../../models/signup_param.dart';

class IsSellerViewStep1 extends ConsumerStatefulWidget {
  const IsSellerViewStep1({super.key, required this.onNextPressed});
  final void Function() onNextPressed;

  @override
  ConsumerState<IsSellerViewStep1> createState() => _IsSellerViewState1();
}

class _IsSellerViewState1 extends ConsumerState<IsSellerViewStep1> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _firstNameController,
      _lastNameController,
      _businessNameController,
      _serviceController,
      _addressController,
      _phoneController,
      _referralCodeController,
      _referralController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _businessNameController = TextEditingController();
    _serviceController = TextEditingController();
    _addressController = TextEditingController();
    _phoneController = TextEditingController();
    _referralCodeController = TextEditingController();
    _referralController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _businessNameController.dispose();
    _serviceController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _referralCodeController.dispose();
    _referralController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelTextField(
            controller: _firstNameController,
            validator: Validator.nameValidator,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            label: "First name",
            hintText: 'eg John',
          ),
          const Height(20),
          LabelTextField(
            controller: _lastNameController,
            validator: Validator.nameValidator,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            label: "Last name",
            hintText: 'eg Albert',
          ),
          const Height(20),
          LabelTextField(
            controller: _businessNameController,
            validator: Validator.notEmptyValidator,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            label: "Business name",
            hintText: 'Musty Feet',
          ),
          const Height(20),
          LabelTextField(
            controller: _serviceController,
            validator: Validator.notEmptyValidator,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            label: "Describe your service",
            hintText: 'Sales of sneakers, footwears, etc',
          ),
          const Height(20),
          LabelTextField(
            controller: _addressController,
            validator: Validator.notEmptyValidator,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            label: "Address",
            hintText: 'Ikeja Lagos',
          ),
          const Height(20),
          LabelTextField(
            controller: _phoneController,
            validator: Validator.phoneValidator,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            label: "Phone number",
            hintText: '08123456789',
          ),
          const Height(20),
          LabelTextField(
            controller: _referralCodeController,
            validator: Validator.notEmptyValidator,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            label: "Referral code",
            hintText: 'eg 123456',
          ),
          const Height(20),
          LabelTextField(
            controller: _referralController,
            validator: Validator.notEmptyValidator,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            label: "Where did you hear about us?",
            hintText: 'Select location',
          ),
          const Height(36),
          FullWidth(
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final SignupParam param = SignupParam(
                    firstName: _firstNameController.text,
                    lastName: _lastNameController.text,
                    businessName: _businessNameController.text,
                    businessDescription: _serviceController.text,
                    address: _addressController.text,
                    phone: _phoneController.text,
                    referralCode: _referralCodeController.text,
                    referrer: _referralCodeController.text,
                  );
                  ref
                      .read(memoryDaoProvider)
                      .stringEntry('signupParam')
                      .set(param.toRawJson());
                  widget.onNextPressed();
                }
              },
              child: const Text('Next'),
            ),
          ),
        ],
      ),
    );
  }
}

class IsSellerStep2 extends ConsumerStatefulWidget {
  const IsSellerStep2({super.key});

  @override
  ConsumerState<IsSellerStep2> createState() => _IsSellerStep2State();
}

class _IsSellerStep2State extends ConsumerState<IsSellerStep2> {
  late GlobalKey<FormState> _formKey;
  late ValueNotifier<bool> _passwordVisible;
  late TextEditingController _emailController,
      _passwordController,
      _bankNameController,
      _accountNumberController,
      _accountNameController;
  String? _bankCode;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _passwordVisible = ValueNotifier<bool>(false);
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _bankNameController = TextEditingController();
    _accountNumberController = TextEditingController();
    _accountNameController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordVisible.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _accountNameController.dispose();
    super.dispose();
  }

  Future<SignupParam> _readParam() async {
    final ff =
        await ref.watch(memoryDaoProvider).stringEntry('signupParam').read();
    SignupParam param = SignupParam.fromRawJson(ff!);
    log(param.businessName!);
    return param;
  }

  Future<void> _clearParam() async {
    await ref.watch(memoryDaoProvider).stringEntry('signupParam').remove();
  }

  Future<void> _trySubmit() async {
    if (_formKey.currentState!.validate()) {
      if (_bankCode == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a bank'),
          ),
        );
        return;
      }
      final step1Param = await _readParam();
      log(_bankCode!);
      final param = step1Param.copyWith(
        email: _emailController.text,
        password: _passwordController.text,
        bankName: _bankNameController.text,
        accountNumber: _accountNumberController.text,
        accountName: _accountNameController.text,
      );

      _clearParam();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          LabelTextField(
            controller: _emailController,
            validator: Validator.emailValidator,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            label: 'Email',
            hintText: 'eg',
          ),
          const Height(6),
          Text.rich(
            TextSpan(
              text: 'NOTE: ',
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.g200,
              ),
              children: [
                TextSpan(
                  text:
                      'Use the email address that was shared with the buyer IF ANY.',
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.g200,
                  ),
                ),
              ],
            ),
          ),
          const Height(20),
          ValueListenableBuilder(
            valueListenable: _passwordVisible,
            builder: (context, bool value, child) {
              return LabelTextField(
                controller: _passwordController,
                validator: Validator.passwordValidator,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.visiblePassword,
                label: 'Add password',
                hintText: '********',
                obscureText: !value,
                suffixIcon: IconButton(
                  icon: Icon(
                    value ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.g200,
                  ),
                  onPressed: () {
                    _passwordVisible.value = !_passwordVisible.value;
                  },
                ),
              );
            },
          ),
          const Height(20),
          CustomDropdown<BankModel>(
            textController: _bankNameController,
            label: 'Select bank name',
            hintText: 'Select bank name',
            isLoading: ref.watch(bankListProvider).maybeWhen(
                  orElse: () => false,
                  loading: () => true,
                ),
            onChanged: (item) {
              _bankCode = item.value.code;
            },
            items: ref.watch(bankListProvider).maybeWhen(
                  orElse: () => [],
                  data: (banks) {
                    return banks.map(
                      (bank) {
                        return CustomDropdownEntry(
                          bank,
                          bank.name,
                        );
                      },
                    ).toList();
                  },
                ),
          ),
          const Height(20),
          LabelTextField(
            controller: _accountNumberController,
            validator: Validator.accountNumberValidator,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            maxLength: 10,
            label: "Bank account number",
            hintText: '1234567890',
          ),
          const Height(10),
          LabelTextField(
            controller: _accountNumberController,
            // controller: _accountNameController,
            validator: Validator.accountNumberValidator,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            readOnly: true,
            label: "Account name",
          ),
          const Height(36),
          FullWidth(
            child: ElevatedButton(
              onPressed: () async {
                await _trySubmit();
              },
              child: const Text('Next'),
            ),
          ),
        ],
      ),
    );
  }
}
