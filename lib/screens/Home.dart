import 'package:expense_tracker_app/models/transactions.dart';
import 'package:expense_tracker_app/providers/transactions_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<TransactionsProvider>(context, listen: false).init();
    return Consumer<TransactionsProvider>(builder: (context, provider, child) {
      List transactions = provider.getTransactions();
      return ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) => ListTile(
                title: Text("Name: ${transactions[index].name}"),
                subtitle: Text(
                    "Type: ${transactions[index].type == TransactionType.INCOME ? "Income" : "Expense"}"),
                trailing: Column(
                  children: [
                    Text(
                      (transactions[index].type == TransactionType.INCOME
                              ? "+"
                              : "-") +
                          transactions[index].amount.toString(),
                      style: TextStyle(
                          fontSize: 20,
                          color:
                              transactions[index].type == TransactionType.INCOME
                                  ? Colors.green
                                  : Colors.red),
                    ),
                    Text(DateFormat('kk:mm dd/mm/yyyy')
                        .format(transactions[index].dateTime))
                  ],
                ),
              ));
    });
  }
}
