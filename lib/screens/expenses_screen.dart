import 'package:flutter/material.dart';
import 'package:my_finance/models/category.dart';
import 'package:my_finance/models/expense.dart';
import 'package:my_finance/stores/bank.store.dart';
import 'package:my_finance/widgets/expense_form.dart';
import 'package:my_finance/widgets/expense_list.dart';
import 'package:provider/provider.dart';

class ExpensesScreen extends StatefulWidget {
  final List<Expense> expenses;
  final List<Category> categories;
  final void Function(Expense) onAddExpense;
  final void Function(int id) onRemoveExpense;

  const ExpensesScreen({
    super.key,
    required this.expenses,
    required this.categories,
    required this.onAddExpense,
    required this.onRemoveExpense,
  });

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  int? selectedBankId;
  int? selectedCategoryId;

  void onSubmitAddExpense(Expense expense) {
    widget.onAddExpense(expense);
    Navigator.of(context).pop();
  }

  openExpenseFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ExpenseForm(
          categories: widget.categories,
          onSubmit: widget.onAddExpense,
        );
      },
    );
  }

  openModalToDeleteExpense(BuildContext context, Expense expense) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Excluir "${expense.name}"'),
          titleTextStyle: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          content: const Text('Deseja realmente excluir esta despesa?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
                onPressed: () {
                  widget.onRemoveExpense(expense.id);
                  Navigator.of(context).pop();
                },
                child:
                    const Text('Excluir', style: TextStyle(color: Colors.red))),
          ],
        );
      },
    );
  }

  List<Expense> get filteredExpenses {
    return widget.expenses.where((expense) {
      final matchesBank =
          selectedBankId == null || expense.bankId == selectedBankId;
      final matchesCategory = selectedCategoryId == null ||
          expense.categoryId == selectedCategoryId;
      return matchesBank && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final bankStore = Provider.of<BankStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas'),
        titleTextStyle: const TextStyle(color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              DropdownButtonFormField<int?>(
                decoration:
                    const InputDecoration(labelText: 'Filtrar por banco'),
                value: selectedBankId,
                onChanged: (newValue) {
                  setState(() {
                    selectedBankId = newValue;
                  });
                },
                items: [
                      const DropdownMenuItem<int?>(
                          value: null,
                          child: Text(
                            'Todos',
                            style: TextStyle(fontSize: 12),
                          ))
                    ] +
                    bankStore.banks.map((bank) {
                      return DropdownMenuItem<int?>(
                          value: bank.id,
                          child: Text(
                            bank.name,
                            style: const TextStyle(fontSize: 12),
                          ));
                    }).toList(),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<int?>(
                decoration:
                    const InputDecoration(labelText: 'Filtrar por categoria'),
                value: selectedCategoryId,
                onChanged: (newValue) {
                  setState(() {
                    selectedCategoryId = newValue;
                  });
                },
                items: [
                      const DropdownMenuItem<int?>(
                          value: null,
                          child: Text(
                            'Todas',
                            style: TextStyle(fontSize: 12),
                          ))
                    ] +
                    widget.categories.map((category) {
                      return DropdownMenuItem<int?>(
                          value: category.id,
                          child: Text(
                            category.name,
                            style: const TextStyle(fontSize: 12),
                          ));
                    }).toList(),
              ),
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
                      onPressed: () => openExpenseFormModal(context),
                      child: const Icon(
                        Icons.add,
                      )),
                ],
              ),
              const SizedBox(height: 10),
              ExpenseList(
                isHome: true,
                expenses: filteredExpenses,
                categories: widget.categories,
                onTap: (expense) => openModalToDeleteExpense(context, expense),
              )
            ],
          ),
        ),
      ),
    );
  }
}
