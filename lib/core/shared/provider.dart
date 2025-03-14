import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider.dart';
import './data/bank_datasource.dart';
import './data/bank_repository.dart';
import './models/bank_model.dart';

final bankDataSourceProvider = Provider<BankDataSource>((ref) {
  final restClient = ref.read(restClientProvider);
  return BankDataSource(restClient: restClient);
});

final bankRepositoryProvider = Provider<BankRepository>((ref) {
  final dataSource = ref.read(bankDataSourceProvider);
  return BankRepository(dataSource: dataSource);
});

final bankListProvider =
    FutureProvider.autoDispose<List<BankModel>>((ref) async {
  final bankRepository = ref.read(bankRepositoryProvider);
  final banks = await bankRepository.getBanksList();
  return banks;
});
