import 'package:boxy/boxy.dart';
import 'package:flutter/material.dart';
import 'package:vw/vw.dart';

class TaskBoard extends StatelessWidget {
  final String emoji;
  final String title;
  final String frequency;

  const TaskBoard({
    this.emoji = '💪',
    this.title = 'Task title',
    this.frequency = 'Todo os dias às 6h30',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Boxy(
      width: double.infinity,
      borderRadius: BorderRadius.circular(25),
      padding: const EdgeInsets.all(20),
      color: Colors.black,
      child: VWColumn(
        gap: 20,
        children: [
          VWRow(
            gap: 15,
            children: [
              Text(
                emoji,
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
              Expanded(
                child: VWColumn(
                  gap: 2,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      frequency,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              //icon button check
              CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.2),
                child: IconButton(
                  icon: Icon(
                    Icons.check,
                    color: Colors.white.withOpacity(0.6),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 20,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              for (var i = 0; i < 60; i++)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
