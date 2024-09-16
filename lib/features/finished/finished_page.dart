import 'package:flutter/material.dart';
import 'package:looop/features/home/components/delay_render.dart';
import 'package:vw/vw_column.dart';
import '/imports.dart';
import '../home/components/task_list.dart';

class FinishedPage extends StatelessWidget {
  const FinishedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Finished Tasks'.pageTitle,
      ),
      body: DelayRender(
        child: TaskList(
          stream: TaskService.getFinishedTasks(),
          noTask: Center(
            child: VWColumn(
              verticalAlignment: MainAxisAlignment.center,
              horizontalAlignment: CrossAxisAlignment.center,
              gap: 20,
              children: [
                '😐'.bigEmoji,
                'No finished tasks'.featuredText,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
