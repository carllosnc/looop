import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';
import 'package:vw/vw.dart';
import './register_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with RegisterController {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create new Account'),
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
                obscureText: !_showPassword,
                autocorrect: false,
                validator: Validatorless.multiple([
                  Validatorless.required('Password is required'),
                  Validatorless.min(6, 'Password must have at least 6 characters'),
                ]),
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              VWButton(
                isLoading: isLoading,
                label: 'Create Account',
                color: Colors.black,
                onTap: isLoading
                    ? null
                    : () {
                        if (formKey.currentState!.validate()) {
                          registerNewUser(context);
                        }
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
