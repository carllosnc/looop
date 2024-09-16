import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/imports.dart';
import 'components/new_task.dart';
import 'components/task_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: "Looop".pageTitle,
        leading: IconButton(
          icon: Icon(
            Icons.settings_outlined,
            color: Colors.black.withOpacity(0.7),
          ),
          onPressed: () {
            context.push("/settings");
          },
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
      body: TaskList(
        stream: TaskService.getUnfinishedTasks(),
      ),
    );
  }
}
