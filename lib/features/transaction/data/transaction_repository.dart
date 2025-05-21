import 'dart:developer';

import '../model/transaction_model.dart';
import 'transaction_data_source.dart';

class TransactionRepository {
  TransactionRepository({required TransactionDataSource dataSource})
      : _dataSource = dataSource;

  final TransactionDataSource _dataSource;

  Future<List<Transaction>> fetchTransactions(
    int page,
    int size,
  ) async {
    log('fetching transactions');
    final transats = await _dataSource.fetchTransactions(page, size);
    if (transats.isNotEmpty) {
      log('First transaction type: ${transats.first.runtimeType}');
    }
    log('transats: $transats');
    final transactions = transats
        .whereType<Map<String, dynamic>>()
        .map((json) => Transaction.fromJson(json))
        .toList();
    log('trans: $transactions');
    return transactions;
  }

  Future<Transaction> fetchTransaction(String id) async {
    final transat = await _dataSource.fetchTransaction(id);
    final Transaction transaction = Transaction.fromJson(transat);
    return transaction;
  }

  // Future<List<Transaction>> fecthFirstTwoTransaction() async {
  //   return await fetchTransactions(1, 2);
  // }
}
