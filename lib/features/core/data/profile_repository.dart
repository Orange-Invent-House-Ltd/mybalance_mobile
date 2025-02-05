import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ProfileRepository {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  Future<Map<String, String>> getProfile() async {
    await Future.delayed(const Duration(seconds: 2));
    return {
      'fullname': "Uthman Ahmed",
      "phone": "+23470625750739",
      "image_url": '',
    };
  }
}
