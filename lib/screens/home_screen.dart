import 'package:flutter/material.dart';
import 'package:my_finance/models/bank.dart';
import 'package:my_finance/models/category.dart';
import 'package:my_finance/models/expense.dart';
import 'package:my_finance/models/income.dart';
import 'package:my_finance/widgets/bank_list.dart';
import 'package:my_finance/widgets/expense_list.dart';
import 'package:my_finance/utils/app_routes.dart'; // Certifique-se de que este import esteja correto.

class HomeScreen extends StatefulWidget {
  final List<Income> incomes;
  final List<Expense> expenses;
  final List<Bank> banks;
  final List<Category> categories;

  const HomeScreen({
    super.key,
    required this.incomes,
    required this.expenses,
    required this.banks,
    required this.categories,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _navigateAndDisplayExpenses(BuildContext context) async {
    await Navigator.pushNamed(context, AppRoutes.EXPENSES);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final totalIncome = widget.incomes.fold(0.0, (sum, item) => sum + item.amount);
    final totalExpense = widget.expenses.fold(0.0, (sum, item) => sum + item.amount);
    final netBalance = totalIncome - totalExpense;

    widget.expenses.sort((a, b) => b.date.compareTo(a.date));

    return Scaffold(
      appBar: AppBar(
        title: const Text('My finance'),
        titleTextStyle: const TextStyle(color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: netBalance >= 0 ? Colors.green[100] : Colors.red[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Saldo líquido', style: TextStyle(fontSize: 10)),
                          Text('R\$${netBalance.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Receita total', style: TextStyle(fontSize: 10)),
                          Text('R\$${totalIncome.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text('Últimas despesas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ElevatedButton(
                  onPressed: () => _navigateAndDisplayExpenses(context),
                  child: const Text('Gerenciar'),
                ),
              ],
            ),
            ExpenseList(
              expenses: widget.expenses,
              categories: widget.categories,
              displayCount: 4,
              isHome: true,
              banks: widget.banks,
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [const Text('Bancos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),],
            ),
            BankList(banks: widget.banks, isHome: true),
          ],
        ),
      ),
    );
  }
}
