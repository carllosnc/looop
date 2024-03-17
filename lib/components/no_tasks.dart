import '/imports/app.dart';
import 'package:flutter/material.dart';
import 'package:vw/vw.dart';

class NoTasks extends StatelessWidget {
  const NoTasks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: VWColumn(
        gap: 20,
        horizontalAlignment: CrossAxisAlignment.center,
        verticalAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '👇',
            style: TextStyle(
              fontSize: 100,
            ),
          ),
          const SizedBox(
            width: 300,
            child: Text(
              'You have no tasks yet, create a new one!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          VWRow(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            horizontalAlignment: MainAxisAlignment.center,
            children: [
              VWButton(
                color: Colors.black,
                label: 'New task',
                onTap: () {
                  openNewTask(context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
