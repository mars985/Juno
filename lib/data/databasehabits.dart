import 'package:hive_flutter/hive_flutter.dart';

class HabitsDatabase {
  final _habits = Hive.box("habits");

  void pushNewTask(String taskname, String description) {
    if (_habits.containsKey(taskname)) {
      return;
    }
    var putData = {
      "taskname": taskname.toString(),
      "description": description.toString(),
      "dataset": <DateTime, int> {},
    };

    _habits.put(taskname.toString(), putData);
  }

  getTaskAt(int index) {
    return _habits.getAt(index);
  }

  void deleteTaskAt(int index) {
    _habits.deleteAt(index);
    print(index);
  }

  // void deleteTask(String key) {
  //   _habits.delete(key);
  // }



  // void updateDataset(String taskname, DateTime date, int count) {
  //   _habits.pu
  // }
}
