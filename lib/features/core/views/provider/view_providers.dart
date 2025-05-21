import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/provider.dart';

final nameProvider = FutureProvider<String>((ref) async {
  final name =
      await ref.watch(sharedDaoProvider).stringEntry('userName').read();
  log(name.toString());
  return name!.split(' ').first;
});
