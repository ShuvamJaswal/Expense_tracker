import 'package:expense_tracker_app/models/transactions.dart';
import 'package:expense_tracker_app/services/db_service.dart';
import 'package:flutter/material.dart';

class TransactionsProvider extends ChangeNotifier {
  late DbService db;
  TransactionsProvider() {
    init();
  }
  void addTransaction(
      {required String name,
      required String amount,
      required DateTime time,
      required TransactionType transactionType}) {
    _transactions.add(TransactionModel(
        name: name,
        dateTime: time,
        type: transactionType,
        amount: int.parse(amount)));
    db.insertTransaction(TransactionModel(
        name: name,
        dateTime: time,
        type: transactionType,
        amount: int.parse(amount)));
    notifyListeners();
  }

  void init() async {
    db = DbService();
    await db.initDb();
    _transactions = await db.queryTransaction();
    notifyListeners();
  }

  List<TransactionModel> _transactions = [];
  void sortTransactions({String type = 'Name'}) {
    switch (type) {
      case 'Name':
        _transactions.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        break;

      case 'Type':
        _transactions.sort((a, b) => a.type
            .toString()
            .toLowerCase()
            .compareTo(b.type.toString().toLowerCase()));
        break;
      case 'Date':
        _transactions.sort((a, b) => a.dateTime.compareTo(b.dateTime));
        break;
    }
    notifyListeners();
  }

  List<TransactionModel> getTransactions({String type = 'Default'}) {
    return _transactions;
  }
}
