import 'package:flutter/material.dart';
import 'package:vw/vw.dart';
import '/imports/app.dart';

openDetails(BuildContext context, Task task, List<Check> checks) {
  VWPage.open(
    context: context,
    level: 1,
    appBar: AppBar(
      actions: [
        if (task.finished == false)
          IconButton(
            icon: Icon(
              Icons.save_outlined,
              color: Colors.black.withOpacity(0.7),
            ),
            onPressed: () async {
              TaskService.finishTask(task);
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Task finished'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        IconButton(
          icon: Icon(
            Icons.share_outlined,
            color: Colors.black.withOpacity(0.7),
          ),
          onPressed: () {},
        ),
        if (task.finished == false)
          IconButton(
            icon: Icon(
              Icons.edit_outlined,
              color: Colors.black.withOpacity(0.7),
            ),
            onPressed: () {
              updateTask(context: context, task: task);
            },
          ),
        IconButton(
          icon: const Icon(
            Icons.delete_outline,
            color: Colors.red,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  surfaceTintColor: Colors.white,
                  title: const Text(
                    'Delete Task',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.red,
                    ),
                  ),
                  content: const Text('Are you sure you want to delete this task?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        TaskService.deleteTask(task);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    ),
    body: SingleChildScrollView(
      child: DelayRender(
        delay: 300,
        child: ProgressBoard(
          task: task,
        ),
      ),
    ),
  );
}
