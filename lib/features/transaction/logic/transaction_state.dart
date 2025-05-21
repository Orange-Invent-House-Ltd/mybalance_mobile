import '../model/transaction_model.dart';

class TransactionState {
  final List<Transaction> allTransactions;
  final Map<String, Transaction> transactionsById;
  final List<Transaction> firstTwoTransactions;

  TransactionState({
    required this.allTransactions,
    required this.transactionsById,
    required this.firstTwoTransactions,
  });

  TransactionState copyWith({
    List<Transaction>? allTransactions,
    Map<String, Transaction>? transactionsById,
    List<Transaction>? firstTwoTransactions,
  }) {
    return TransactionState(
      allTransactions: allTransactions ?? this.allTransactions,
      transactionsById: transactionsById ?? this.transactionsById,
      firstTwoTransactions: firstTwoTransactions ?? this.firstTwoTransactions,
    );
  }
}