import 'dispute_priority_enum.dart';
import 'dispute_resolution_status.dart';

enum AuthorType { buyer, seller }

class Dispute {
  final String id;
  final String transaction;
  final AuthorType author;
  final int buyer;
  final int seller;
  final DisputeStatus status;
  final DisputePriority priority;
  final String reason;
  final String description;
  final Map<String, dynamic>? meta;
  final DateTime createdAt;
  final DateTime updatedAt;

  Dispute({
    required this.id,
    required this.transaction,
    required this.author,
    required this.buyer,
    required this.seller,
    required this.status,
    required this.priority,
    required this.reason,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    this.meta,
  });

  factory Dispute.fromJson(Map<String, dynamic> json) {
    return Dispute(
      id: json['id'] as String,
      transaction: json['transaction'] as String,
      author: _authorFromString(json['author']),
      buyer: json['buyer'] as int,
      seller: json['seller'] as int,
      status: _statusFromString(json['status']),
      priority: _priorityFromString(json['priority']),
      reason: json['reason'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      meta: json['meta'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'transaction': transaction,
      'author': author.name.toUpperCase(),
      'buyer': buyer,
      'seller': seller,
      'status': status.name.toUpperCase(),
      'priority': priority.name.toUpperCase(),
      'reason': reason,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'meta': meta,
    };
  }

  // Helpers to parse lowercase enums
  static AuthorType _authorFromString(String value) =>
      AuthorType.values.firstWhere((e) => e.name == value.toLowerCase());

  static DisputeStatus _statusFromString(String value) =>
      DisputeStatus.values.firstWhere((e) => e.name == value.toLowerCase());

  static DisputePriority _priorityFromString(String value) =>
      DisputePriority.values.firstWhere((e) => e.name == value.toLowerCase());
}
