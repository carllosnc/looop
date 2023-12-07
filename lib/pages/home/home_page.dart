import 'package:boxy/boxy.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vw/vw.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text(
          'Bom dia, Carlos',
          style: TextStyle(
            fontSize: 23,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () => context.push('/chart'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: VWColumn(
          horizontalAlignment: CrossAxisAlignment.center,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 45),
          gap: 1,
          children: [
            TaskBoard(),
            TaskBoard(),
            TaskBoard(),
          ],
        ),
      ),
      bottomNavigationBar: Boxy(
        blurEffect: 50,
        color: Colors.black.withOpacity(0.5),
        child: const VWRow(
          padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
          children: [
            Text(
              "Hoje, 20 de setembro",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskBoard extends StatefulWidget {
  const TaskBoard({
    super.key,
  });

  @override
  State<TaskBoard> createState() => _TaskBoardState();
}

class _TaskBoardState extends State<TaskBoard> {
  @override
  Widget build(BuildContext context) {
    return Boxy(
      width: double.infinity,
      borderRadius: BorderRadius.circular(25),
      padding: const EdgeInsets.all(20),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.green.shade500,
          Colors.blue,
        ],
      ),
      child: const VWColumn(
        gap: 20,
        children: [
          VWRow(
            gap: 15,
            children: [
              SizedBox(
                width: 33,
                height: 33,
                child: Icon(
                  Icons.fitness_center,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: VWColumn(
                  gap: 5,
                  children: [
                    Text(
                      'Treino de musculação',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      'Todo os dias às 6h30',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          VWRow(
            horizontalAlignment: MainAxisAlignment.end,
            children: [
              VWButton(
                color: Colors.black,
                label: "Finalizar",
              ),
            ],
          )
        ],
      ),
    );
  }
}
