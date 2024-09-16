import 'package:flutter/material.dart';

extension ButtonComponent on String {
  ButtonStyleButton outlinedButton({
    required VoidCallback? onPressed,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(this),
    );
  }
}
