import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:validatorless/validatorless.dart';
import 'package:vw/vw.dart';
import '/imports/app.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin, LoginController {
  bool _showPassword = false;

  continueWithGoogle(BuildContext context) async {
    final result = await AuthService.signInWithGoogle();

    if (result == 'Welcome!') {
      if (context.mounted) {
        context.go('/home');
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tiny Steps, Big Wins: Your Habits, Your Way!",
            style: TextStyle(
              fontSize: 17,
              color: Colors.black,
            )),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: VWColumn(
            horizontalAlignment: CrossAxisAlignment.center,
            verticalAlignment: MainAxisAlignment.center,
            padding: const EdgeInsets.all(20),
            gap: 20,
            children: [
              VWColumn(
                horizontalAlignment: CrossAxisAlignment.center,
                verticalAlignment: MainAxisAlignment.center,
                gap: 20,
                children: [
                  Image.asset(
                    Assets.logo,
                    width: 140,
                  ),
                ],
              ),
              Form(
                key: formKey,
                child: VWColumn(
                  gap: 10,
                  horizontalAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.push('/register');
                      },
                      child: const Text("😎 Create new account"),
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: Validatorless.multiple([
                        Validatorless.required('Email is required'),
                        Validatorless.email('Invalid email'),
                      ]),
                      decoration: const InputDecoration(
                        labelText: "Email",
                        hintText: "Enter your email",
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: !_showPassword,
                      autocorrect: false,
                      validator: Validatorless.multiple([
                        Validatorless.required('Password is required'),
                      ]),
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Enter your password",
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
                    VWRow(
                      horizontalAlignment: MainAxisAlignment.spaceBetween,
                      verticalAlignment: CrossAxisAlignment.center,
                      children: [
                        VWButton(
                          label: "Sign in",
                          isLoading: isLoading,
                          color: Colors.black,
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              doLogin(context);
                            }
                          },
                        ),
                        TextButton(
                          onPressed: () {
                            context.push('/forgot-password');
                          },
                          child: const Text("Forgot password?"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: VWRow(
        padding: const EdgeInsets.all(20),
        horizontalAlignment: MainAxisAlignment.spaceBetween,
        verticalAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Or continue with 👉'),
          VWButton(
            color: Colors.black,
            leftIcon: FontAwesomeIcons.google,
            label: "Sign in with Google",
            onTap: () {
              continueWithGoogle(context);
            },
          )
        ],
      ),
    );
  }
}
