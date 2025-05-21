import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/provider.dart';
import '../../data/transaction_data_source.dart';
import '../../data/transaction_repository.dart';
import '../../logic/transaction_notifier.dart';
import '../../model/transaction_model.dart';

final _dataSourceProvider = Provider<TransactionDataSource>((ref) {
  final restClient = ref.read(restClientAuthProvider);
  return TransactionDataSource(restClient: restClient);
});

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  final dataSource = ref.watch(_dataSourceProvider);
  return TransactionRepository(dataSource: dataSource);
});

// final first2Provider = FutureProvider<List<Transaction>>((ref) async {
//   final repo = ref.read(transactionRepositoryProvider);
//   return await repo.fecthFirstTwoTransaction();
// });

final notifierProvider = StateNotifierProvider<AllTransactionsNotifier,
    AsyncValue<List<Transaction>>>((ref) {
  final repo = ref.watch(transactionRepositoryProvider);
  return AllTransactionsNotifier(repo);
});
