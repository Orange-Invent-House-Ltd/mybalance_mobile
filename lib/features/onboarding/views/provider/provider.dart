import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/provider.dart';

final onboardedStatusProvider = FutureProvider<bool>((ref) async {
  final preferencesDao = ref.watch(sharedDaoProvider);
  final ff = await preferencesDao.boolEntry('onboarded').read() ?? false;
  return ff;
});

final onboardSetProvider = FutureProvider<void>((ref) async {
  final preferencesDao = ref.watch(sharedDaoProvider);
  return await preferencesDao.boolEntry('onboarded').set(true);
});
