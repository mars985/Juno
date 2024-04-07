import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class HabitsDatabase extends ChangeNotifier {
  final _habits = Hive.box("habits");

  // UTIL

  int getLength() {
    return _habits.length;
  }

  String getTaskname(int index) {
    String taskname = getTaskAt(index)["taskname"];

    return taskname;
  }

  void deleteTaskAt(int index) {
    _habits.deleteAt(index);

    notifyListeners();
  }

  // GET DATA

  getTaskAt(int index) {
    return _habits.getAt(index);
  }

  int getDayDataAt(int index, String date) {
    var taskData = getTaskAt(index);
    var returnData = taskData["dataset"][date];

    return returnData ?? 0;
  }

  // CREATE NEW TASK

  void pushNewTask(String taskname, String description) {
    if (_habits.containsKey(taskname)) {
      return;
    }

    var putData = {
      "taskname": taskname.toString(),
      "description": description.toString(),
      "dataset": <String, int>{},
    };
    _habits.put(taskname.toString(), putData);

    notifyListeners();
  }

  // UPDATE TASK DATA

  void putDayDataAt(int index, String date, int count) {
    final task = getTaskAt(index);
    Map temp = task["dataset"];

    Map<String, int> taskDataset = {};
    temp.forEach((key, value) {
      if (key is String && value is int)
      taskDataset[key]=value;
    });

    taskDataset[date] = count;

    var putTask = {
      "taskname": task["taskname"],
      "description": task["description"],
      "dataset": taskDataset,
    };

    _habits.putAt(index, putTask);
    notifyListeners();
  }

  void putTodayDataAt(int index, int count) {
    var date = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    var date2 = DateFormat("yyyy-MM-dd").format(date);
    putDayDataAt(index, date2, count);
  }

  Map<String, int> getDatasetAt(int index) {
    Map<String, int> datasetString = <String, int>{};
    var temp = getTaskAt(index)["dataset"];
    temp.forEach(
      (key, value) {
        if (key is String && value is int) datasetString[key] = value;
      },
    );
    return datasetString;
  }

  // converter funcs

  Map<DateTime, int> String2DateTime(Map<String, int> datasetString) {
    Map<DateTime, int> datasetDateTime = <DateTime, int>{};
    DateTime newkey;

    datasetString.forEach((key, value) {
      newkey = DateTime.parse(key);
      datasetDateTime[newkey] = value;
    });

    return datasetDateTime;
  }

  Map<String, int> DateTime2String(Map<DateTime, int> datasetDateTime) {
    Map<String, int> datasetString = <String, int>{};
    String newkey;

    datasetDateTime.forEach((key, value) {
      newkey = DateFormat("yyyy-MM-dd").format(key);
      datasetString[newkey] = value;
    });

    return datasetString;
  }

  void debugger() {
    putDayDataAt(1, "2024-03-20", 10);
    putTodayDataAt(1, 15);
  }
}
