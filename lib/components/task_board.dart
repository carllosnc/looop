import 'package:collection/collection.dart';
import 'package:all_day/core/extensions/datetime.dart';
import 'package:boxy/boxy.dart';
import 'package:flutter/material.dart';
import 'package:vw/vw.dart';
import '/imports/app.dart';

class TaskBoard extends StatefulWidget {
  final Task task;

  const TaskBoard({
    required this.task,
    super.key,
  });

  @override
  State<TaskBoard> createState() => _TaskBoardState();
}

class _TaskBoardState extends State<TaskBoard> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    final DateTime today = DateTime.now();
    final createdAt = widget.task.createdAt;

    List<DateTime> days = [];

    for (var i = 0; i < 200; i++) {
      days.add(createdAt.add(Duration(days: i)));
    }

    return Boxy(
      width: double.infinity,
      borderRadius: BorderRadius.circular(25),
      padding: const EdgeInsets.only(bottom: 30),
      color: Colors.black,
      onTap: () {
        openDetails(context, widget.task);
      },
      child: VWColumn(
        gap: 20,
        children: [
          VWRow(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
            gap: 15,
            verticalAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.task.icon,
                style: const TextStyle(
                  fontSize: 40,
                ),
              ),
              Expanded(
                child: VWColumn(
                  gap: 2,
                  children: [
                    Text(
                      widget.task.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      widget.task.hour.formatHour(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              StreamFirestoreQueryBuilder(
                stream: DataService.getChecks(widget.task),
                success: (context, snapshot) {
                  List<Check> checks = snapshot.data!.docs.map((e) => Check.fromJson(e.data())).toList();
                  bool hasCheck = checks.any((e) => e.checkedAt.toCompare() == today.toCompare());

                  dynamic currentCheck = checks.firstWhereOrNull(
                    (e) => e.checkedAt.toCompare() == today.toCompare(),
                  );

                  return CircleAvatar(
                    backgroundColor: hasCheck ? Colors.green : Colors.white.withOpacity(0.2),
                    radius: 25,
                    child: IconButton(
                      iconSize: 30,
                      icon: Icon(
                        Icons.check,
                        color: hasCheck ? Colors.white : Colors.white.withOpacity(0.6),
                      ),
                      onPressed: () {
                        if (currentCheck == null) {
                          DataService.addCheck(widget.task);
                        } else {
                          DataService.deleteCheck(widget.task, currentCheck);
                        }
                      },
                    ),
                  );
                },
                noData: CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  radius: 25,
                  child: IconButton(
                    iconSize: 30,
                    icon: Icon(
                      Icons.check,
                      color: Colors.white.withOpacity(0.6),
                    ),
                    onPressed: () {
                      DataService.addCheck(widget.task);
                    },
                  ),
                ),
                loading: const SizedBox(),
              )
            ],
          ),
          StreamFirestoreQueryBuilder(
            stream: DataService.getChecks(widget.task),
            success: (context, snapshot) {
              List<Check> checks = snapshot.data!.docs.map((e) => Check.fromJson(e.data())).toList();

              return GridDays(days: days, checks: checks);
            },
            noData: GridDays(days: days, checks: null),
            loading: const Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  '...',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          // VWButton(
          //   label: "Test",
          //   onTap: () {
          //     DataService.addCheckTest(widget.task, count = count + 3);
          //   },
          // ),
        ],
      ),
    );
  }
}

class GridDays extends StatelessWidget {
  final List<DateTime> days;
  final List<Check>? checks;

  const GridDays({
    super.key,
    required this.days,
    required this.checks,
  });

  Color checkColor(DateTime day) {
    bool hasCheck = checks!.any((e) => e.checkedAt.toCompare() == day.toCompare());

    return hasCheck ? Colors.white : Colors.white.withOpacity(0.2);
  }

  @override
  Widget build(BuildContext context) {
    return Boxy(
      height: 80,
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.only(left: 23, right: 23, bottom: 0, top: 0),
        scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: days.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: checks != null ? checkColor(days[index]) : Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
          );
        },
      ),
    );
  }
}
