import 'package:flutter/material.dart';
import 'package:vw/vw.dart';
import '/imports/app.dart';

openDetails(BuildContext context, Task task, List<Check> checks) {
  VWPage.open(
    context: context,
    level: 1,
    appBar: AppBar(
      actions: [
        IconButton(
          icon: const Icon(
            Icons.share_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            debugPrint('Share task');
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.edit_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            updateTask(context: context, task: task);
          },
        ),

        //delete button
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
                        DataService.deleteTask(task);
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
