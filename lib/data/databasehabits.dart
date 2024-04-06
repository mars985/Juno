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
    var taskData = getTaskAt(index);
    String taskname = taskData["taskname"];

    return taskname;
  }

  DateTime formatToday() {
    return DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
  }

  void deleteTaskAt(int index) {
    _habits.deleteAt(index);

    notifyListeners();
  }

  // GET DATA

  getTask(String taskname) {
    return _habits.get(taskname);
  }

  getTaskAt(int index) {
    return _habits.getAt(index);
  }

  int getDayData(String taskname, DateTime date) {
    var taskData = getTask(taskname);
    return taskData["dataset"][date.toString()] ?? 999;
  }

  int getDayDataAt(int index, DateTime date) {
    var taskData = getTaskAt(index);
    var returnData = taskData["dataset"][date.toString()];
    print(returnData);
    return returnData ?? 999;
  }
  // int getDayDataAt(int index, DateTime date) {
  //   var taskname = getTaskname(index);
  //   return getDayData(taskname, date);
  // }

  // CREATE NEW TASK

  void pushNewTask(String taskname, String description) {
    if (_habits.containsKey(taskname)) {
      return;
    }

    Map<DateTime, int> initDataset = {formatToday(): 0};
    var putData = {
      "taskname": taskname.toString(),
      "description": description.toString(),
      "dataset": initDataset,
    };
    _habits.put(taskname.toString(), putData);

    notifyListeners();
  }

  // UPDATE TASK DATA

  void putDayData(String taskname, DateTime date, int count) {
    var taskData = getTask(taskname);
    var putDataset = taskData["dataset"];
    putDataset[date.toString()] = count;

    var putData = {
      "taskname": taskData["taskname"],
      "description": taskData["description"],
      "dataset": taskData,
    };
    _habits.put(taskname, putData);
    var x = getDayData(taskname, date);
    print("put $x");
  }

  void putDayDataAt(int index, DateTime date, int count) {
    String taskname = getTaskname(index);
    print("Task name: $taskname");

    putDayData(taskname, date, count);

    notifyListeners();
  }

  void putTodayData(String taskname, int count) {
    final date = formatToday();
    putDayData(taskname, date, count);
  }

  Map<DateTime, int> getDataset(String taskname) {
    // Explicitly cast the fetched map to the desired type
    var originaldataset = getTask(taskname)["dataset"];
    Map<DateTime, int> dataset = {};
    originaldataset.forEach((key, value) {
      // Check if key is DateTime and value is int
      if (key is DateTime && value is int) {
        dataset[key] = value;
      }
    });
    // print(originaldataset.runtimeType);
    // print(dataset.runtimeType);
    // print(dataset);
    return dataset;
  }

  Map<DateTime, int> getDatasetAt(int index) {
    String taskname = getTaskname(index);
    Map<DateTime, int> dataset = getDataset(taskname);
    dataset.forEach((key, value) {
      // dataset[key] = value;
      // print("$key $value");
    });
    // print(dataset);
    return dataset;
  }

  void debugger() {
    var date = DateTime(2024, 03, 28);
    // putDayDataAt(0, date, 10);
    // var data = getDayDataAt(0, date);
    // print("DayData ${data}");
    // print(getDatasetAt(0).runtimeType);
    print(date.toString());
  }
}

class HabitsDatabase2 extends ChangeNotifier {
  final _habits = Hive.box("habits");

  // ===== WORKING =====

  int getLength() {
    return _habits.length;
  }

  DateTime formatToday() {
    return DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
  }

  void deleteTaskAt(int index) {
    _habits.deleteAt(index);

    notifyListeners();
  }

  // PROBABLY WORKING

  getTaskAt(int index) {
    return _habits.getAt(index);
  }

  // WORKING?

  int getDayDataAt(int index, DateTime date) {
    var taskData = getTaskAt(index);
    var returnData = taskData["dataset"][date.toString()];
    print(returnData);

    return returnData ?? 999;
  }

  // NEW

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

  // getter

  Map<DateTime, int> getDatasetAt(int index) {
    final Map<String, int> datasetString = {};
    //get from box

    final Map<DateTime, int> datasetDateTime = String2DateTime(datasetString);
    return datasetDateTime;
  }
}
