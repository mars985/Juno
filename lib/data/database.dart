import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List transactionHistory = [];
  List persons = [];

  final _myBox = Hive.box('myBox');

  void createInitialData() {
    transactionHistory = [
      [
        "string name of person",
        "float transaction amount",
        "string date and time",
        "string pending",
        "string wallet",
        "string description",
      ],
    ];
  }

  void loadData() {
    var loadedData = _myBox.get("TODOLIST");
    transactionHistory = loadedData ?? [];
  }

  void updateDataBase() {
    _myBox.put("TODOLIST", transactionHistory);
  }
}
