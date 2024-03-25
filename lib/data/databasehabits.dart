import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HabitsDatabase extends ChangeNotifier {
  final _habits = Hive.box("habits");

  // UTIL

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

  // --- --- ---

  getTask(String taskname) {
    return _habits.get(taskname);
  }
  getTaskAt(int index) {
    return _habits.getAt(index);
  }
  
  // --- --- ---

  int getDayData(String taskname, DateTime date) {
    var taskData = getTask(taskname);
    return taskData["dataset"][date];
  }
  int getDayDataAt(int index, DateTime date) {
    var taskname = getTaskname(index);
    return getDayData(taskname, date);
  }

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
    putDataset[date] = count;

    var putData = {
      "taskname": taskData["taskname"],
      "description": taskData["description"],
      "dataset": taskData,
    };
    _habits.put(taskname, putData);
  }

  void putDayDataAt(int index, DateTime date, int count) {
    String taskname = getTaskname(index);

    putDayData(taskname, date, count);
  }

  String getTaskname(int index) {
    var taskData = getTaskAt(index);
    String taskname = taskData["taskname"];

    return taskname;
  }

  void putTodayData(String taskname, int count) {
    final date = formatToday();
    putDayData(taskname, date, count);
  }


  // Map<DateTime, int> getDataset(String taskname) {
  //   Map<DateTime, int> originaldataset = getTask(taskname)["dataset"];
  //   Map<DateTime, int> dataset = {};
  //   originaldataset.forEach((key, value) {
  //     if (key is DateTime && value is int) {
  //       dataset[key] = value;
  //     }
  //   });
  //   return dataset;
  // }

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
    print(originaldataset.runtimeType);
    print(dataset.runtimeType);
    print(dataset);
    return dataset;
  }

  Map<DateTime, int> getDatasetAt(int index) {
    String taskname = getTaskname(index);
    Map<DateTime, int> dataset = getDataset(taskname);
    return dataset;
  }
}
