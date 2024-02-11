import 'package:hive_flutter/hive_flutter.dart';

class HabitsDatabase {
  final _habits = Hive.box("habits");

  void pushNewDay() {
    DateTime now = DateTime.now();
    now = now.toLocal();
    final day = "${now.year}-${now.month}-${now.day}";
    List dayData = [
      [
        [
          "Drink water",
          false,
          DateTime(now.year, now.month, now.day, now.hour, now.minute),
          "DateTime obj",
        ], // task
      ], // category
    ];

    _habits.get(day) ?? _habits.put(day, dayData);
  }

  String getDay() {
    DateTime now = DateTime.now();
    now = now.toLocal();
    final day = "${now.year}-${now.month}-${now.day}";
    
    return day;
  }
}
