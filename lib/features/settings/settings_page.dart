import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vw/vw.dart';
import '/imports.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: "Settings".pageTitle,
      ),
      body: VWColumn(
        verticalAlignment: MainAxisAlignment.spaceBetween,
        children: [
          VWColumn(
            children: [
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: (user!.displayName == null || user.displayName!.isEmpty)
                    ? user.email!.firstNameFromEmail.text.bold
                    : user.displayName!.text.bold,
                subtitle: user.email!.text,
              ),
              ListTile(
                onTap: () {
                  openCustomDialog(
                    context: context,
                    title: "Sign Out",
                    description: "Are you sure you want to sign out?",
                    cancelLabel: "Cancel",
                    confirmLabel: "Sign Out",
                    onConfirm: () async {
                      await FirebaseAuth.instance.signOut();

                      if (context.mounted) {
                        context.go("/login");
                      }
                    },
                  );
                },
                leading: const Icon(Icons.logout, color: Colors.red),
                title: "Logout".text,
                subtitle: "Sign out of your account".text,
              ),
            ],
          ),
          ListTile(
            onTap: () {
              openCustomDialog(
                context: context,
                title: "Delete Account",
                description: "Are you sure you want to delete your account?",
                cancelLabel: "Cancel",
                confirmLabel: "Delete",
                onConfirm: () async {
                  await AuthService.deleteAccount();

                  if (context.mounted) {
                    context.go("/login");
                  }
                },
              );
            },
            leading: const Icon(Icons.delete_outline, color: Colors.red),
            title: "Delete account".text.color(Colors.red),
            subtitle: "All your data will be deleted".text,
          )
        ],
      ),
    );
  }
}
