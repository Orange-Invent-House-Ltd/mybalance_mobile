import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/provider.dart';
import '../../data/data_source.dart';
import '../../data/repository.dart';
import '../../models/profile.dart';

final profileImageProvider = StateProvider<File?>((ref) => null);

final readProfileProvider = FutureProvider.autoDispose<Profile>((ref) async {
  final restClient = ref.read(restClientAuthProvider);
  final profile = await restClient.get('/auth/profile');
  final proile = Profile.fromJson(profile!['data']);
  log(profile['data'].toString());
  log(proile.toString());
  return proile;
});

final _profileDataSourceProvider = Provider<ProfileDataSource>((ref) {
  final restClient = ref.read(restClientAuthProvider);
  return ProfileDataSource(restClient: restClient);
});

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final dataSource = ref.read(_profileDataSourceProvider);
  return ProfileRepository(dataSource: dataSource);
});

final changePasswordProvider = FutureProvider.autoDispose
    .family<void, (String, String, String)>((ref, param) async {
  final repo = ref.read(profileRepositoryProvider);
  return await repo.changePassword(param.$1, param.$2, param.$3);
});

final changePhoneProvider =
    FutureProvider.autoDispose.family<void, String>((ref, phone) async {
  final repo = ref.read(profileRepositoryProvider);
  return await repo.changePhoneNumber(phone);
});

final editProfileProvider = FutureProvider.family
    .autoDispose<void, (String fullName, String phone)>((ref, param) async {
  final (fullName, phone) = param;
  final repo = ref.read(profileRepositoryProvider);
  return repo.editProfile(fullName, phone);
});
