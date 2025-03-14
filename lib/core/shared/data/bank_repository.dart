import 'dart:developer';

import 'package:mybalanceapp/core/shared/models/bank_model.dart';

import 'bank_datasource.dart';

class BankRepository {
  BankRepository({required this.dataSource});
  final BankDataSource dataSource;

  Future<List<BankModel>> getBanksList() async {
    final response = await dataSource.getBanksList();
    // log('from bank repository $response');
    final banks = response.map((e) => BankModel.fromJson(e)).toList();
    log('from bank repository ${banks.length}');
    return banks;
  }
}
