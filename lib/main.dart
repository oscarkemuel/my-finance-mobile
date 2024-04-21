import 'package:flutter/material.dart';
import 'package:my_finance/daos/bank_dao.dart';
import 'package:my_finance/daos/category_dao.dart';
import 'package:my_finance/database/db.dart';
import 'package:my_finance/screens/expenses_screen.dart';
import 'package:my_finance/screens/home_screen.dart';
import 'package:my_finance/screens/tabs_screen.dart';
import 'package:my_finance/stores/bank.store.dart';
import 'package:my_finance/stores/category.store.dart';
import 'package:my_finance/stores/expense.store.dart';
import 'package:my_finance/stores/income.store.dart';
import 'package:my_finance/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await DB.instance.database;
  runApp(MyApp(db: db));
}

class MyApp extends StatelessWidget {
  final Database db;

  const MyApp({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    final bankDao = BankDao(db);
    final categoryDao = CategoryDao(db);

    return MultiProvider(
      providers: [
        Provider<BankStore>(
          create: (_) => BankStore(bankDao),
        ),
        Provider<CategoryStore>(
          create: (_) => CategoryStore(categoryDao),
        ),
        Provider<IncomeStore>(create: (_) => IncomeStore()),
        Provider<ExpenseStore>(create: (_) => ExpenseStore()),
      ],
      child: MaterialApp(
        title: 'My finance app',
        initialRoute: '/',
        routes: {
          AppRoutes.DEFAULT: (ctx) => const TabsScreen(),
          AppRoutes.HOME: (ctx) => const HomeScreen(),
          AppRoutes.EXPENSES: (ctx) => const ExpensesScreen(),
        },
      ),
    );
  }
}
