// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, sort_child_properties_last, sized_box_for_whitespace, use_build_context_synchronously, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:intl/intl.dart';
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
            onTap: () => DoTask(context, index, habitsDatabase),
            child: Icon(Icons.add_rounded),
            splashColor: _myThemes.primary,
          ),
        ),
      ],
    );
  }

  void DoTask(
      BuildContext context, int index, HabitsDatabase habitsDatabase) async {
    DateTime? pickedDate = await _selectDate(context);
    var _value = 0;
    if (pickedDate != null) {
      DateTime dateDT = pickedDate;
      String date = DateFormat("yyyy-MM-dd").format(dateDT);
      print("picked date:\t$dateDT");
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Material(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SpinBox(
                      autofocus: true,
                      value:
                          habitsDatabase.getDayDataAt(index, date).toDouble(),
                      min: 0,
                      max: 500,
                      onChanged: (value) => _value = value.toInt(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel")),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                        child: ElevatedButton(
                          onPressed: () {
                            habitsDatabase.putDayDataAt(index, date, _value);
                            Navigator.pop(context);
                          },
                          child: Text("Submit"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now(),
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
