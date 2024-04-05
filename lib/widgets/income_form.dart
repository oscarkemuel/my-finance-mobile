import 'package:flutter/material.dart';
import 'package:my_finance/models/income.dart';

class IncomeForm extends StatefulWidget {
  final void Function(Income income) onSubmit;

  const IncomeForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<IncomeForm> createState() => _IncomeFormState();
}

class _IncomeFormState extends State<IncomeForm> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();

  void _submit() {
    final name = _nameController.text;
    final double amount;

    try {
      amount = double.parse(_amountController.text);
    } catch (e) {
      return;
    }

    final income = Income(
      id: DateTime.now().millisecondsSinceEpoch,
      name: name,
      amount: amount,
      date: DateTime.now(),
    );

    widget.onSubmit(income);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              hintText: 'Nome da receita',
              labelText: 'Nome',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _amountController,
            decoration: const InputDecoration(
              hintText: 'Valor recebido',
              labelText: 'Valor',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submit,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('Adicionar receita'),
          ),
        ],
      ),
    );
  }
}
