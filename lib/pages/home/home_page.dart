import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
      drawer: AppDrawer(user: user),
      appBar: AppBar(
        title: const Text(
          "Looop",
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
