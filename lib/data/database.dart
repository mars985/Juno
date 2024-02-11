import 'package:hive_flutter/hive_flutter.dart';

class ExpensesDatabase {
  List transactionHistory = [];
  List persons = [];
  List walletAmount = [];
  List habits = [];

  final _myBox = Hive.box('myBox');
  // final _transactionHistory = Hive.box("transactionHistory");
  // final _persons = Hive.box("persons");
  // final _wallet = Hive.box("wallet");
  // final _habits = Hive.box("habits");

  void createInitialData() {
    transactionHistory = [
      [
        "string name of person",
        "float transaction amount",
        "string date and time",
        // "string how pending",
        "string which wallet",
        "string description",
      ],
    ];
    persons = [
      "string name",
    ];
    walletAmount = [
      "float amount",
    ];
    habits = [
      []
    ];
  }

  void loadData() {
    var loadedData = _myBox.get("EXPENSES");
    transactionHistory = loadedData ?? [];
  }

  void updateDataBase() {
    _myBox.put("EXPENSES", transactionHistory);
  }
}
