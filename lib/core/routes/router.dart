import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/imports.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const LoginPage();
      },
      redirect: (context, state) => _redirect(context),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
      redirect: (context, state) => _redirect(context),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(
      path: '/verify-email',
      builder: (context, state) => const VerifyEmailPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/finished',
      builder: (context, state) => const FinishedPage(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);

String? _redirect(BuildContext context) {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    user?.reload();

    if (user == null) {
      return '/';
    } else {
      if (!user.emailVerified) {
        return '/verify-email';
      }

      return '/home';
    }
  } catch (e) {
    return '/';
  }
}
