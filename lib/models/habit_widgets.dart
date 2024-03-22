// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, sort_child_properties_last, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:juno/data/databasehabits.dart';
import 'package:juno/data/theme.dart';
import 'package:juno/heatmap/src/heatmap.dart';

import 'text_widgets.dart';

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
  final _myThemes = MyThemes().lightTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              // padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              padding: EdgeInsets.all(8),
              child: IconContainer(
                icon: Icon(
                  Icons.monitor_heart_rounded,
                  color: _myThemes.background,
                ),
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
              padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
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
            splashColor: _myThemes.primary,
          ),
        ),
      ],
    );
  }
}

class MyHeatMap extends StatelessWidget {
  MyHeatMap({super.key, required this.dataMap});

  final Map<DateTime, int> dataMap;
  final _myTheme = MyThemes().lightTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: HeatMap(
        margin: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
        scrollable: true,
        endDate: DateTime.now(),
        datasets: dataMap,
        defaultColor: _myTheme.secondary,
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
  final _myTheme = MyThemes().lightTheme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: _myTheme.primary,
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

  final _myThemes = MyThemes().lightTheme;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        splashColor: splashColor,
        // overlayColor: MaterialStatePropertyAll(_myThemes.accent),
        // hoverColor: _myThemes.accent,
        // hoverColor: _myThemes.primary,
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          height: 48,
          width: 48,
          child: child,
        ),
      ),
    );
  }
}
