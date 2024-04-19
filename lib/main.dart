import 'package:flutter/material.dart';
import 'package:my_finance/models/expense.dart';
import 'package:my_finance/screens/expenses_screen.dart';
import 'package:my_finance/screens/home_screen.dart';
import 'package:my_finance/screens/tabs_screen.dart';
import 'package:my_finance/stores/bank.store.dart';
import 'package:my_finance/stores/category.store.dart';
import 'package:my_finance/stores/income.store.dart';
import 'package:my_finance/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _expenses = [
    Expense(
      id: 1,
      name: 'CDB',
      amount: 1250,
      date: DateTime.parse('2024-01-10'),
      categoryId: 7,
      bankId: 2,
    ),
    Expense(
      id: 2,
      name: 'Academia',
      amount: 130,
      date: DateTime.parse('2024-01-10'),
      categoryId: 3,
      bankId: 1,
    ),
    Expense(
      id: 3,
      name: 'Internet',
      amount: 106,
      date: DateTime.parse('2024-01-10'),
      categoryId: 6,
      bankId: 1,
    ),
    Expense(
      id: 8,
      name: 'Uber/99',
      amount: 250,
      date: DateTime.parse('2024-01-10'),
      categoryId: 2,
      bankId: 1,
    ),
    Expense(
      id: 4,
      name: 'Recarga celular',
      amount: 25,
      date: DateTime.parse('2024-01-10'),
      categoryId: 6,
      bankId: 1,
    ),
    Expense(
      id: 5,
      name: 'Amazon Prime',
      amount: 15,
      date: DateTime.parse('2024-01-10'),
      categoryId: 5,
      bankId: 1,
    ),
    Expense(
      id: 6,
      name: 'Spotify',
      amount: 12,
      date: DateTime.parse('2024-01-10'),
      categoryId: 5,
      bankId: 1,
    ),
    Expense(
      id: 7,
      name: 'Google Storage',
      amount: 8,
      date: DateTime.parse('2024-01-10'),
      categoryId: 6,
      bankId: 1,
    ),
  ];

  // functions expenses
  void addExpense(Expense expense) {
    setState(() {
      _expenses.add(expense);
    });

    setState(() {
      _expenses.sort((a, b) => b.date.compareTo(a.date));
    });
  }

  void deleteExpense(int id) {
    setState(() {
      _expenses.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<BankStore>(
          create: (_) => BankStore(),
        ),
        Provider<CategoryStore>(
          create: (_) => CategoryStore(),
        ),
        Provider<IncomeStore>(create: (_) => IncomeStore()),
      ],
      child: MaterialApp(
        title: 'My finance app',
        initialRoute: '/',
        routes: {
          AppRoutes.DEFAULT: (ctx) => TabsScreen(
                expenses: _expenses
              ),
          AppRoutes.HOME: (ctx) =>
              HomeScreen(expenses: _expenses),
          AppRoutes.EXPENSES: (ctx) => ExpensesScreen(
                expenses: _expenses,
                onAddExpense: addExpense,
                onRemoveExpense: deleteExpense,
              ),
        },
      ),
    );
  }
}
