import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/provider.dart';
import '../../data/data_source.dart';
import '../../data/repository.dart';
import '../../logic/dispute_notifier.dart';
import '../../models/dispute.dart';
import '../../models/dispute_priority_enum.dart';

final _disputeDataSourceProvider = Provider<DisputeDataSource>((ref) {
  final client = ref.read(restClientAuthProvider);
  return DisputeDataSource(client: client);
});

final disputeRepositoryProvider = Provider<DisputeRepository>((ref) {
  final dataSource = ref.read(_disputeDataSourceProvider);
  return DisputeRepository(dataSource: dataSource);
});

// final allDisputeProvider = FutureProvider<List<Dispute>>((ref) async {
//   final repo = ref.read(disputeRepositoryProvider);
//   return repo.getAllDispute('1', '100');
// });

// final createDisputeProvider = FutureProvider.family.autoDispose<
//     Dispute,
//     (
//       String trxID,
//       DisputePriority priority,
//       String reason,
//       String description,
//     )>((ref, param) async {
//   final repo = ref.read(disputeRepositoryProvider);
//   final (trxID, priority, reason, description) = param;
//   return repo.createDispute(trxID, priority, reason, description);
// });

final disputeNotifierProvider =
    StateNotifierProvider<DisputeNotifier, DisputeState>((ref) {
  final repo = ref.watch(disputeRepositoryProvider);
  return DisputeNotifier(repo);
});