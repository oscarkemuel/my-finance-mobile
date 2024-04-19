import 'package:flutter/material.dart';
import 'package:my_finance/screens/expenses_screen.dart';
import 'package:my_finance/screens/home_screen.dart';
import 'package:my_finance/screens/tabs_screen.dart';
import 'package:my_finance/stores/bank.store.dart';
import 'package:my_finance/stores/category.store.dart';
import 'package:my_finance/stores/expense.store.dart';
import 'package:my_finance/stores/income.store.dart';
import 'package:my_finance/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
