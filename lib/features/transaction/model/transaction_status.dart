import 'dart:ui';

import '../../../config/themes/app_colors.dart';

enum TransactionStatus {
  pending('Pending', Color(0xffFFF2F1), Color(0xffDA1E28)),
  progress('In progress', Color(0xffFFFCF2), Color(0xffFDB022)),
  rejected('Rejected', AppColors.g400, AppColors.g50),
  successful('Successful', Color(0xff027A48), Color(0xffECFDF3));

  const TransactionStatus(
    this.name,
    this.backgroundColor,
    this.foregroundColor,
  );
  final String name;
  final Color foregroundColor;
  final Color backgroundColor;

  static TransactionStatus fromString(String status) {
    return TransactionStatus.values.firstWhere(
      (e) => e.name.toLowerCase() == status.toLowerCase(),
      orElse: () => TransactionStatus.pending,
    );
  }

  String toJsonString() => name;

  @override
  String toString() => name;
}
