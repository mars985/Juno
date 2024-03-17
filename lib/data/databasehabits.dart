import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HabitsDatabase extends ChangeNotifier {
  final _habits = Hive.box("habits");

  int getLength() {
    return _habits.length;
  }

  void pushNewTask(String taskname, String description) {
    if (_habits.containsKey(taskname)) {
      return;
    }

    var putData = {
      "taskname": taskname.toString(),
      "description": description.toString(),
      "dataset": <DateTime, int>{},
    };
    _habits.put(taskname.toString(), putData);

    notifyListeners();
  }

  getTaskAt(int index) {
    return _habits.getAt(index);
  }

  getTask(String taskname) {
    return _habits.get(taskname);
  }

  void deleteTaskAt(int index) {
    _habits.deleteAt(index);

    notifyListeners();
  }

  int getDayData(String taskname, DateTime date) {
    var taskData = getTask(taskname);
    return taskData["dataset"][date];
  }

  void putDayData(String taskname, DateTime date, int count) {
    var taskData = getTask(taskname);
    var putDataset = taskData["dataset"];
    putDataset[date] = count;

    var putData = {
      "taskname": taskData["taskname"],
      "description": taskData["description"],
      "dataset": taskData,
    };
    _habits.put(taskname, putData);
  }

  
}
