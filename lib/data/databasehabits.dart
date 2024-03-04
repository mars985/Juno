import 'package:hive_flutter/hive_flutter.dart';

class HabitsDatabase {
  final _habits = Hive.box("habits");

  void pushNewDay() {
    DateTime now = DateTime.now().toLocal();
    final day = "${now.year}-${now.month}-${now.day}";

    // List dayData = [
    //   [
    //     [
    //       "Drink water",
    //       false,
    //       DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second),
    //       "DateTime obj",
    //     ], // task
    //   ], // category
    // ];

    List dayData = [
      [
        {
          "taskName": "Drink water",
          "isCompleted": false,
          "timestampDeadline": DateTime(
              now.year, now.month, now.day, now.hour, now.minute, now.second),
          "timestampCompletion": "DateTime obj",
        }, // task
      ], // category
    ];

    // List dayData = [
    //   {
    //     "taskName": "Drink water",
    //     "isCompleted": false,
    //     "timestampDeadline": DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second),
    //     "timestampCompletion": "DateTime obj",
    //     "categoryName" : "Survive",
    //   }, // task
    // ];
    _habits.get(day) ?? _habits.put(day, dayData);
  }

  String getDay() {
    DateTime now = DateTime.now().toLocal();
    final day = "${now.year}-${now.month}-${now.day}";

    return day;
  }

  getValueAt(indexCategory, indexTask, indexProperty, day) {
    return _habits.get(day)[indexCategory][indexTask][indexProperty].toString();
  }
}
