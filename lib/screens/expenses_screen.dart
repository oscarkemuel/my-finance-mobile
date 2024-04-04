import 'package:flutter/material.dart';
import 'package:my_finance/models/bank.dart';
import 'package:my_finance/models/category.dart';
import 'package:my_finance/models/expense.dart';
import 'package:my_finance/widgets/expense_list.dart';

class ExpensesScreen extends StatelessWidget {
  final List<Expense> expenses;
  final List<Bank> banks;
  final List<Category> categories;
  final void Function(Expense) onAddExpense;
  final void Function(int id) onRemoveExpense;

  const ExpensesScreen({
    super.key,
    required this.expenses,
    required this.banks,
    required this.categories,
    required this.onAddExpense,
    required this.onRemoveExpense,
  });

  @override
  Widget build(BuildContext context) {
    _openExpenseFormModal(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (_) {
          // TODO: implementar o ExpenseForm
          // return ExpenseForm(
          //   banks: banks,
          //   categories: categories,
          //   onSubmit: onAddExpense,
          // );
          return Container();
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas'),
        titleTextStyle: const TextStyle(color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Despesas',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                    onPressed: () => _openExpenseFormModal(context),
                    child: const Icon(
                      Icons.add,
                    )),
              ],
            ),
            const SizedBox(height: 10),
            ExpenseList(
              expenses: expenses,
              categories: categories,
            ),
          ],
        ),
      ),
    );
  }
}
