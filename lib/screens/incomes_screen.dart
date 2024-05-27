import 'package:flutter/material.dart';
import 'package:my_finance/models/income.dart';
import 'package:my_finance/stores/income.store.dart';
import 'package:my_finance/widgets/income_form.dart';
import 'package:my_finance/widgets/income_list.dart';
import 'package:provider/provider.dart';

class IncomesScreen extends StatelessWidget {
  const IncomesScreen({
    super.key,
  });

  void _openIncomeFormModal(BuildContext context, [Income? income]) {
    final incomeStore = Provider.of<IncomeStore>(context, listen: false);

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return IncomeForm(
          income: income,
          onSubmit: (income) {
            incomeStore.addIncome(income);
            Navigator.of(context).pop();
          },
          onDelete: (income) {
            incomeStore.removeIncome(income);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receitas'),
        titleTextStyle: const TextStyle(color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Receitas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: IncomeList(
                onTap: (income) => _openIncomeFormModal(context, income),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openIncomeFormModal(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
