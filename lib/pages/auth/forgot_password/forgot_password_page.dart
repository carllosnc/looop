import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';
import 'package:vw/vw.dart';
import 'forgot_password_controller.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> with ForgotPasswordController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recover password'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: VWColumn(
            padding: const EdgeInsets.all(20),
            gap: 20,
            children: [
              const Text(
                'Enter your email to receiver a link to reset your password',
                textAlign: TextAlign.start,
              ),
              TextFormField(
                validator: Validatorless.multiple(
                  [
                    Validatorless.email('The field must be and email'),
                    Validatorless.required('Email is required'),
                  ],
                ),
                controller: emailController,
                decoration: const InputDecoration(
                  label: Text('Email'),
                  prefixIcon: Icon(Icons.mail_outline),
                ),
              ),
              if (!isSuccess)
                VWButton(
                  color: Colors.black,
                  isLoading: isLoading,
                  loadingLabel: 'Sending email',
                  label: 'Submit',
                  onTap: () => submitHandle(context),
                )
            ],
          ),
        ),
      ),
    );
  }
}
