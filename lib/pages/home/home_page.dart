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
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.logoBg),
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
          ),
          child: VWColumn(
            verticalAlignment: MainAxisAlignment.spaceBetween,
            padding: EdgeInsets.zero,
            children: [
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
                        backgroundImage: NetworkImage(user!.photoURL!),
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
                  FirebaseAuth.instance.signOut();
                  context.go("/login");
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Hello, ${user.displayName!.formatName()}",
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
