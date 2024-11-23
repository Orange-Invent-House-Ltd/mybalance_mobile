import 'package:flutter/material.dart';

import '../../../config/themes/app_colors.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/label_text_field.dart';
import '../../../core/widgets/sizedbox.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late TextEditingController _nameController, _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        theme: theme,
        text: 'Profile',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Manage your profile and personal details here.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.g500,
              ),
            ),
            const Height(70),
            Row(
              children: [
                const CircleAvatar(radius: 30),
                const Width(20),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.g500,
                    textStyle: theme.textTheme.bodyMedium,
                  ),
                  child: const Text('Tap to change photo'),
                )
              ],
            ),
            const Height(48),
            LabelTextField(
              controller: _nameController,
              label: 'Full name',
              hintText: 'eg. Albert',
              textInputAction: TextInputAction.next,
            ),
            const Height(20),
            LabelTextField(
              controller: _phoneController,
              label: 'Phone',
              hintText: '+234 000 0000 000',
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
            ),
            const Height(24),
            SizedBox(
              width: double.infinity,
              child: ListenableBuilder(
                listenable: Listenable.merge(
                  [
                    _nameController,
                    _phoneController,
                  ],
                ),
                builder: (context, child) {
                  return ElevatedButton(
                    onPressed: () {},
                    child: child,
                  );
                },
                child: const Text('Update profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
