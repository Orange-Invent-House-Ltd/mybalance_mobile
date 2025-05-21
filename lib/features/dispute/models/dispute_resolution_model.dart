import 'dispute_resolution_status.dart';

class DisputeResolution {
  DisputeResolution({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.timestamp,
  });

  final String id;
  final String title;
  final String description;
  final DisputeStatus status;
  final DateTime timestamp;
}

List<DisputeResolution> dummyDisputes = [
  DisputeResolution(
    id: '1',
    title: 'Payment Not Received',
    description: 'Customer claims payment was made but not received.',
    status: DisputeStatus.pending,
    timestamp: DateTime.now().subtract(const Duration(days: 1)),
  ),
  DisputeResolution(
    id: '2',
    title: 'Unauthorized Transaction',
    description: 'User reported an unauthorized charge on their account.',
    status: DisputeStatus.resolved,
    timestamp: DateTime.now().subtract(const Duration(days: 2)),
  ),
  DisputeResolution(
    id: '3',
    title: 'Wrong Amount Charged',
    description: 'User was charged twice for a single transaction.',
    status: DisputeStatus.progress,
    timestamp: DateTime.now().subtract(const Duration(days: 3)),
  ),
  DisputeResolution(
    id: '4',
    title: 'Refund Not Processed',
    description: 'User requested a refund, but it has not been processed.',
    status: DisputeStatus.pending,
    timestamp: DateTime.now().subtract(const Duration(days: 4)),
  ),
  DisputeResolution(
    id: '5',
    title: 'Delayed Payment Settlement',
    description: 'Funds settlement taking longer than expected.',
    status: DisputeStatus.resolved,
    timestamp: DateTime.now().subtract(const Duration(days: 5)),
  ),
  DisputeResolution(
    id: '6',
    title: 'Disputed Chargeback',
    description: 'Customer raised a dispute over a chargeback decision.',
    status: DisputeStatus.progress,
    timestamp: DateTime.now().subtract(const Duration(days: 6)),
  ),
  DisputeResolution(
    id: '7',
    title: 'Incorrect Account Debit',
    description: 'Funds were deducted from the wrong account.',
    status: DisputeStatus.pending,
    timestamp: DateTime.now().subtract(const Duration(days: 7)),
  ),
  DisputeResolution(
    id: '8',
    title: 'Merchant Overcharged Customer',
    description: 'A merchant overcharged a customer by mistake.',
    status: DisputeStatus.resolved,
    timestamp: DateTime.now().subtract(const Duration(days: 8)),
  ),
  DisputeResolution(
    id: '9',
    title: 'Fraudulent Transaction',
    description:
        'User claims their account was used for fraudulent activities.',
    status: DisputeStatus.progress,
    timestamp: DateTime.now().subtract(const Duration(days: 9)),
  ),
  DisputeResolution(
    id: '10',
    title: 'Service Not Delivered',
    description: 'Customer paid for a service that was never delivered.',
    status: DisputeStatus.pending,
    timestamp: DateTime.now().subtract(const Duration(days: 10)),
  ),
  DisputeResolution(
    id: '11',
    title: 'Item Not Received',
    description: 'User ordered an item but never received it.',
    status: DisputeStatus.resolved,
    timestamp: DateTime.now().subtract(const Duration(days: 11)),
  ),
  DisputeResolution(
    id: '12',
    title: 'Incorrect Amount Refunded',
    description: 'User received a partial refund instead of a full refund.',
    status: DisputeStatus.progress,
    timestamp: DateTime.now().subtract(const Duration(days: 12)),
  ),
  DisputeResolution(
    id: '13',
    title: 'Subscription Auto-Renewal Issue',
    description: 'User was charged for a subscription they did not renew.',
    status: DisputeStatus.pending,
    timestamp: DateTime.now().subtract(const Duration(days: 13)),
  ),
  DisputeResolution(
    id: '14',
    title: 'Bank Reversal Pending',
    description: 'A bank reversal request has not been processed yet.',
    status: DisputeStatus.resolved,
    timestamp: DateTime.now().subtract(const Duration(days: 14)),
  ),
  DisputeResolution(
    id: '15',
    title: 'Lost Package Dispute',
    description: 'User claims their package was lost in transit.',
    status: DisputeStatus.progress,
    timestamp: DateTime.now().subtract(const Duration(days: 15)),
  ),
  DisputeResolution(
    id: '16',
    title: 'Failed Withdrawal Request',
    description: 'User’s withdrawal request failed due to an error.',
    status: DisputeStatus.pending,
    timestamp: DateTime.now().subtract(const Duration(days: 16)),
  ),
  DisputeResolution(
    id: '17',
    title: 'Delayed Refund Process',
    description: 'Refund taking too long to process.',
    status: DisputeStatus.resolved,
    timestamp: DateTime.now().subtract(const Duration(days: 17)),
  ),
  DisputeResolution(
    id: '18',
    title: 'Incorrect Billing Address Used',
    description: 'Transaction was processed with the wrong billing address.',
    status: DisputeStatus.progress,
    timestamp: DateTime.now().subtract(const Duration(days: 18)),
  ),
  DisputeResolution(
    id: '19',
    title: 'Unrecognized Transaction Alert',
    description:
        'User received a notification for an unrecognized transaction.',
    status: DisputeStatus.pending,
    timestamp: DateTime.now().subtract(const Duration(days: 19)),
  ),
  DisputeResolution(
    id: '20',
    title: 'Overdraft Fees Dispute',
    description: 'User claims they were wrongly charged overdraft fees.',
    status: DisputeStatus.resolved,
    timestamp: DateTime.now().subtract(const Duration(days: 20)),
  ),
];
