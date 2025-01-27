import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileProvider = FutureProvider<(String, String, String)>((ref) async {
  const String l = '';
  await Future.delayed(const Duration(seconds: 3));
  return (l, 'John Albert', '+23400000000');
});
