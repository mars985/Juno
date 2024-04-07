// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, sort_child_properties_last, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:juno/data/databasehabits.dart';
import 'package:juno/data/theme.dart';
import 'package:juno/heatmap/src/heatmap.dart';
import 'package:juno/models/habit_dialogs.dart';
import 'text_widgets.dart';

class InfoBar extends StatelessWidget {
  InfoBar({
    super.key,
    required this.index,
    required this.habitsDatabase,
  });

  final int index;
  final HabitsDatabase habitsDatabase;
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

            // debugger

            SizedBox(width: 8),
            MyButton(
              onTap: () {
                // habitsDatabase.getDatasetAt(index);
                // print(habitsDatabase.formatToday());
                // habitsDatabase.getDatasetAt(index);
                habitsDatabase.debugger();
              },
              child: Icon(Icons.bug_report_rounded),
              splashColor: Colors.green,
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
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyButton(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  // return DoTaskDialog();
                  // return CustomTimePickerDialog();
                  return DoTaskDialog(
                    habitsDatabase: habitsDatabase,
                    index: index,
                  );
                },
              );
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
  MyHeatMap({
    super.key,
    required this.dataMap,
  });

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
        // defaultColor: Colors.grey[200],
        colorsets: {0: _myTheme.accent},
        size: 10,
        showText: false,
        borderRadius: 2,
        showColorTip: false,
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
