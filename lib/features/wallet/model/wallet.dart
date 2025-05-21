class Wallet {
  final String id;
  final String currency;
  final double balance;
  final double lockedAmountOutward;
  final double lockedAmountInward;
  final double unlockedAmount;
  final double withdrawnAmount;
  final DateTime createdAt;
  final DateTime updatedAt;

  Wallet({
    required this.id,
    required this.currency,
    required this.balance,
    required this.lockedAmountOutward,
    required this.lockedAmountInward,
    required this.unlockedAmount,
    required this.withdrawnAmount,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create instance from JSON
  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      id: json['id'] as String,
      currency: json['currency'] as String,
      balance: double.parse(json['balance'] as String),
      lockedAmountOutward: double.parse(json['lockedAmountOutward'] as String),
      lockedAmountInward: double.parse(json['lockedAmountInward'] as String),
      unlockedAmount: double.parse(json['unlockedAmount'] as String),
      withdrawnAmount: double.parse(json['withdrawnAmount'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  // Method to convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'currency': currency,
      'balance': balance.toStringAsFixed(2),
      'lockedAmountOutward': lockedAmountOutward.toStringAsFixed(2),
      'lockedAmountInward': lockedAmountInward.toStringAsFixed(2),
      'unlockedAmount': unlockedAmount.toStringAsFixed(2),
      'withdrawnAmount': withdrawnAmount.toStringAsFixed(2),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

