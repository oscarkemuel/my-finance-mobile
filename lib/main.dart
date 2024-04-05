import 'package:flutter/material.dart';
import 'package:my_finance/models/bank.dart';
import 'package:my_finance/models/category.dart';
import 'package:my_finance/models/expense.dart';
import 'package:my_finance/models/income.dart';
import 'package:my_finance/screens/expenses_screen.dart';
import 'package:my_finance/screens/home_screen.dart';
import 'package:my_finance/screens/tabs_screen.dart';
import 'package:my_finance/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _banks = [
    Bank(name: 'Desconhecido', balance: 0, id: 0),
    Bank(name: 'Nubank', balance: 5000, id: 1),
    Bank(name: 'Inter', balance: 2000, id: 2),
  ];

  final _categories = [
    Category(id: 0, name: 'Desconhecida', icon: Icons.help),
    Category(id: 1, name: 'Comida', icon: Icons.food_bank),
    Category(id: 2, name: 'Transporte', icon: Icons.directions_bus),
    Category(id: 3, name: 'Saúde', icon: Icons.local_hospital),
    Category(id: 4, name: 'Educação', icon: Icons.school),
    Category(id: 5, name: 'Entretenimento', icon: Icons.movie),
    Category(id: 6, name: 'Outros', icon: Icons.more_horiz),
  ];

  final _expenses = [
    Expense(
      id: 1,
      name: 'Pizzaria',
      amount: 50,
      date: DateTime.parse('2021-09-01'),
      categoryId: 1,
      bankId: 1,
    ),
    Expense(
      id: 2,
      name: 'Onibus mensal',
      amount: 5,
      date: DateTime.now(),
      categoryId: 2,
      bankId: 2,
    ),
    Expense(
      id: 3,
      name: 'Consuta ao oftalmologista',
      amount: 100,
      date: DateTime.now(),
      categoryId: 3,
      bankId: 1,
    ),
    Expense(
      id: 4,
      name: 'Livro',
      amount: 30,
      date: DateTime.now(),
      categoryId: 4,
      bankId: 2,
    ),
    Expense(
      id: 5,
      name: 'Cinema',
      amount: 20,
      date: DateTime.now(),
      categoryId: 5,
      bankId: 1,
    ),
    Expense(
      id: 6,
      name: 'Outros',
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
      amount: 3250,
      date: DateTime.now(),
    ),
    Income(
      id: 2,
      name: 'Freelancer',
      amount: 500,
      date: DateTime.now(),
    ),
  ];

  // functions expenses
  void addExpense(Expense expense) {
    setState(() {
      _expenses.add(expense);
    });
  }

  void deleteExpense(int id) {
    setState(() {
      _expenses.removeWhere((element) => element.id == id);
    });
  }

  // functions banks
  void addBank(Bank bank) {
    setState(() {
      _banks.add(bank);
    });
  }

  void deleteBank(int id) {
    setState(() {
      _banks.removeWhere((element) => element.id == id);
    });

    setState(() {
      for (var element in _expenses) {
        if (element.bankId == id) {
          element.bankId = 0;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My finance app',
      initialRoute: '/',
      routes: {
        AppRoutes.DEFAULT: (ctx) => TabsScreen(
              incomes: _incomes,
              expenses: _expenses,
              banks: _banks,
              categories: _categories,
              onAddBank: addBank,
              onRemoveBank: deleteBank,
            ),
        AppRoutes.HOME: (ctx) => HomeScreen(
            incomes: _incomes,
            expenses: _expenses,
            banks: _banks,
            categories: _categories),
        AppRoutes.EXPENSES: (ctx) => ExpensesScreen(
              expenses: _expenses,
              banks: _banks,
              categories: _categories,
              onAddExpense: addExpense,
              onRemoveExpense: deleteExpense,
            ),
      },
    );
  }
}
