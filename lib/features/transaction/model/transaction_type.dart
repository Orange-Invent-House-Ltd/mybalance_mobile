enum TransactionType {
  deposit('Deposit'),
  escrow('Escrow'),
  withdrawal('Withdrawal'),
  unknown('');

  const TransactionType(this.name);
  final String name;

  static TransactionType fromString(String type) =>
      TransactionType.values.firstWhere(
        (e) => e.name.toLowerCase() == type.toLowerCase(),
        orElse: () => TransactionType.unknown,
      );

  String toJsonString() => name.toUpperCase();

  @override
  String toString() => name;

}
