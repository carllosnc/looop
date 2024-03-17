import '/imports/app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskList extends StatelessWidget {
  final Stream<QuerySnapshot<Map<String, dynamic>>> stream;
  final Widget noTask;

  const TaskList({
    super.key,
    required this.stream,
    this.noTask = const NoTasks(),
  });

  @override
  Widget build(BuildContext context) {
    return StreamFirestoreQueryBuilder(
      stream: stream,
      success: (context, snapshot) {
        List<Task> tasks = snapshot.data!.docs.map((e) => Task.fromJson(e.data())).toList().cast<Task>();
        tasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        tasks = tasks.reversed.toList();

        return ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            height: 5,
          ),
          physics: const BouncingScrollPhysics(),
          cacheExtent: 5000,
          restorationId: 'task-list',
          padding: const EdgeInsets.only(
            top: 0,
            left: 5,
            right: 5,
            bottom: 10,
          ),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];

            return TaskBoard(
              task: task,
            );
          },
        );
      },
      noData: noTask,
      loading: const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    );
  }
}
