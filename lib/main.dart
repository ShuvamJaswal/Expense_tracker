import 'package:expense_tracker_app/screens/Home.dart';
import 'package:expense_tracker_app/providers/transactions_provider.dart';
import 'package:expense_tracker_app/screens/add_transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return ChangeNotifierProvider<TransactionsProvider>(
        create: (_) => TransactionsProvider(),
        child: MaterialApp(
          title: 'Expenses',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
            useMaterial3: true,
          ),
          home: const MyHomePage(title: 'Expenses'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> dropDown = [
    "Name",
    "Type",
    "Date",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            DropdownButton<String>(
                underline: Container(),
                icon: const Icon(Icons.sort),
                items: dropDown.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  Provider.of<TransactionsProvider>(context, listen: false)
                      .sortTransactions(type: value!);
                }),
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AddTransactionScreen();
                  }));
                },
                icon: const Icon(Icons.add)),
          ],
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: const Home());
  }
}
