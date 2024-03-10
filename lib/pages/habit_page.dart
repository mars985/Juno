// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:juno/data/databasehabits.dart';
import 'package:juno/models/habit_widgets.dart';

class HabitPage extends StatelessWidget {
  HabitPage({super.key});
  final _habits = Hive.box("habits");
  final hdb = HabitsDatabase();

  final _controllerName = TextEditingController();
  final _controllerDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // return ListView.builder(
    //   itemBuilder: (context, index) {
    //     return Column(
    //       children: [
    //         Text(hdb.getTask(index)["name"]),
    //         Text(hdb.getTask(index)["description"]),
    //       ],
    //     );
    //   },
    //   itemCount: _habits.toMap().length,
    //   shrinkWrap: true,
    //   scrollDirection: Axis.vertical,
    // );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(tabs: [
            Tab(icon: Icon(Icons.task)),
            Tab(icon: Icon(Icons.add)),
          ]),
        ),
        body: TabBarView(children: [
          ListView.builder(
            itemCount: _habits.length,
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            itemBuilder: (context, index) {
              return MyTile(index: index);
            },
          ),
          TaskCreationDialog(
              controllerName: _controllerName,
              controllerDescription: _controllerDescription,
              habits: _habits),
        ]),
      ),
    );
  }
}

class MyTile extends StatelessWidget {
  const MyTile({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.grey[500],
        ),
        child: Column(
          children: [
            InfoBar(index: index),
            MyHeatMap(
              dataMap: {
                DateTime(2024, 03, 01): 1,
                DateTime(2024, 03, 02): 2,
                DateTime(2024, 03, 03): 3,
                DateTime(2024, 03, 04): 4,
                DateTime(2024, 03, 05): 5,
              },
            ),
          ],
        ),
      ),
    );
  }
}
