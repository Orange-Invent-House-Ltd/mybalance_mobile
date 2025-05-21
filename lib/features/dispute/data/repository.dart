import '../models/dispute.dart';
import '../models/dispute_priority_enum.dart';
import './data_source.dart';

class DisputeRepository {
  DisputeRepository({required DisputeDataSource dataSource})
      : _dataSource = dataSource;
  final DisputeDataSource _dataSource;

  Future<Dispute> createDispute(String trxID, String priority,
      String reason, String description) async {
    final Map<String, String> data = {
      "transaction": trxID,
      "priority": priority.toUpperCase(),
      "reason": reason,
      "description": description,
    };
    final dataSource = await _dataSource.createDispute(data);
    final dispute = Dispute.fromJson(dataSource);
    return dispute;
  }

  Future<List<Dispute>> getAllDispute(String page, String size) async {
    final dis = await _dataSource.getAllDispute(page, size);
    final List<Dispute> disputes = dis
        .whereType<Map<String, dynamic>>()
        .map((data) => Dispute.fromJson(data))
        .toList();
    return disputes;
  }
}
