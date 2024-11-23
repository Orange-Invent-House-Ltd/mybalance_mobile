import 'package:flutter/material.dart';

import '../../../config/themes/app_colors.dart';

enum TransactionStatus {
  pending('Pending', Color(0xffFFF2F1), Color(0xffDA1E28)),
  inProgress('In progress', Color(0xffFFFCF2), Color(0xffFDB022)),
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
}
