import 'package:flutter/material.dart';

enum TransactionStatus {
  pending('Pending', Color(0xffFFF2F1), Color(0xffDA1E28)),
  inProgress('In progress', Color(0xffFFFCF2), Color(0xffFDB022));

  const TransactionStatus(
    this.name,
    this.backgroundColor,
    this.foregroundColor,
  );
  final String name;
  final Color foregroundColor;
  final Color backgroundColor;
}
