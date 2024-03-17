import '/core/extensions/datetime.dart';
import '/imports/app.dart';
import 'package:boxy/boxy.dart';
import 'package:flutter/material.dart';
import 'package:vw/vw.dart';

class ProgressBoard extends StatefulWidget {
  final Task task;

  const ProgressBoard({
    super.key,
    required this.task,
  });

  @override
  State<ProgressBoard> createState() => _ProgressBoardState();
}

class _ProgressBoardState extends State<ProgressBoard> {
  late DateTime today = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Boxy(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black,
            Colors.black,
          ],
        ),
        borderRadius: BorderRadius.circular(30),
        child: Builder(builder: (context) {
          return VWColumn(
            gap: 20,
            children: [
              StreamFirestoreDocBuilder(
                stream: TaskService.getTask(widget.task),
                success: (context, snapshot) {
                  Task task = Task.fromJson(snapshot.data!.data()!);

                  return VWRow(
                    gap: 20,
                    verticalAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        task.icon,
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: VWColumn(
                          children: [
                            Text(
                              task.title.inCaps,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Started at: ${task.createdAt.formatDateTime()}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                noData: const SizedBox(),
                loading: const SizedBox(),
              ),
              StreamFirestoreQueryBuilder(
                stream: CheckService.getChecks(widget.task),
                success: (context, snapshot) {
                  List<Check> checks = snapshot.data!.docs.map((e) => Check.fromJson(e.data())).toList();
                  checks.sort((a, b) => a.checkedAt.compareTo(b.checkedAt));

                  DateTime firstCheck = checks.first.checkedAt;
                  DateTime lastCheck = checks.last.checkedAt;
                  int totalDays = lastCheck.difference(firstCheck).inDays + 1;

                  return VWColumn(
                    gap: 20,
                    children: [
                      GridView.builder(
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
                            color: Colors.green[700],
                            borderRadius: BorderRadius.circular(100),
                            child: Center(
                              child: Text(
                                textAlign: TextAlign.center,
                                check.checkedAt.formatToBadge(),
                                style: const TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      VWRow(
                        horizontalAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${checks.length} ${"check".pluralize(checks.length)} in $totalDays ${"day".pluralize(totalDays)}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                },
                noData: const Text(
                  'No checks yet',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                loading: const SizedBox(),
              ),
            ],
          );
        }),
      ),
    );
  }
}
