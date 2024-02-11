import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:juno/data/databasehabits.dart';

class HabitPage extends StatelessWidget {
  const HabitPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final hdb = HabitsDatabase();
    final _habits = Hive.box("habits");

    void func(value, indexTask) {
      DateTime now = DateTime.now();
      DateTime day = DateTime(now.year, now.month, now.day);

      var existingData = _habits.get(day);
      existingData[1] = value;

      _habits.put(day, existingData);
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: (_habits.get(hdb.getDay())).length,
            itemBuilder: (BuildContext context, int indexCategory) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: ((_habits.get(hdb.getDay()))[indexCategory]).length,
                itemBuilder: (BuildContext context, int indexTask) {
                  return TaskTile(
                    indexTask: indexTask,
                    indexCategory: indexCategory,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class TaskTile extends StatefulWidget {
  final indexTask;
  final indexCategory;
  TaskTile({
    super.key,
    required this.indexTask,
    required this.indexCategory,
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  HabitsDatabase hdb = HabitsDatabase();

  final _habits = Hive.box("habits");

  func(indexCategory, indexTask, indexProperty) {
    return (((_habits.get(hdb.getDay()))[widget.indexCategory])[widget.indexTask])[indexProperty];
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text((((_habits
          .get(hdb.getDay()))[widget.indexCategory])[widget.indexTask])[2].toString()),
      leading: Checkbox(
        value: false,
        onChanged: (value) {},
      ),
    );
  }
}
