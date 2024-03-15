// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:juno/data/databasehabits.dart';
import 'package:juno/heatmap/src/heatmap.dart';

import 'text_widgets.dart';

class MyTile extends StatelessWidget {
  const MyTile({
    super.key,
    required this.index,
    required this.habitsDatabase,
  });

  final HabitsDatabase habitsDatabase;
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
            InfoBar(
              index: index,
              habitsDatabase: habitsDatabase,
            ),
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

class InfoBar extends StatelessWidget {
  InfoBar({
    super.key,
    required this.index,
    required this.habitsDatabase,
  });

  final int index;
  final habitsDatabase;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconContainer(
              icon: Icon(Icons.monitor_heart_rounded),
              onTap: () {},
            ),
            IconContainer(
              icon: Icon(Icons.delete),
              onTap: () {
                habitsDatabase.deleteTaskAt(index);
              },
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Heading(text: habitsDatabase.getTaskAt(index)["taskname"]),
                  Subtitle(text: habitsDatabase.getTaskAt(index)["description"]),
                ],
              ),
            )
          ],
        ),
        IconContainer(
          icon: Icon(Icons.add_rounded),
          onTap: () {},
        ),
      ],
    );
  }
}

class MyHeatMap extends StatelessWidget {
  MyHeatMap({super.key, required this.dataMap});
  final Map<DateTime, int> dataMap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: HeatMap(
        margin: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
        scrollable: true,
        endDate: DateTime.now(),
        datasets: dataMap,
        defaultColor: Colors.grey[600],
        colorsets: {0: Colors.red},
        size: 10,
        showText: false,
        borderRadius: 2,
        showColorTip: false,
      ),
    );
  }
}

class TaskCreationDialog extends StatefulWidget {
  TaskCreationDialog({
    required Box habits,
  });
  final _controllerDescription = TextEditingController();
  final _controllerName = TextEditingController();

  @override
  State<TaskCreationDialog> createState() => _TaskCreationDialogState();
}

class _TaskCreationDialogState extends State<TaskCreationDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        children: [
          TextField(
            controller: widget._controllerName,
            decoration:
                InputDecoration(fillColor: Colors.grey[100], filled: true),
          ),
          TextField(
            controller: widget._controllerDescription,
            decoration:
                InputDecoration(fillColor: Colors.grey[100], filled: true),
          ),
          IconButton(
            onPressed: () {
              HabitsDatabase().pushNewTask(widget._controllerName.text,
                  widget._controllerDescription.text);
              widget._controllerName.clear();
              widget._controllerDescription.clear();
              Navigator.pop(context);
            },
            icon: Icon(Icons.done_rounded),
          ),
        ],
      ),
    );
  }
}

class IconContainer extends StatelessWidget {
  const IconContainer({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final Icon icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey[350],
          ),
          child: icon,
        ),
      ),
    );
  }
}
