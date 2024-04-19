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

  void _openIncomeFormModal(BuildContext context) {
    final incomeStore = Provider.of<IncomeStore>(context, listen: false);

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return IncomeForm(
          onSubmit: (income) {
            incomeStore.addIncome(income);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void _openModalToDeleteIncome(BuildContext context, Income income) {
    final incomeStore = Provider.of<IncomeStore>(context, listen: false);

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Excluir "${income.name}"'),
          titleTextStyle: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          content: const Text('Deseja realmente excluir esta receita?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                incomeStore.removeIncome(income);
                Navigator.of(context).pop();
              },
              child: const Text('Excluir', style: TextStyle(color: Colors.red)),
            ),
          ],
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
                onTap: (income) => _openModalToDeleteIncome(context, income),
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
