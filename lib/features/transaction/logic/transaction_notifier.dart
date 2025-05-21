import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/transaction_repository.dart';
import '../model/transaction_model.dart';

class AllTransactionsNotifier
    extends StateNotifier<AsyncValue<List<Transaction>>> {
  final TransactionRepository _apiService;
  int _currentPage = 1;
  final int _limit = 10;
  bool _hasMore = true;
  final List<Transaction> _transactions = [];

  AllTransactionsNotifier(this._apiService)
      : super(const AsyncValue.loading()) {
    fetchTransactions();
  }

  Future<void> fetchTransactions({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 1;
      _hasMore = true;
      _transactions.clear();
      state = const AsyncValue.loading();
    }

    if (!_hasMore) return;

    try {
      final newTransactions =
          await _apiService.fetchTransactions(_currentPage, _limit);

      if (newTransactions.length < _limit) {
        _hasMore = false;
      }

      _transactions.addAll(newTransactions);
      _currentPage++;
      state = AsyncValue.data(List.unmodifiable(_transactions));
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  void loadMore() {
    if (!state.isLoading && _hasMore) {
      fetchTransactions();
    }
  }

  void refresh() {
    fetchTransactions(isRefresh: true);
  }

  Transaction? getTransactionById(String id) {
    return state.when(
      data: (transactions) {
        // final sortedTransactions = List<Transaction>.from(transactions)
        //   ..sort((a, b) => a.id.compareTo(b.id));
        return transactions.firstWhere((t) => t.id == id);
      },
      loading: () => null,
      error: (_, __) => null,
    );
  }

}
