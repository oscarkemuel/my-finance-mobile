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
    Category(id: 6, name: 'Serviços', icon: Icons.settings),
    Category(id: 7, name: 'Outros', icon: Icons.more_horiz),
  ];

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

  final _incomes = [
    Income(
      id: 1,
      name: 'Salário',
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

    setState(() {
      _expenses.sort((a, b) => b.date.compareTo(a.date));
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

  // function incomes
  void addIncome(Income income) {
    setState(() {
      _incomes.add(income);
    });
  }

  void deleteIncome(int id) {
    setState(() {
      _incomes.removeWhere((element) => element.id == id);
    });
  }

  // function categories
  void addCategory(Category category) {
    setState(() {
      _categories.add(category);
    });
  }

  void deleteCategory(int id) {
    setState(() {
      _categories.removeWhere((element) => element.id == id);
    });

    setState(() {
      for (var element in _expenses) {
        if (element.categoryId == id) {
          element.categoryId = 0;
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
              onAddIncome: addIncome,
              onRemoveIncome: deleteIncome,
              onAddCategory: addCategory,
              onRemoveCategory: deleteCategory,
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
