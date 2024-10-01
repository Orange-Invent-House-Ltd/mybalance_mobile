import 'package:intl/intl.dart';

extension NumExtension on num {
  String toCurrency() {
    final formatter = NumberFormat.currency(locale: "en_NG", symbol: "₦");
    return formatter.format(this);
  }
}
