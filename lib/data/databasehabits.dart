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

    if (kDebugMode) {
      print("getDayDataAt():\t$returnData");
    }
    return returnData ?? 999;
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
    var temp = task["dataset"];

    Map<String, int> taskDataset = {};
    if (temp.runtimeType == Map<String, int>) taskDataset = temp;

    taskDataset[date] = count;

    var putTask = {
      "taskname": task["taskname"],
      "description": task["description"],
      "dataset": taskDataset,
    };

    _habits.putAt(index, putTask);
    notifyListeners();

    if (kDebugMode) {
      var x = getDayDataAt(index, date);
      print("put $x");
    }
  }

  void putTodayDataAt(int index, int count) {
    var date = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    var date2 = DateFormat("yyyy-mm-dd").format(date);
    putDayDataAt(index, date2, count);
  }

  Map<String, int> getDatasetAt(int index) {
    final Map<String, int> datasetString = getTaskAt(index)["dataset"];
    // final Map<String, int> datasetString = {};
    // Map<String, int> returnData = {};
    // datasetString.forEach((key, value) {
    //   returnData[key] = value;
    // });

    return datasetString;
  }

  // converter funcs

  Map<DateTime, int> String2DateTime(Map<String, int> datasetString) {
    Map<DateTime, int> datasetDateTime = {};
    DateTime newkey;

    datasetString.forEach((key, value) {
      newkey = DateTime.parse(key);
      datasetDateTime[newkey] = value;
    });

    return datasetDateTime;
  }

  Map<String, int> DateTime2String(Map<DateTime, int> datasetDateTime) {
    Map<String, int> datasetString = {};
    String newkey;

    datasetDateTime.forEach((key, value) {
      newkey = DateFormat("yyyy-mm-dd").format(key);
      datasetString[newkey] = value;
    });

    return datasetString;
  }

  void debugger() {
    var date = DateFormat("yyyy-mm-dd").format(DateTime(2024, 03, 28));
    // putDayDataAt(0, date, 777);

    var data = getDayDataAt(0, date);
    print("DayData ${data}");

    // print(getDatasetAt(0).runtimeType);
    // print(date.toString());
  }
}
