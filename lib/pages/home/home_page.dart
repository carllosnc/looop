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
      appBar: AppBar(
        title: Text(
          "Hello, ${user!.displayName!.formatName()}",
        ),
        actions: [
          VWRow(
            gap: 10,
            padding: const EdgeInsets.only(right: 10),
            children: [
              CircleAvatar(
                backgroundColor: Colors.black,
                maxRadius: 20,
                child: IconButton(
                  iconSize: 25,
                  padding: const EdgeInsets.all(0),
                  icon: const Icon(Icons.save_outlined, color: Colors.white),
                  onPressed: () {
                    context.push("/finished");
                  },
                ),
              ),
              CircleAvatar(
                backgroundColor: Colors.black,
                maxRadius: 20,
                child: IconButton(
                  iconSize: 25,
                  padding: const EdgeInsets.all(0),
                  icon: const Icon(Icons.add, color: Colors.white),
                  onPressed: () {
                    openNewTask(context);
                  },
                ),
              )
            ],
          ),
        ],
      ),
      body: TaskList(
        stream: TaskService.getUnfinishedTasks(),
      ),
    );
  }
}
