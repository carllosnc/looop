import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';
import 'package:vw/vw.dart';

createNewAccount(BuildContext context) {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  VWPage.open(
    context: context,
    appBar: AppBar(
      title: const Text('New Account'),
    ),
    body: SingleChildScrollView(
      child: Form(
        key: formKey,
        child: VWColumn(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          gap: 10,
          children: [
            TextFormField(
              controller: emailController,
              validator: Validatorless.multiple([
                Validatorless.required('Email is required'),
                Validatorless.email('Invalid email'),
              ]),
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            TextFormField(
              controller: passwordController,
              validator: Validatorless.multiple([
                Validatorless.required('Password is required'),
                Validatorless.min(6, 'Password must have at least 6 characters'),
              ]),
              decoration: const InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),
            TextFormField(
              controller: confirmPasswordController,
              validator: Validatorless.multiple([
                Validatorless.required('Confirm Password is required'),
                (value) {
                  if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                }
              ]),
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                hintText: 'Enter your password again',
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            VWButton(
              label: 'Create Account',
              color: Colors.black,
              onTap: () {
                if (formKey.currentState!.validate()) {
                  print('Valid form');
                }
              },
            ),
          ],
        ),
      ),
    ),
  );
}
