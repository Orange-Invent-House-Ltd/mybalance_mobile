import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repository.dart';
import '../models/dispute.dart';
import '../models/dispute_priority_enum.dart';

enum DisputeStatuss { initial, loading, success, error }

class DisputeState {
  final List<Dispute> disputes;
  final bool hasMore;
  final int page;
  final DisputeStatuss status;
  final String? error;

  const DisputeState({
    this.disputes = const [],
    this.hasMore = true,
    this.page = 1,
    this.status = DisputeStatuss.initial,
    this.error,
  });

  DisputeState copyWith({
    List<Dispute>? disputes,
    bool? hasMore,
    int? page,
    DisputeStatuss? status,
    String? error,
  }) {
    return DisputeState(
      disputes: disputes ?? this.disputes,
      hasMore: hasMore ?? this.hasMore,
      page: page ?? this.page,
      status: status ?? this.status,
      error: error,
    );
  }
}

class DisputeNotifier extends StateNotifier<DisputeState> {
  final DisputeRepository repository;

  DisputeNotifier(this.repository) : super(const DisputeState());

  static const int pageSize = 10;

  Future<void> fetchNextPage() async {
    if (!state.hasMore || state.status == DisputeStatuss.loading) return;

    state = state.copyWith(status: DisputeStatuss.loading);
    try {
      final disputes = await repository.getAllDispute(
        state.page.toString(),
        pageSize.toString(),
      );

      final hasMore = disputes.length == pageSize;
      state = state.copyWith(
        disputes: [...state.disputes, ...disputes],
        page: state.page + 1,
        hasMore: hasMore,
        status: DisputeStatuss.success,
      );
    } catch (e) {
      state = state.copyWith(
        status: DisputeStatuss.error,
        error: e.toString(),
      );
    }
  }

  Future<void> create({
    required String trxId,
    required String priority,
    required String reason,
    required String description,
  }) async {
    try {
      final dispute = await repository.createDispute(
        trxId,
        priority,
        reason,
        description,
      );
      state = state.copyWith(
        disputes: [dispute, ...state.disputes],
        status: DisputeStatuss.success,
      );
    } catch (e) {
      state = state.copyWith(
        status: DisputeStatuss.error,
        error: e.toString(),
      );
    }
  }

  void reset() {
    state = const DisputeState();
  }
}
