import 'package:flutter/material.dart';
import 'package:vw/vw_column.dart';
import '/imports/app.dart';

class FinishedPage extends StatelessWidget {
  const FinishedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finished Tasks'),
      ),
      body: TaskList(
        stream: TaskService.getFinishedTasks(),
        noTask: const Center(
          child: VWColumn(
            verticalAlignment: MainAxisAlignment.center,
            horizontalAlignment: CrossAxisAlignment.center,
            gap: 20,
            children: [
              Text(
                '😐',
                style: TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                'No finished tasks',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
