import 'package:hive_flutter/hive_flutter.dart';

class HabitsDatabase {
  final _habits = Hive.box("habits");

  void pushNewDay(taskname) {
    DateTime now = DateTime.now().toLocal();
    final day = DateTime(now.year, now.month, now.day);
  }

  getTask(index) {
    return (_habits.toMap())[index] ??
        {
          "taskname": "task?",
          "description": "desc?",
          "dataset": {},
        };
  }

  // void pushNewDayToTask(String taskname, DateTime date) {
  //   if (_habits.toMap()[taskname].containsKey(date)) {
  //     return;
  //   } else {
  //     var taskMap = _habits.get(taskname);
  //     Map<String, int> dataset = taskMap["dataset"];
  //     var putData = {
  //       "name": taskname,
  //       "description": taskMap["description"],
  //       "dataset": dataset.addAll({DateTime.now.toString(): 0}),
  //     };
  //     _habits.put(taskname, putData);
  //   }
  // }

  void pushNewTask(String taskname, String description) {
    if (_habits.containsKey(taskname)) {
      return;
    } else {
      Map<DateTime, int> dataset = {};
      var putData = {
        "taskname": taskname.toString(),
        "description": description.toString(),
        "dataset": dataset,
      };

      _habits.put(taskname.toString(), putData);
      // print(description);
      return;
    }
  }

  // void updateDataset(String taskname, DateTime date, int count) {
  //   _habits.pu
  // }

  // old code

  String getDay() {
    DateTime now = DateTime.now().toLocal();
    final day = "${now.year}-${now.month}-${now.day}";

    return day;
  }

  // getValueAt(indexCategory, indexTask, indexProperty, day) {
  //   return _habits.get(day)[indexCategory][indexTask][indexProperty].toString();
  // }
}
