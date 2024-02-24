import 'package:all_day/core/extensions/datetime.dart';
import 'package:all_day/imports/app.dart';
import 'package:boxy/boxy.dart';
import 'package:flutter/material.dart';
import 'package:vw/vw.dart';

class MonthGrid extends StatelessWidget {
  final Task task;
  final List<Check> checks;

  const MonthGrid({
    super.key,
    required this.task,
    required this.checks,
  });

  Map<String, List<DateTime>> formatedMonths() {
    DateTime initialDate = task.createdAt;
    DateTime lastDate = task.lastCheck!;

    Map<String, List<DateTime>> days = {};

    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    while (initialDate.isBefore(lastDate)) {
      String key = '${initialDate.year} • ${months[initialDate.month - 1]}';

      if (days[key] == null) {
        days[key] = [];
      }

      days[key]!.add(initialDate);
      initialDate = initialDate.add(const Duration(days: 1));
    }

    return days;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<DateTime>> months = formatedMonths();
    List<String> keys = months.keys.toList();

    return Container(
      padding: const EdgeInsets.only(bottom: 50),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: keys.length,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 30);
        },
        itemBuilder: (context, index) {
          String key = keys[index];
          List<DateTime> days = months[key]!;

          return VWColumn(
            horizontalAlignment: CrossAxisAlignment.center,
            gap: 10,
            children: [
              Boxy(
                width: 150,
                child: Text(
                  key,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ),
              Boxy(
                width: 150,
                child: GridView.builder(
                  itemCount: days.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    crossAxisSpacing: 13,
                    mainAxisSpacing: 13,
                  ),
                  itemBuilder: (context, index) {
                    DateTime day = days[index];
                    bool hasCheck = checks.any((e) => e.checkedAt.toCompare() == day.toCompare());

                    return Boxy(
                      borderRadius: BorderRadius.circular(100),
                      color: hasCheck ? Colors.black : Colors.black.withOpacity(0.2),
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
