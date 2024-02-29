import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:vw/vw.dart';
import '/imports/app.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
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
      appBar: AppBar(),
      body: Center(
        child: VWColumn(
          horizontalAlignment: CrossAxisAlignment.center,
          verticalAlignment: MainAxisAlignment.center,
          padding: const EdgeInsets.all(20),
          gap: 20,
          children: [
            Image.asset(
              Assets.logo,
              width: 130,
            ),
            SizedBox(
              width: 250,
              child: Text(
                'Tiny Steps, Big Wins: Your Habits, Your Way!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: VWRow(
        padding: const EdgeInsets.all(20),
        horizontalAlignment: MainAxisAlignment.center,
        children: [
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
