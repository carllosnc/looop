import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/imports.dart';

mixin RegisterController<T extends StatefulWidget> on State<T> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  registerNewUser(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      String? result = await AuthService.createAccount(
        email: emailController.text,
        password: passwordController.text,
      );

      if (context.mounted) {
        if (result == 'Success') {
          context.go('/');
          return;
        }

        context.showSnackBar(
          message: result!,
          hasError: true,
        );
      }

      setState(() {
        isLoading = false;
      });
    }
  }
}
