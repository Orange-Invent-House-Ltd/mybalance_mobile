import 'package:flutter/material.dart';

import '../../../../core/widgets/label_text_field.dart';

class SignUpSellerStep1 extends StatelessWidget {
  const SignUpSellerStep1({
    super.key,
    required TextEditingController fullnameController,
    required TextEditingController businessNameController,
    required TextEditingController serviceController,
    required TextEditingController addressController,
    required TextEditingController phoneController,
  })  : _fullnameController = fullnameController,
        _businessNameController = businessNameController,
        _serviceController = serviceController,
        _addressController = addressController,
        _phoneController = phoneController;

  final TextEditingController _fullnameController;
  final TextEditingController _businessNameController;
  final TextEditingController _serviceController;
  final TextEditingController _addressController;
  final TextEditingController _phoneController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LabelTextField(
          controller: _fullnameController,
          label: 'Full name',
          hintText: 'e.g "Aremu Jamiu"',
        ),
        const SizedBox(height: 16),
        LabelTextField(
          controller: _businessNameController,
          label: 'Business name',
          hintText: 'e.g “Musty Feet”',
        ),
        const SizedBox(height: 16),
        LabelTextField(
          controller: _serviceController,
          label: 'Describe your service',
          hintText: 'e.g Sales of footwear',
        ),
        const SizedBox(height: 16),
        LabelTextField(
          controller: _addressController,
          label: 'Address',
          hintText: 'Ikeja, Lagos.',
        ),
        const SizedBox(height: 16),
        LabelTextField(
          controller: _phoneController,
          label: 'Phone number',
          hintText: '+234 000 0000 000',
        ),
      ],
    );
  }
}
