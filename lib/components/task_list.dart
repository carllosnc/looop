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
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(height: 5),
          padding: const EdgeInsets.only(
            top: 0,
            left: 5,
            right: 5,
            bottom: 10,
          ),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            Task task = Task.fromJson(snapshot.data!.docs[index].data());

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
