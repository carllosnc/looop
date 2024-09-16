import 'package:flutter/material.dart';
import 'package:vw/vw.dart';
import 'new_task.dart';
import '/imports.dart';

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
          '👇'.bigEmoji,
          'You have no tasks yet, create a new one!'.featuredText.size(250),
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
