import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:juno/data/databasehabits.dart';
import 'package:juno/heatmap/src/heatmap.dart';

import 'text_widgets.dart';

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
        // colorTipSize: 0,
        size: 10,
        showText: false,
        borderRadius: 2,
        showColorTip: false,
      ),
    );
  }
}

class InfoBar extends StatelessWidget {
  InfoBar({
    super.key,
    required this.index,
  });

  final int index;
  final hdb = HabitsDatabase();

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
            Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Heading(text: hdb.getTask(index)["taskname"]),
                  // Heading(text: "title"),
                  Subtitle(text: "description"),
                ],
              ),
            ),
          ],
        ),
        // Container(color: Colors.amber, height: 10, width: 10),
        IconContainer(
          icon: Icon(Icons.add_rounded),
          onTap: () {},
        ),
        // Container(color: Colors.amber, height: 10, width: 10),
      ],
    );
  }
}

class TaskCreationDialog extends StatefulWidget {
  const TaskCreationDialog({
    required TextEditingController controllerName,
    required TextEditingController controllerDescription,
    required Box habits,
  })  : _controllerName = controllerName,
        _controllerDescription = controllerDescription,
        _habits = habits;

  final TextEditingController _controllerName;
  final TextEditingController _controllerDescription;
  final Box _habits;

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
              setState(() {
                HabitsDatabase().pushNewTask(widget._controllerName.text,
                    widget._controllerDescription.text);
              });
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.grey[350],
        ),
        child: icon,
      ),
    );
  }
}
