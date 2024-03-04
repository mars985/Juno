import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:juno/data/databasehabits.dart';

class TaskTile extends StatelessWidget {
  final indexTask;
  final indexCategory;
  VoidCallback onTap;

  TaskTile({
    super.key,
    required this.indexTask,
    required this.indexCategory,
    required this.onTap,
    required
  });

  HabitsDatabase hdb = HabitsDatabase();

  final _habits = Hive.box("habits");

  getValueAt(indexCategory, indexTask, indexProperty, day) {
    return _habits
        .get(day)[indexCategory][indexTask][indexProperty]
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(getValueAt(indexCategory, indexTask, 0, hdb.getDay())),
      // title: Text("pl"),
      leading: Checkbox(
        value: false,
        onChanged: (value) => onTap,
      ),
    );
  }
}
