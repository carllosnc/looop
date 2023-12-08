import 'package:boxy/boxy.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vw/vw.dart';
import '/imports/app.dart';

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
        ),
        actions: [
          VWRow(
            gap: 10,
            padding: const EdgeInsets.only(right: 10),
            children: [
              const NewTask(),
              CircleAvatar(
                backgroundColor: Colors.black,
                maxRadius: 18,
                child: IconButton(
                  iconSize: 20,
                  padding: const EdgeInsets.all(0),
                  icon: const Icon(Icons.settings_outlined, color: Colors.white),
                  onPressed: () => context.push('/settings'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: VWColumn(
          horizontalAlignment: CrossAxisAlignment.center,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 45),
          gap: 1,
          children: [
            TaskBoard(
              emoji: "🍎",
              title: "Alimentação saudável",
              frequency: "Todas ás terças feiras",
            ),
            TaskBoard(
              emoji: "🏊‍♂️",
              title: "Natação",
              frequency: "Todo os dias às 6h30",
            ),
            TaskBoard(
              emoji: "🚴",
              title: "Pedalar",
              frequency: "Todo os dias às 6h30",
            ),
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
