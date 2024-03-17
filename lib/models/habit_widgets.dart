// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconContainer(
                icon: Icon(Icons.monitor_heart_rounded),
                onTap: () {},
              ),
            ),
            MyButton(
              child: Icon(Icons.delete),
              splashColor: Colors.red,
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
                  Subtitle(
                      text: habitsDatabase.getTaskAt(index)["description"]),
                ],
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyButton(
            onTap: () {
              print("pressed");
            },
            child: Icon(Icons.add_rounded),
            splashColor: Colors.blueAccent,
          ),
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

class TaskCreationDialog extends StatelessWidget {
  TaskCreationDialog({
    required this.habitsDatabase,
  });

  final HabitsDatabase habitsDatabase;
  final _controllerDescription = TextEditingController();
  final _controllerName = TextEditingController();

  void submitTask(BuildContext context) {
    habitsDatabase.pushNewTask(
        _controllerName.text, _controllerDescription.text);
    _controllerName.clear();
    _controllerDescription.clear();

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controllerName,
              autofocus: true,
              decoration:
                  InputDecoration(fillColor: Colors.grey[100], filled: true),
            ),
            TextField(
              controller: _controllerDescription,
              onEditingComplete: () => submitTask(context),
              decoration:
                  InputDecoration(fillColor: Colors.grey[100], filled: true),
            ),
            SizedBox(height: 10),
            IconButton(
              onPressed: () => submitTask(context),
              icon: Icon(Icons.done_rounded),
            ),
          ],
        ),
      ),
    );
  }
}

class IconContainer extends StatelessWidget {
  IconContainer({
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

class MyButton extends StatelessWidget {
  MyButton({
    super.key,
    required this.onTap,
    required this.child,
    required this.splashColor,
  });

  final VoidCallback? onTap;
  final Widget child;
  final Color splashColor;

  bool _pressed = false;
  // final ButtonStyle _buttonStyle = ButtonStyle(
  @override
  Widget build(BuildContext context) {
    // return ElevatedButton(
    //   onPressed: onTap,
    //   style: _buttonStyle,
    //   child: child,
    // );
    return Material(
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        splashColor: splashColor,
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Center(
          child: Container(
            height: 48,
            width: 48,
            child: child,
          ),
        ),
      ),
    );
    // return GestureDetector(
    //   onTapDown: (_) {
    //     setState(() {
    //       widget._pressed = true;
    //     });
    //   },
    //   onTapUp: (_) {
    //     setState(() {
    //       widget._pressed = false;
    //     });
    //     widget.onTap!();
    //   },
    //   onTapCancel: () {
    //     setState(() {
    //       widget._pressed = false;
    //     });
    //   },
    //   child: AnimatedContainer(
    //     duration: Duration(milliseconds: 100),
    //     height: widget._pressed ? 48 : 48,
    //     width: widget._pressed ? 48 : 48,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(4),
    //       color: widget._pressed ? Colors.grey[200] : Colors.grey[100],
    //     ),
    //     child: Center(
    //       child: widget.child,
    //     ),
    //   ),
    // );
  }
}