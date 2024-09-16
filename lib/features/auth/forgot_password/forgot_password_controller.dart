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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Email sent! Check your inbox'),
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.fromLTRB(30, 0, 30, 30),
              action: SnackBarAction(
                label: "😧",
                textColor: Colors.white,
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            ),
          );

          setState(() {
            isLoading = false;
            isSuccess = true;
          });

          return;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result!),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.fromLTRB(30, 0, 30, 30),
            action: SnackBarAction(
              label: "😧",
              textColor: Colors.white,
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    }
  }
}
