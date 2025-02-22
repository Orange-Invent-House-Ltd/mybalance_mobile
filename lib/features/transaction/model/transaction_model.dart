import 'transaction_status.dart';

class Transactions {
  final String id;
  final String refId;
  final TransactionStatus status;
  final String title;
  final double amount;
  final String? description;
  final DateTime date;

  Transactions({
    required this.id,
    required this.refId,
    required this.status,
    required this.title,
    required this.amount,
    this.description,
    required this.date,
  });
}

final List<Transactions> trans = [
  Transactions(
    id: '1',
    refId: '20240528agyudnjhddh2',
    status: TransactionStatus.inProgress,
    title: 'Apple Series 2',
    amount: 10000,
    description:
        'Apple series 2 smartwatch Apple series 2 smartwatch Apple series 2 smartwatch',
    date: DateTime.now(),
  ),
  Transactions(
    id: '2',
    refId: '20240528agyudnjhddh2',
    status: TransactionStatus.pending,
    title: 'Apple Series 1',
    amount: 13000,
    description:
        'Apple series 2 smartwatch Apple series 2 smartwatch Apple series 2 smartwatch',
    date: DateTime.now(),
  ),
  Transactions(
    id: '3',
    refId: '20240528agyudnjhddh2',
    status: TransactionStatus.inProgress,
    title: 'Apple Series 5',
    amount: 10000,
    description:
        'Apple series 2 smartwatch Apple series 2 smartwatch Apple series 2 smartwatch',
    date: DateTime.now(),
  ),
  Transactions(
    id: '4',
    refId: '20240528agyudnjhddh2',
    status: TransactionStatus.pending,
    title: 'nothing',
    amount: 13000,
    description:
        'Apple series 2 smartwatch Apple series 2 smartwatch Apple series 2 smartwatch',
    date: DateTime.now(),
  ),
  Transactions(
    id: '5',
    refId: '20240528agyudnjhddh2',
    status: TransactionStatus.inProgress,
    title: 'Fruits',
    amount: 10000,
    description:
        'Apple series 2 smartwatch Apple series 2 smartwatch Apple series 2 smartwatch',
    date: DateTime.now(),
  ),
  Transactions(
    id: '6',
    refId: '20240528agyudnjhddh2',
    status: TransactionStatus.pending,
    title: 'Cakes',
    amount: 13000,
    description:
        'Apple series 2 smartwatch Apple series 2 smartwatch Apple series 2 smartwatch',
    date: DateTime.now(),
  ),
  Transactions(
    id: '7',
    refId: '20240528agyudnjhddh2',
    status: TransactionStatus.inProgress,
    title: 'Shoes',
    amount: 10000,
    description:
        'Apple series 2 smartwatch Apple series 2 smartwatch Apple series 2 smartwatch',
    date: DateTime.now(),
  ),
  Transactions(
    id: '8',
    refId: '20240528agyudnjhddh2',
    status: TransactionStatus.successful,
    title: 'Bags',
    amount: 13000,
    description:
        'Apple series 2 smartwatch Apple series 2 smartwatch Apple series 2 smartwatch',
    date: DateTime.now(),
  ),
  Transactions(
    id: '9',
    refId: '20240528agyudnjhddh2',
    status: TransactionStatus.rejected,
    title: 'Oppo A9',
    amount: 1000,
    description:
        'Apple series 2 smartwatch Apple series 2 smartwatch Apple series 2 smartwatch',
    date: DateTime.now(),
  ),
  Transactions(
    id: '10',
    refId: '20240528agyudnjhddh2',
    status: TransactionStatus.successful,
    title: 'Samsung Galaxy S21',
    amount: 16000,
    description:
        'Apple series 2 smartwatch Apple series 2 smartwatch Apple series 2 smartwatch',
    date: DateTime.now(),
  ),
];
