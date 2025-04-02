import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vw/vw.dart';
import 'verify_email_controller.dart';
import '/imports.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> with VerifyEmailController {
  @override
  Widget build(BuildContext context) {
    checkEmail(context);

    return Scaffold(
      appBar: AppBar(
        title: "Email Verification".pageTitle,
        actions: [
          IconButton(
            onPressed: () async {
              openCustomDialog(
                context: context,
                title: 'Leave',
                description: 'Are you sure to leave the application?',
                cancelLabel: 'No',
                confirmLabel: 'Yes',
                onConfirm: () {
                  logout(context);
                },
              );
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: VWColumn(
            gap: 10,
            padding: const EdgeInsets.all(40),
            horizontalAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                color: Colors.red,
                Icons.mark_email_unread_outlined,
                size: 70,
              ),
              "Verify your email address".text.bold,
              "We send a link to (${FirebaseAuth.instance.currentUser?.email}) address to you confirm the verification.".text.textCenter,
              const Divider(),
              'You can resend email if you don\'t received or the link was expired'.text.textCenter,
              const SizedBox(height: 20),
              if (!(emailSended == 'yes'))
                VWButton(
                  color: Colors.black,
                  isLoading: emailSended == 'loading',
                  onTap: () {
                    handleSendEmail();
                  },
                  label: 'Resend email',
                ),
              if (emailSended == 'yes')
                VWButton(
                  color: Colors.black.withValues(alpha: 0.15),
                  labelStyle: const TextStyle(color: Colors.black),
                  onTap: null,
                  label: 'Resend email: $counter',
                ),
            ],
          ),
        ),
      ),
    );
  }
}
