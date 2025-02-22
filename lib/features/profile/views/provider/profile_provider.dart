import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/data/profile_repository.dart';

final profileRepositoryProvider = Provider((ref) => ProfileRepository());

final profileImageProvider = StateProvider<File?>((ref) => null);

final profileProvider =
    FutureProvider.autoDispose<Map<String, String>>((ref) async {
  final repo = ref.read(profileRepositoryProvider);
  return await repo.getProfile();
});
