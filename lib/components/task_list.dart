import 'package:all_day/imports/app.dart';
import 'package:flutter/material.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamFirestoreQueryBuilder(
      stream: DataService.getTasks(),
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
      noData: const NoTasks(),
      loading: const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    );
  }
}
