import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/imports.dart';

mixin VerifyEmailController<T extends StatefulWidget> on State<T> {
  Timer? checkEmailtimer;
  Timer? ticTacTimer;
  String emailSended = 'no';
  int counter = 100;

  @override
  void dispose() {
    checkEmailtimer?.cancel();
    ticTacTimer?.cancel();
    super.dispose();
  }

  checkEmail(BuildContext context) {
    checkEmailtimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      User? user = FirebaseAuth.instance.currentUser;
      user?.reload();

      if (user?.emailVerified == true) {
        timer.cancel();

        if (context.mounted) {
          context.go('/home');
        }
      }
    });
  }

  tictac() {
    ticTacTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        emailSended = 'yes';
        counter--;
      });

      if (counter == 0) {
        debugPrint('Ressend email again');
        timer.cancel();
        setState(() {
          counter = 100;
          emailSended = 'no';
        });
      }
    });
  }

  handleSendEmail() async {
    setState(() {
      emailSended = 'loading';
    });

    var result = await AuthService.sendEmailVerification();

    if (mounted) {
      if (result == 'Success') {
        context.showSnackBar(message: 'Email sended');
      } else {
        context.showSnackBar(message: result, hasError: true);
      }
    }

    tictac();
  }

  logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      context.go('/');
    }
  }
}
