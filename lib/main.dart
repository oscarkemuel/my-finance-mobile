import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:my_finance/daos/bank_dao.dart';
import 'package:my_finance/daos/billet_dao.dart';
import 'package:my_finance/daos/category_dao.dart';
import 'package:my_finance/daos/expense_dao.dart';
import 'package:my_finance/daos/income_dao.dart';
import 'package:my_finance/screens/billets_screen.dart';
import 'package:my_finance/database/db.dart';
import 'package:my_finance/screens/expenses_screen.dart';
import 'package:my_finance/screens/home_screen.dart';
import 'package:my_finance/screens/tabs_screen.dart';
import 'package:my_finance/services/local_auth_service.dart';
import 'package:my_finance/stores/bank.store.dart';
import 'package:my_finance/stores/billet.store.dart';
import 'package:my_finance/stores/category.store.dart';
import 'package:my_finance/stores/expense.store.dart';
import 'package:my_finance/stores/income.store.dart';
import 'package:my_finance/utils/app_routes.dart';
import 'package:my_finance/widgets/auth_check.dart';
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
    final incomeDao = IncomeDao(db);
    final expenseDao = ExpenseDao(db);
    final billetDao = BilletDao(db);

    final expenseStore = ExpenseStore(expenseDao);

    return MultiProvider(
      providers: [
        Provider<LocalAuthService>(
          create: (_) => LocalAuthService(auth: LocalAuthentication()),
        ),
        Provider<BankStore>(
          create: (_) => BankStore(bankDao, expenseStore),
        ),
        Provider<CategoryStore>(
          create: (_) => CategoryStore(categoryDao, expenseStore),
        ),
        Provider<IncomeStore>(create: (_) => IncomeStore(incomeDao)),
        Provider<ExpenseStore>(create: (_) => expenseStore),
        Provider<BilletStore>(create: (_) => BilletStore(billetDao)),
      ],
      child: MaterialApp(
        title: 'My finance app',
        initialRoute: AppRoutes.AUTH,
        routes: {
          AppRoutes.AUTH: (ctx) => const AuthCheck(),
          AppRoutes.DEFAULT: (ctx) => const TabsScreen(),
          AppRoutes.HOME: (ctx) => const HomeScreen(),
          AppRoutes.EXPENSES: (ctx) => const ExpensesScreen(),
          AppRoutes.BILLETS: (ctx) => const BilletsScreen(),
        },
      ),
    );
  }
}
