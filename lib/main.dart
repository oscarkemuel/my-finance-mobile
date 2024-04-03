import 'package:flutter/material.dart';
import 'package:my_finance/models/bank.dart';
import 'package:my_finance/models/category.dart';
import 'package:my_finance/models/expense.dart';
import 'package:my_finance/models/income.dart';
import 'package:my_finance/widgets/bank_list.dart';
import 'package:my_finance/widgets/expense_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFEF5354)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'My finance app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _banks = [
    Bank(name: 'Nubank', balance: 5000, id: 1),
    Bank(name: 'Inter', balance: 2000, id: 2),
  ];

  final _categorys = [
    Category(id: 1, name: 'Food', icon: Icons.food_bank),
    Category(id: 2, name: 'Transport', icon: Icons.directions_bus),
    Category(id: 3, name: 'Health', icon: Icons.local_hospital),
    Category(id: 4, name: 'Education', icon: Icons.school),
    Category(id: 5, name: 'Entertainment', icon: Icons.movie),
    Category(id: 6, name: 'Others', icon: Icons.more_horiz),
  ];

  final _expenses = [
    Expense(
      id: 1,
      name: 'Pizza',
      amount: 50,
      date: DateTime.now(),
      categoryId: 1,
      bankId: 1,
    ),
    Expense(
      id: 2,
      name: 'Bus',
      amount: 5,
      date: DateTime.now(),
      categoryId: 2,
      bankId: 2,
    ),
    Expense(
      id: 3,
      name: 'Medicine',
      amount: 100,
      date: DateTime.now(),
      categoryId: 3,
      bankId: 1,
    ),
    Expense(
      id: 4,
      name: 'Book',
      amount: 30,
      date: DateTime.now(),
      categoryId: 4,
      bankId: 2,
    ),
    Expense(
      id: 5,
      name: 'Movie',
      amount: 20,
      date: DateTime.now(),
      categoryId: 5,
      bankId: 1,
    ),
    Expense(
      id: 6,
      name: 'Others',
      amount: 10,
      date: DateTime.now(),
      categoryId: 6,
      bankId: 2,
    ),
  ];

  final _incomes = [
    Income(
      id: 1,
      name: 'Salary',
      amount: 5000,
      date: DateTime.now(),
    ),
    Income(
      id: 2,
      name: 'Freelancer',
      amount: 2000,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final totalIncome = _incomes.fold(0.0, (sum, item) => sum + item.amount);
    final totalExpense = _expenses.fold(0.0, (sum, item) => sum + item.amount);
    final netBalance = totalIncome - totalExpense;

    _expenses.sort((a, b) => b.date.compareTo(a.date));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        titleTextStyle: const TextStyle(color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              ListTile(
                title: const Text('Saldo total'),
                subtitle: Text('R\$${netBalance.toStringAsFixed(2)}'),
                tileColor:
                    netBalance >= 0 ? Colors.green[100] : Colors.red[100],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('Últimas despesas:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                      onPressed: () {}, child: const Text('Ver mais')),
                ],
              ),
              ExpenseList(
                expenses: _expenses,
                categories: _categorys,
                displayCount: 4,
                isHome: true,
              ),
              // button para ver mais
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('Bancos:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                      onPressed: () {}, child: const Text('Adicionar banco')),
                ],
              ),
              BankList(banks: _banks, isHome: true),
            ],
          )),
    );
  }
}
