import 'package:flutter/material.dart';
import 'package:my_finance/models/bank.dart';
import 'package:my_finance/models/expense.dart';
import 'package:my_finance/models/category.dart';
import 'package:intl/intl.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;
  final List<Category> categories;
  final List<Bank> banks;
  final int? displayCount;
  final bool? isHome;
  final Function(Expense expense)? onTap;

  const ExpenseList({
    super.key,
    required this.expenses,
    required this.categories,
    required this.banks,
    this.displayCount,
    this.isHome,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    List<Expense> displayedExpenses =
        displayCount != null ? expenses.take(displayCount!).toList() : expenses;

    if (displayedExpenses.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child:
            Text("Nenhuma despesa registrada.", style: TextStyle(fontSize: 16)),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.separated(
        shrinkWrap: true,
        physics: displayCount != null || isHome == true
            ? const NeverScrollableScrollPhysics()
            : const AlwaysScrollableScrollPhysics(),
        itemCount: displayedExpenses.length,
        itemBuilder: (context, index) {
          final expense = displayedExpenses[index];
          final category =
              categories.firstWhere((cat) => cat.id == expense.categoryId);
          return Card(
            elevation: 2,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              leading: Icon(category.icon),
              title: Text(expense.name),
              subtitle: Text(DateFormat('dd/MM/yyyy').format(expense.date)),
              trailing: Text('R\$${expense.amount.toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.red)),
              onTap: onTap == null
                  ? null
                  : () {
                      onTap!(expense);
                    },
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
      ),
    );
  }
}
