import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '/core/core.dart';

class FlushbarManager {
  static void showSuccess(String message) {
    Flushbar(
      message: message,
      icon: const Icon(
        Icons.check_circle,
        color: Colors.green,
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.green.shade600,
      flushbarPosition: FlushbarPosition.BOTTOM,
    ).show(
      NavigationService.instance.navigatorKey.currentContext!,
    );
  }

  static void showError(BuildContext context, String message) {
    Flushbar(
      message: message,
      icon: const Icon(
        Icons.error,
        color: Colors.red,
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red.shade600,
      flushbarPosition: FlushbarPosition.BOTTOM,
    ).show(
      NavigationService.instance.navigatorKey.currentContext!,
    );
  }

  static void showInfo(BuildContext context, String message) {
    Flushbar(
      message: message,
      icon: const Icon(
        Icons.info,
        color: Colors.blue,
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.blue.shade600,
      flushbarPosition: FlushbarPosition.BOTTOM,
    ).show(
      NavigationService.instance.navigatorKey.currentContext!,
    );
  }
}
