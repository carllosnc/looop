import 'package:flutter/material.dart';

extension AppActionsContext on BuildContext {
  void showSnackBar({
    required String message,
    SnackBarAction? action,
    bool hasError = false,
  }) {
    ScaffoldMessenger.of(this).clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: hasError ? Colors.red.shade800 : Colors.black,
        action: action,
        content: Text(message),
      ),
    );
  }
}
