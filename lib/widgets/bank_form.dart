import 'package:flutter/material.dart';
import 'package:my_finance/models/bank.dart';

class BankForm extends StatefulWidget {
  final void Function(Bank bank) onSubmit;

  const BankForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<BankForm> createState() => _BankFormState();
}

class _BankFormState extends State<BankForm> {
  final _nameController = TextEditingController();
  final _balanceController = TextEditingController();

  void _submit() {
    final name = _nameController.text;
    final double balance;

    try {
      balance = double.parse(_balanceController.text);
    } catch (e) {
      return;
    }

    final bank = Bank(
      id: DateTime.now().millisecondsSinceEpoch,
      name: name,
      balance: balance,
    );

    widget.onSubmit(bank);

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
              hintText: 'Nome do banco',
              labelText: 'Nome',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _balanceController,
            decoration: const InputDecoration(
              hintText: 'Saldo inicial',
              labelText: 'Saldo',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _submit(),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('Adicionar banco'),
          ),
        ],
      ),
    );
  }
}
