// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:juno/data/databasehabits.dart';
import 'package:juno/data/theme.dart';
import 'package:juno/models/habit_dialogs.dart';
import 'package:juno/models/habit_widgets.dart';
import 'package:provider/provider.dart';

class HabitPage extends StatefulWidget {
  HabitPage({super.key});

  @override
  State<HabitPage> createState() => _HabitPageState();
}

class _HabitPageState extends State<HabitPage> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      var habitsDatabase = Provider.of<HabitsDatabase>(context, listen: true);
      return Scaffold(
        body: Builder(
          builder: (context) {
            return ListView.builder(
              itemCount: habitsDatabase.getLength(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              itemBuilder: (context, index) {
                return MyTile(index: index, habitsDatabase: habitsDatabase);
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_rounded),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return TaskCreationDialog(
                  habitsDatabase: habitsDatabase,
                );
              },
            );
          },
        ),
      );
    });
  }
}

class MyTile extends StatelessWidget {
  MyTile({
    super.key,
    required this.index,
    required this.habitsDatabase,
  });

  final HabitsDatabase habitsDatabase;
  final int index;
  final _myThemes = MyThemes().lightTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: _myThemes.backgroundAccent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoBar(
              index: index,
              habitsDatabase: habitsDatabase,
            ),
            // MyHeatMap(
            //   dataMap: {
            //     DateTime(2024, 03, 01): 1,
            //     DateTime(2024, 03, 02): 2,
            //     DateTime(2024, 03, 03): 3,
            //     DateTime(2024, 03, 04): 4,
            //     DateTime(2024, 03, 05): 5,
            //   }, // TODO
            // ),

            MyHeatMap(
              dataMap: habitsDatabase.String2DateTime(
                habitsDatabase.getDatasetAt(index),
              ),
            ),

            // MyHeatMap(dataMap: {
            //   DateTime(
            //     DateTime.now().year,
            //     DateTime.now().month,
            //     DateTime.now().day,
            //   ): 10,
            // }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("count: 100"),
            ),
          ],
        ),
      ),
    );
  }
}
