import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:validatorless/validatorless.dart';
import 'package:vw/vw.dart';
import 'login_controller.dart';
import '/imports.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin, LoginController {
  bool _showPassword = false;

  continueWithGoogle(BuildContext context) async {
    final result = await AuthService.signInWithGoogle();

    if (result == 'Welcome!') {
      if (context.mounted) {
        context.go('/home');
      }
    } else {
      if (context.mounted) {
        context.showSnackBar(message: result, hasError: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    width: 100,
                  ),
                ],
              ),
              SizedBox(
                width: 200,
                child:
                    "Tiny Steps, Big Wins: Your Habits, Your Way!".featuredText,
              ),
              Form(
                key: formKey,
                child: VWColumn(
                  gap: 20,
                  horizontalAlignment: CrossAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        context.push('/register');
                      },
                      child: "Create new account".text,
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
                        prefixIcon: Icon(Icons.mail_outline),
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
                            _showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
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
                        OutlinedButton(
                          onPressed: () {
                            context.push('/forgot-password');
                          },
                          child: "Forgot password?".text,
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
          'Or continue with:'.text,
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
