import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vw/vw.dart';
import '/imports/app.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      extendBody: true,
      drawer: Drawer(
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
                          backgroundImage: NetworkImage(user.photoURL!),
                        ),
                        VWColumn(
                          children: [
                            Text(
                              user.displayName!,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              user.email!,
                              style: TextStyle(
                                fontSize: 15,
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
                leading: const Icon(Icons.delete_forever_outlined, color: Colors.red),
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
      ),
      appBar: AppBar(
        title: const Text(
          "All Day",
        ),
        actions: [
          IconButton(
            iconSize: 25,
            icon: Icon(
              Icons.inventory_2_outlined,
              color: Colors.black.withOpacity(0.7),
            ),
            onPressed: () {
              context.push("/finished");
            },
          ),
          IconButton(
            iconSize: 25,
            icon: Icon(
              Icons.add_circle_outline_rounded,
              color: Colors.black.withOpacity(0.7),
            ),
            onPressed: () {
              openNewTask(context);
            },
          ),
        ],
      ),
      body: DelayRender(
        child: TaskList(
          stream: TaskService.getUnfinishedTasks(),
        ),
      ),
    );
  }
}
