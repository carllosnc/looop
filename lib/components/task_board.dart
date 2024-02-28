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

  Color getFontColor(DateTime createdAt, DateTime today) {
    if (createdAt.toCompare() == today.toCompare()) {
      return Colors.white;
    } else {
      return Colors.white.withOpacity(0.6);
    }
  }

  Color getBgColor(DateTime createdAt, DateTime today) {
    if (createdAt.toCompare() == today.toCompare()) {
      return Colors.green[700]!;
    } else {
      return Colors.white.withOpacity(0.15);
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateTime today = DateTime.now();
    final createdAt = widget.task.createdAt;
    List<DateTime> days = [];
    List<Check> allChecks = [];

    for (var i = 0; i < 200; i++) {
      days.add(createdAt.add(Duration(days: i)));
    }

    return Boxy(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      borderRadius: BorderRadius.circular(25),
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromARGB(255, 43, 43, 43),
          Colors.black,
        ],
      ),
      onTap: () {
        openDetails(context, widget.task, allChecks);
      },
      child: VWColumn(
        children: [
          VWRow(
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
                      widget.task.title.inCaps,
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
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.task.finished == true)
                const Icon(
                  Icons.lock_outline,
                  color: Colors.white,
                ),
              if (widget.task.finished == false)
                StreamFirestoreQueryBuilder(
                  stream: CheckService.getChecks(widget.task),
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
                            CheckService.addCheck(widget.task);
                          } else {
                            CheckService.deleteCheck(widget.task, currentCheck);
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
                        CheckService.addCheck(widget.task);
                      },
                    ),
                  ),
                  loading: const SizedBox(),
                )
            ],
          ),
          StreamFirestoreQueryBuilder(
            stream: CheckService.getChecks(widget.task),
            success: (context, snapshot) {
              List<Check> checks = snapshot.data!.docs.map((e) => Check.fromJson(e.data())).toList();
              checks.sort((a, b) => a.checkedAt.compareTo(b.checkedAt));

              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  cacheExtent: 5000,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 3.3,
                  ),
                  itemCount: checks.length,
                  itemBuilder: (context, index) {
                    Check check = checks[index];

                    return Boxy(
                      color: getBgColor(check.checkedAt, today),
                      borderRadius: BorderRadius.circular(100),
                      child: Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          check.checkedAt.formatToBadge(),
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.bold,
                            color: getFontColor(check.checkedAt, today),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            noData: const SizedBox(),
            loading: const SizedBox(),
          ),
          // VWButton(
          //   label: "Test",
          //   onTap: () {
          //     CheckService.addCheckTest(widget.task, count = count + 3);
          //   },
          // ),
        ],
      ),
    );
  }
}
