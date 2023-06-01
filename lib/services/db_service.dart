import 'package:expense_tracker_app/models/transactions.dart';
import 'package:sqflite/sqflite.dart';

class DbService {
  Database? _db;
  final String _tableName = 'transactions';
  final String _path = 'expenses.db';
  Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String path = await getDatabasesPath() + _path;
      _db = await openDatabase(path,
          version: 1, onCreate: (db, version) => db.execute('''
         CREATE TABLE $_tableName(
          id INTEGER PRIMARY KEY,
          type TEXT, name TEXT, amount TEXT, 
          dateTime TEXT)
        '''));
    } catch (e) {
      print(e);
    }
  }

  Future<int> insertTransaction(TransactionModel transaction) async {
    return await _db!.insert(_tableName, transaction.toJson());
  }

  Future<List<TransactionModel>> queryTransaction() async {
    await initDb();
    final data = await _db!.query(_tableName);
    return List.generate(data.length, (i) {
      return TransactionModel.fromJson(data[i]);
    });
  }
}
