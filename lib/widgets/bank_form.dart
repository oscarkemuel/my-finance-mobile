import 'package:flutter/material.dart';
import 'package:my_finance/models/bank.dart';

class BankForm extends StatefulWidget {
  final void Function(Bank bank) onSubmit;
  final void Function(Bank bank)? onDelete;
  final Bank? bank;

  const BankForm({
    super.key,
    required this.onSubmit,
    this.onDelete,
    this.bank,
  });

  @override
  State<BankForm> createState() => _BankFormState();
}

class _BankFormState extends State<BankForm> {
  final _nameController = TextEditingController();
  final _balanceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.bank != null) {
      _nameController.text = widget.bank!.name;
      _balanceController.text = widget.bank!.balance.toString();
    }
  }

  void _submit() {
    final name = _nameController.text;
    final double balance;

    try {
      balance = double.parse(_balanceController.text);
    } catch (e) {
      return;
    }

    final bank = Bank(
      id: widget.bank?.id ?? DateTime.now().millisecondsSinceEpoch,
      name: name,
      balance: balance,
    );

    widget.onSubmit(bank);
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
              hintText: 'Crédito',
              labelText: 'Crédito',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _submit(),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: Text(
                widget.bank == null ? 'Adicionar banco' : 'Atualizar banco'),
          ),
          if (widget.bank != null) ...[
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (widget.onDelete != null) {
                  widget.onDelete!(widget.bank!);
                }
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Excluir banco'),
            ),
          ],
        ],
      ),
    );
  }
}
