import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/provider.dart';
import '../model/wallet.dart';

final readWalletProvider = FutureProvider<List<Wallet>>((ref) async {
  final restClient = ref.read(restClientAuthProvider);
  final wallet = await restClient.get('/auth/wallets');
  final data = wallet!['data'];
  log(data.toString());
  return data.map<Wallet>((e) => Wallet.fromJson(e)).toList();
});
