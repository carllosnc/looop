import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';
import 'package:vw/vw.dart';

recoverPassword(BuildContext context) {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  VWPage.open(
    context: context,
    appBar: AppBar(
      title: const Text('Recover Password'),
    ),
    body: SingleChildScrollView(
      child: Form(
        key: formKey,
        child: VWColumn(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          gap: 10,
          children: [
            const Text(
              'Enter your email to recover your password, we will send you a link to reset it.',
            ),
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
