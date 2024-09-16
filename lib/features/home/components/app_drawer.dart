import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:looop/imports.dart';
import 'package:vw/vw.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.user,
  });

  final User? user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      ),
      surfaceTintColor: Colors.white,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(),
        child: VWColumn(
          children: [
            if (user != null)
              SizedBox(
                width: double.infinity,
                child: SizedBox(
                  height: 230,
                  child: VWColumn(
                    padding: const EdgeInsets.all(20),
                    verticalAlignment: MainAxisAlignment.end,
                    gap: 10,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 30,
                        backgroundImage: user!.photoURL == null //
                            ? const AssetImage(Assets.avatar)
                                as ImageProvider<Object>?
                            : NetworkImage(user!.photoURL!),
                      ),
                      VWColumn(
                        children: [
                          Text(
                            (user!.displayName == null ||
                                    user!.displayName!.isEmpty)
                                ? user!.email!.firstNameFromEmail
                                : user!.displayName!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            user!.email!,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ListTile(
              title: const Text('Sign Out'),
              leading: const Icon(Icons.logout, color: Colors.red),
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
            ),
            const Spacer(),
            ListTile(
              title: const Text('Delete account'),
              leading:
                  const Icon(Icons.delete_forever_outlined, color: Colors.red),
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
            ),
          ],
        ),
      ),
    );
  }
}
