import 'package:expense_tracker_app/models/transactions.dart';
import 'package:expense_tracker_app/providers/transactions_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddTransactionScreen extends StatelessWidget {
  AddTransactionScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  TransactionType tType = TransactionType.INCOME;
  final TextEditingController _amountController = TextEditingController();
  bool switchState = false;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TransactionsProvider>(
        create: (_) => TransactionsProvider(),
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: const Text("ABC"),
            ),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              controller: _nameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                labelText: "Name",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              controller: _amountController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                labelText: "Amount",
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Income'),
                              StatefulBuilder(
                                builder: (context, setState) => Switch(
                                  value: switchState,
                                  onChanged: (value) {
                                    if (value) {
                                      tType = TransactionType.EXPENSE;
                                    } else {
                                      tType = TransactionType.INCOME;
                                    }
                                    setState(() {
                                      switchState = value;
                                    });
                                  },
                                ),
                              ),
                              Text('Expense'),
                            ],
                          ),
                          ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {}
                                Provider.of<TransactionsProvider>(context,
                                        listen: false)
                                    .addTransaction(
                                        name: _nameController.text,
                                        amount: _amountController.text,
                                        time: DateTime.now(),
                                        transactionType: tType);
                                Navigator.pop(context);
                              },
                              child: Text('Add'))
                        ])))));
  }
}
