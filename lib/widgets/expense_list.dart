import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_finance/models/expense.dart';
import 'package:intl/intl.dart';
import 'package:my_finance/stores/category.store.dart';
import 'package:my_finance/stores/expense.store.dart';
import 'package:provider/provider.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense>? expenses;
  final int? displayCount;
  final bool? isHome;
  final Function(Expense expense)? onTap;

  const ExpenseList({
    super.key,
    this.expenses,
    this.displayCount,
    this.isHome,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final categoryStore = Provider.of<CategoryStore>(context);
    final expenseStore = Provider.of<ExpenseStore>(context);

    return Observer(builder: (_) {
      List<Expense> displayedExpenses = displayCount != null
          ? expenseStore.expenses.take(displayCount!).toList()
          : expenseStore.expenses;

      if (expenses != null) {
        displayedExpenses = expenses!;
      }

      if (displayedExpenses.isEmpty) {
        return const Padding(
          padding: EdgeInsets.all(16),
          child: Text("Nenhuma despesa registrada.",
              style: TextStyle(fontSize: 16)),
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
            final category = categoryStore.categories
                .firstWhere((c) => c.id == expense.categoryId, orElse: () {
              return categoryStore.categories.first;
            });
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
                trailing: Text(
                  NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
                      .format(expense.amount),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black45,
                  ),
                ),
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
    });
  }
}
