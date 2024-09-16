import 'package:flutter/material.dart';
import '/imports.dart';

mixin ForgotPasswordController<T extends StatefulWidget> on State<T> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  bool isLoading = false;
  bool isSuccess = false;

  submitHandle(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      String? result = await AuthService.forgotPassword(
        email: emailController.text,
      );

      if (context.mounted) {
        if (result == 'Success') {
          context.showSnackBar(
            message: 'Email sent',
          );

          setState(() {
            isLoading = false;
            isSuccess = true;
          });

          return;
        }

        context.showSnackBar(
          message: result!,
        );
      }

      setState(() {
        isLoading = false;
      });
    }
  }
}
