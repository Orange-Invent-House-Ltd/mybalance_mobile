import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/widgets/custom_dropdown.dart';
import '../../../../core/widgets/label_text_field.dart';
import '../../models/means_of_id.dart';

class SignUpSellerStep3 extends StatefulWidget {
  const SignUpSellerStep3({
    super.key,
    required this.meansOfIdController,
  });
  final TextEditingController meansOfIdController;

  @override
  State<SignUpSellerStep3> createState() => _SignUpSellerStep3State();
}

class _SignUpSellerStep3State extends State<SignUpSellerStep3> {
  late final TextEditingController _passportNumberController,
      _lastNameController,
      _ninNumberController,
      _votersCardNumberController,
      _firstNameController,
      _dobController,
      _stateController,
      _lgaController;

  @override
  void initState() {
    super.initState();
    _passportNumberController = TextEditingController();
    _lastNameController = TextEditingController();
    _ninNumberController = TextEditingController();
    _votersCardNumberController = TextEditingController();
    _firstNameController = TextEditingController();
    _dobController = TextEditingController();
    _stateController = TextEditingController();
    _lgaController = TextEditingController();
  }

  @override
  void dispose() {
    _passportNumberController.dispose();
    _lastNameController.dispose();
    _ninNumberController.dispose();
    _votersCardNumberController.dispose();
    _firstNameController.dispose();
    _dobController.dispose();
    _stateController.dispose();
    _lgaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final ThemeData theme = Theme.of(context);
    log(widget.meansOfIdController.text);
    return ValueListenableBuilder(
        valueListenable: widget.meansOfIdController,
        builder: (context, value, child) {
          return Column(
            children: [
              CustomDropdown(
                textController: widget.meansOfIdController,
                label: 'Means of ID',
                hintText: 'Select means of ID',
                items: MeansOfId.values.map((MeansOfId id) {
                  return CustomDropdownEntry(
                    id.name,
                    id.label,
                  );
                }).toList(),
              ),
              if (widget.meansOfIdController.text ==
                  MeansOfId.internationalPassport.label) ...[
                const SizedBox(height: 16),
                LabelTextField(
                  controller: _passportNumberController,
                  label: 'Passport number',
                  hintText: 'e.g 1234 1234 123',
                ),
                const SizedBox(height: 24),
                LabelTextField(
                  controller: _lastNameController,
                  label: 'Last name',
                  hintText: 'e.g Saka',
                ),
              ],
              if (widget.meansOfIdController.text == MeansOfId.nin.label) ...[
                const SizedBox(height: 16),
                LabelTextField(
                  controller: _ninNumberController,
                  label: 'NIN number',
                  hintText: 'e.g 1234 1234 123',
                ),
              ],
              if (widget.meansOfIdController.text ==
                  MeansOfId.votersCard.label) ...[
                const SizedBox(height: 16),
                LabelTextField(
                  controller: _votersCardNumberController,
                  label: 'Voter\'s card number',
                  hintText: 'e.g 1234 1234 123',
                ),
                const SizedBox(height: 24),
                LabelTextField(
                  controller: _firstNameController,
                  label: 'First name',
                  hintText: 'e.g Bukayo',
                ),
                const SizedBox(height: 24),
                LabelTextField(
                  controller: _lastNameController,
                  label: 'Last name',
                  hintText: 'e.g Saka',
                ),
                const SizedBox(height: 24),
                LabelTextField(
                  controller: _dobController,
                  label: 'Date of birth',
                  hintText: 'e.g DD-MM-YYYY',
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: LabelTextField(
                        controller: _stateController,
                        label: 'State',
                        hintText: 'e.g Lagos',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: LabelTextField(
                        controller: _lgaController,
                        label: 'LGA',
                        hintText: 'e.g Ikeja',
                      ),
                    ),
                  ],
                ),
              ],
              if (widget.meansOfIdController.text ==
                  MeansOfId.driversLicense.label) ...[
                const SizedBox(height: 16),
                LabelTextField(
                  controller: _passportNumberController,
                  label: 'Driver\'s license number',
                  hintText: 'e.g 1234 1234 123',
                ),
                const SizedBox(height: 24),
                LabelTextField(
                  controller: _dobController,
                  label: 'Date of birth',
                  hintText: 'e.g DD-MM-YYYY',
                  suffixIcon: SvgPicture.asset(
                    AppAssets.calendar,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
              // const SizedBox(height: 32),
              // TextButton(
              //   onPressed: () {},
              //   child: Text(
              //     'Skip this part',
              //     style: theme.textTheme.bodyMedium?.copyWith(
              //       color: AppColors.p300,
              //       fontWeight: FontWeight.w500,
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 20),
            ],
          );
        });
  }
}
