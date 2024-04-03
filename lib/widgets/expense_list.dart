import 'package:flutter/material.dart';
import 'package:my_finance/models/expense.dart';
import 'package:my_finance/models/category.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;
  final List<Category> categories;
  final int? displayCount;
  final bool? isHome;

  const ExpenseList({
    super.key,
    required this.expenses,
    required this.categories,
    this.displayCount,
    this.isHome,
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
              subtitle: Text(
                  '${expense.date.day}/${expense.date.month}/${expense.date.year}'),
              trailing: Text('R\$${expense.amount.toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.red)),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
      ),
    );
  }
}
