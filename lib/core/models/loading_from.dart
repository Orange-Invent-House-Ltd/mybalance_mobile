enum LoadingFrom {
  paymentStatus,
  withdrawMoney;

  factory LoadingFrom.fromString(String value) {
    return LoadingFrom.values.firstWhere(
      (e) => e.name == value,
      orElse: () =>
          throw ArgumentError('No matching Loading for value: $value'),
    );
  }
}
