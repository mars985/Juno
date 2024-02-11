import 'package:hive_flutter/hive_flutter.dart';

class HabitsDatabase {
  final _habits = Hive.box("habits");

  void pushNewDay() {
    DateTime now = DateTime.now();
    now = now.toLocal();
    DateTime day = DateTime(now.year, now.month, now.day);
    List dayData = [
      [
        [
          "Drink water",
          false,
          DateTime(now.year, now.month, now.day, now.hour, now.minute),
          "NA",
        ], // task
      ], // category
    ];

    _habits.get(day) ?? _habits.put(day, dayData);
  }
}