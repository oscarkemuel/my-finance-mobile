import 'package:flutter/material.dart';
import 'package:my_finance/models/income.dart';
import 'package:my_finance/widgets/income_form.dart';
import 'package:my_finance/widgets/income_list.dart';

class IncomesScreen extends StatefulWidget {
  final List<Income> incomes;
  final Function(Income) onAddIncome;
  final Function(int) onRemoveIncome;

  const IncomesScreen({
    super.key,
    required this.incomes,
    required this.onAddIncome,
    required this.onRemoveIncome,
  });

  @override
  State<IncomesScreen> createState() => _IncomesScreenState();
}

class _IncomesScreenState extends State<IncomesScreen> {
  void _openIncomeFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return IncomeForm(
          onSubmit: (income) {
            widget.onAddIncome(income);
            setState(() {});
          },
        );
      },
    );
  }

  void _openModalToDeleteIncome(BuildContext context, Income income) {
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
                widget.onRemoveIncome(income.id);
                Navigator.of(context).pop();
                setState(() {});
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
                incomes: widget.incomes,
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
