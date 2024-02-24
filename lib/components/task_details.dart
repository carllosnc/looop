import 'package:all_day/core/extensions/datetime.dart';
import 'package:flutter/material.dart';
import 'package:vw/vw.dart';
import '/imports/app.dart';

openDetails(BuildContext context, Task task) {
  VWPage.open(
    context: context,
    level: 1,
    appBar: AppBar(
      actions: [
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
    body: TaskDetails(
      task: task,
    ),
  );
}

class TaskDetails extends StatelessWidget {
  final Task task;

  const TaskDetails({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        StreamFirestoreDocBuilder(
          stream: DataService.getTask(task),
          success: (context, snapshot) {
            Task task = Task.fromJson(snapshot.data!.data()!);

            return SliverToBoxAdapter(
              child: VWRow(
                verticalAlignment: CrossAxisAlignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                gap: 20,
                children: [
                  Text(
                    task.icon,
                    style: const TextStyle(
                      fontSize: 70,
                    ),
                  ),
                  VWColumn(
                    horizontalAlignment: CrossAxisAlignment.start,
                    gap: 0,
                    children: [
                      Text(
                        task.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      //created at
                      Text(
                        'Created at: ${task.createdAt.formatDate()}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                      Text(
                        task.description,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          noData: const SliverToBoxAdapter(
            child: SizedBox(),
          ),
          loading: const SliverToBoxAdapter(
            child: SizedBox(),
          ),
        ),
        SliverToBoxAdapter(
          child: Divider(
            color: Colors.black.withOpacity(0.15),
            height: 60,
            thickness: 1,
          ),
        ),
        StreamFirestoreQueryBuilder(
          stream: DataService.getChecks(task),
          success: (context, snapshot) {
            List<Check> checks = snapshot.data!.docs.map((e) => Check.fromJson(e.data())).toList();
            checks.sort((a, b) => a.checkedAt.compareTo(b.checkedAt));

            DateTime initialDate = task.createdAt;
            DateTime? finalDate = checks.last.checkedAt;
            int totalOfDays;

            totalOfDays = finalDate.difference(initialDate).inDays + 1;

            return SliverToBoxAdapter(
              child: VWColumn(
                gap: 5,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: VWColumn(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      horizontalAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Your checks by month',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        VWRow(
                          gap: 10,
                          horizontalAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Days: $totalOfDays • Checks: ${checks.length}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  DelayRender(
                    loading: const Center(
                      child: Text(
                        '● ● ●',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    child: MonthGrid(
                      task: task,
                      checks: checks,
                    ),
                  ),
                ],
              ),
            );
          },
          noData: const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'No checks yet',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          loading: const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ),
          ),
        )
      ],
    );
  }
}
