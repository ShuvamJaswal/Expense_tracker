// ignore_for_file: constant_identifier_names

enum TransactionType { INCOME, EXPENSE }

class TransactionModel {
  final String name;
  final DateTime dateTime;
  final TransactionType type;
  int amount = 0;
  TransactionModel(
      {required this.name,
      required this.dateTime,
      required this.type,
      required this.amount});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'type': type.toString().split('.')[1],
      'amount': amount.toString()
    };
  }

  factory TransactionModel.fromJson(Map map) {
    print(map);
    return TransactionModel(
        name: map['name'],
        amount: int.parse(map['amount']),
        dateTime:
            DateTime.fromMillisecondsSinceEpoch(int.parse(map['dateTime'])),
        type: TransactionType.values.byName(map['type']));
  }
}
