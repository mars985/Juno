// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:juno/data/databasehabits.dart';
import 'package:juno/models/habit_widgets.dart';
import 'package:provider/provider.dart';

class HabitPage extends StatefulWidget {
  HabitPage({super.key});

  @override
  State<HabitPage> createState() => _HabitPageState();
}

class _HabitPageState extends State<HabitPage> {
  final _habits = Hive.box("habits");

  final hdb = HabitsDatabase();

  final _controllerName = TextEditingController();

  final _controllerDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Builder(
        builder: (context) {
          var habitsDatabase =
              Provider.of<HabitsDatabase>(context, listen: true);
          return ListView.builder(
            itemCount: habitsDatabase.getLength(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            itemBuilder: (context, index) {
              return MyTile(index: index, habitsDatabase: habitsDatabase);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return TaskCreationDialog(
                habits: _habits,
              );
            },
          );
        },
      ),
    );
  }
}
