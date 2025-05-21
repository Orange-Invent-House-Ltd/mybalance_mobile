import './transaction_status.dart';
import './transaction_type.dart';

// class Transactions {
//   final String id;
//   final String refId;
//   final TransactionStatus status;
//   final String title;
//   final double amount;
//   final String? description;
//   final DateTime date;

//   Transactions({
//     required this.id,
//     required this.refId,
//     required this.status,
//     required this.title,
//     required this.amount,
//     this.description,
//     required this.date,
//   });
// }

// final List<Transactions> trans = [
//   Transactions(
//     id: '1',
//     refId: '20240528agyudnjhddh2',
//     status: TransactionStatus.progress,
//     title: 'Apple Series 2',
//     amount: 10000,
//     description:
//         'Apple series 2 smartwatch Apple series 2 smartwatch Apple series 2 smartwatch',
//     date: DateTime.now(),
//   ),
//   Transactions(
//     id: '2',
//     refId: '20240528agyudnjhddh2',
//     status: TransactionStatus.pending,
//     title: 'Apple Series 1',
//     amount: 13000,
//     description:
//         'Apple series 2 smartwatch Apple series 2 smartwatch Apple series 2 smartwatch',
//     date: DateTime.now(),
//   ),
//   Transactions(
//     id: '3',
//     refId: '20240528agyudnjhddh2',
//     status: TransactionStatus.progress,
//     title: 'Apple Series 5',
//     amount: 10000,
//     description:
//         'Apple series 2 smartwatch Apple series 2 smartwatch Apple series 2 smartwatch',
//     date: DateTime.now(),
//   ),
//   Transactions(
//     id: '4',
//     refId: '20240528agyudnjhddh2',
//     status: TransactionStatus.pending,
//     title: 'nothing',
//     amount: 13000,
//     description:
//         'Apple series 2 smartwatch Apple series 2 smartwatch Apple series 2 smartwatch',
//     date: DateTime.now(),
//   ),
//   Transactions(
//     id: '5',
//     refId: '20240528agyudnjhddh2',
//     status: TransactionStatus.progress,
//     title: 'Fruits',
//     amount: 10000,
//     description:
//         'Apple series 2 smartwatch Apple series 2 smartwatch Apple series 2 smartwatch',
//     date: DateTime.now(),
//   ),
//   Transactions(
//     id: '6',
//     refId: '20240528agyudnjhddh2',
//     status: TransactionStatus.pending,
//     title: 'Cakes',
//     amount: 13000,
//     description:
//         'Apple series 2 smartwatch Apple series 2 smartwatch Apple series 2 smartwatch',
//     date: DateTime.now(),
//   ),
//   Transactions(
//     id: '7',
//     refId: '20240528agyudnjhddh2',
//     status: TransactionStatus.progress,
//     title: 'Shoes',
//     amount: 10000,
//     description:
//         'Apple series 2 smartwatch Apple series 2 smartwatch Apple series 2 smartwatch',
//     date: DateTime.now(),
//   ),
//   Transactions(
//     id: '8',
//     refId: '20240528agyudnjhddh2',
//     status: TransactionStatus.successful,
//     title: 'Bags',
//     amount: 13000,
//     description:
//         'Apple series 2 smartwatch Apple series 2 smartwatch Apple series 2 smartwatch',
//     date: DateTime.now(),
//   ),
//   Transactions(
//     id: '9',
//     refId: '20240528agyudnjhddh2',
//     status: TransactionStatus.rejected,
//     title: 'Oppo A9',
//     amount: 1000,
//     description:
//         'Apple series 2 smartwatch Apple series 2 smartwatch Apple series 2 smartwatch',
//     date: DateTime.now(),
//   ),
//   Transactions(
//     id: '10',
//     refId: '20240528agyudnjhddh2',
//     status: TransactionStatus.successful,
//     title: 'Samsung Galaxy S21',
//     amount: 16000,
//     description:
//         'Apple series 2 smartwatch Apple series 2 smartwatch Apple series 2 smartwatch',
//     date: DateTime.now(),
//   ),
// ];

class Transaction {
  final String id;
  final int userId;
  final TransactionStatus status;
  final TransactionType type;
  final String mode;
  final String reference;
  final String? narration;
  final double amount;
  final double charge;
  final double remittedAmount;
  final String currency;
  final String provider;
  final String? providerTxReference;
  final TransactionMeta meta;
  final bool verified;
  final String? merchant;
  final double? lockedAmount;
  final dynamic escrowMetadata;
  final DateTime createdAt;
  final DateTime updatedAt;

  Transaction({
    required this.id,
    required this.userId,
    required this.status,
    required this.type,
    required this.mode,
    required this.reference,
    this.narration,
    required this.amount,
    required this.charge,
    required this.remittedAmount,
    required this.currency,
    required this.provider,
    this.providerTxReference,
    required this.meta,
    required this.verified,
    this.merchant,
    this.lockedAmount,
    this.escrowMetadata,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      userId: json['userId'] as int,
      status: TransactionStatus.fromString(json['status'] as String),
      type: TransactionType.fromString(json['type'] as String),
      mode: json['mode'] as String,
      reference: json['reference'] as String,
      narration: json['narration'] as String?,
      amount: (json['amount'] as num).toDouble(),
      charge: (json['charge'] as num).toDouble(),
      remittedAmount: (json['remittedAmount'] as num).toDouble(),
      currency: json['currency'] as String,
      provider: json['provider'] as String,
      providerTxReference: json['providerTxReference'] as String?,
      meta: TransactionMeta.fromJson(json['meta'] as Map<String, dynamic>),
      verified: json['verified'] as bool,
      merchant: json['merchant'] as String?,
      lockedAmount: json['lockedAmount'] != null
          ? (json['lockedAmount'] as num).toDouble()
          : null,
      escrowMetadata: json['escrowMetadata'],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status.toJsonString(),
      'type': type.toJsonString(),
      'mode': mode,
      'reference': reference,
      'narration': narration,
      'amount': amount,
      'charge': charge,
      'remittedAmount': remittedAmount,
      'currency': currency,
      'provider': provider,
      'providerTxReference': providerTxReference,
      'meta': meta.toJson(),
      'verified': verified,
      'merchant': merchant,
      'lockedAmount': lockedAmount,
      'escrowMetadata': escrowMetadata,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Transaction(id: $id, userId: $userId, status: $status, type: $type, mode: $mode, reference: $reference, narration: $narration, amount: $amount, charge: $charge, remittedAmount: $remittedAmount, currency: $currency, provider: $provider, providerTxReference: $providerTxReference, meta: $meta, verified: $verified, merchant: $merchant, lockedAmount: $lockedAmount, escrowMetadata: $escrowMetadata, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

class TransactionMeta {
  final String title;
  final String bankName;
  final String accountName;
  final String accountNumber;

  TransactionMeta({
    required this.title,
    required this.bankName,
    required this.accountName,
    required this.accountNumber,
  });

  factory TransactionMeta.fromJson(Map<String, dynamic> json) {
    return TransactionMeta(
      title: json['title'] as String,
      bankName: json['bankName'] as String,
      accountName: json['accountName'] as String,
      accountNumber: json['accountNumber'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'bankName': bankName,
      'accountName': accountName,
      'accountNumber': accountNumber,
    };
  }

  @override
  String toString() {
    return 'TransactionMeta(title: $title, bankName: $bankName, accountName: $accountName, accountNumber: $accountNumber)';
  }
}
