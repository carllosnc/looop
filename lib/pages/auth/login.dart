import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vw/vw.dart';
import '/imports/app.dart';
import 'dart:math' as math;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  continueWithGoogle() async {
    final result = await AuthService.signInWithGoogle();

    if (context.mounted) {
      if (result == 'Welcome!') {
        context.go('/home');
      } else {
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

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 20),
  )..repeat();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: VWColumn(
          horizontalAlignment: CrossAxisAlignment.center,
          verticalAlignment: MainAxisAlignment.center,
          padding: const EdgeInsets.all(20),
          gap: 40,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _controller.value * 2 * math.pi,
                  child: child,
                );
              },
              child: Image.asset(
                Assets.logo,
                width: 150,
              ),
            ),
            VWColumn(
              horizontalAlignment: CrossAxisAlignment.center,
              verticalAlignment: MainAxisAlignment.center,
              gap: 10,
              children: [
                Text(
                  'ALL DAY',
                  style: GoogleFonts.anton(
                    fontSize: 40,
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: Text(
                    'Monitore e registre suas atividades diárias de forma simples e rápida.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: VWRow(
        padding: const EdgeInsets.all(20),
        children: [
          VWButton(
            color: Colors.black,
            fullWidth: true,
            leftIcon: FontAwesomeIcons.google,
            label: "Entrar com Google",
            onTap: () {
              continueWithGoogle();
            },
          )
        ],
      ),
    );
  }
}
