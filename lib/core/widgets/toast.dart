import 'package:flutter/widgets.dart';
import 'package:toastification/toastification.dart';

import '../../config/routes/route_config.dart';

abstract class AppToast {
  static void show(
    String message, {
    ToastificationType type = ToastificationType.info,
  }) {
    final BuildContext? context = navigatorKey.currentContext;
    if (context == null) {
      return;
    }
    toastification.show(
      context: context,
      title: Text(message),
      type: type,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 5),
      alignment: Alignment.topCenter,
      showProgressBar: false,
      closeOnClick: true,
      dragToClose: true,
    );
  }

  static void error(String message) => show(
        message,
        type: ToastificationType.error,
      );
  static void success(String message) => show(
        message,
        type: ToastificationType.success,
      );
  static void info(String message) => show(
        message,
        type: ToastificationType.info,
      );
  static void warning(String message) => show(
        message,
        type: ToastificationType.warning,
      );
}
