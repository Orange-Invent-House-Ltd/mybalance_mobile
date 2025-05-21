import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/themes/app_colors.dart';
import '../../../core/components/rest_client/rest_client.dart';
import '../../../core/shared/widgets/custom_app_bar.dart';
import '../../../core/shared/widgets/label_text_field.dart';
import '../../../core/shared/widgets/overlay_loading.dart';
import '../../../core/shared/widgets/sizedbox.dart';
import '../../../core/shared/widgets/toast.dart';
import './provider/profile_provider.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _nameController, _phoneController;
  late AsyncValue<(String, String, String)> ff;
  late ValueNotifier<bool> _isLoading;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _isLoading = ValueNotifier(false);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _isLoading.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    // final profileRepo = ref.read(profileRepositoryProvider);
    // final File? pickedImage = await profileRepo.pickImage();

    // if (pickedImage != null) {
    //   ref.read(profileImageProvider.notifier).state =
    //       pickedImage; // Update state
    // }
  }
  void _tryEditProfile(String? fullName, String? phone) async {
    if (_formKey.currentState?.validate() ?? false) {
      _isLoading.value = true;

      try {
        await ref.read(profileRepositoryProvider).editProfile(fullName, phone);
        ref.invalidate(readProfileProvider);

        if (mounted) {
          AppToast.success('Profile updated successfully');
        }
      } catch (e) {
        e as RestClientException;
        log(e.message);
        AppToast.error(e.message);
      } finally {
        _isLoading.value = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final profileData = ref.watch(readProfileProvider);
    final File? pickedImage = ref.watch(profileImageProvider);
    return Scaffold(
      appBar: CustomAppBar(
        theme: theme,
        text: 'Profile',
      ),
      body: ValueListenableBuilder(
          valueListenable: _isLoading,
          child: profileData.when(
            data: (data) {
              _nameController.text = data.fullName;
              _phoneController.text = data.phoneNumber;
              return SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Form(
                  key: _formKey,
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
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: pickedImage != null
                                ? FileImage(pickedImage)
                                : data.avatar != null
                                    ? const NetworkImage('url')
                                    : null,
                          ),
                          const Width(20),
                          TextButton(
                            onPressed: _pickImage,
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
                              onPressed: _nameController.text !=
                                          data.fullName ||
                                      _phoneController.text != data.phoneNumber
                                  ? () {
                                      // final p =
                                      _tryEditProfile(
                                        data.fullName == _nameController.text
                                            ? null
                                            : _nameController.text,
                                        data.phoneNumber ==
                                                _phoneController.text
                                            ? null
                                            : _phoneController.text,
                                      );
                                    }
                                  : null,
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
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.p300,
                ),
              );
            },
            error: (_, __) {
              return const Center(
                child: Text('Error loading profile'),
              );
            },
          ),
          builder: (context, value, child) {
            return OverlayLoading(
              isLoading: value,
              child: child!,
            );
          }),
    );
  }
}
