import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_finance/models/bank.dart';
import 'package:my_finance/stores/bank_form.store.dart';

class BankForm extends StatelessWidget {
  final void Function(Bank bank) onSubmit;

  const BankForm({
    super.key,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final store = BankFormStore();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Observer(
            builder: (_) => TextField(
              onChanged: (value) => store.name = value,
              decoration: const InputDecoration(
                hintText: 'Nome do banco',
                labelText: 'Nome',
              ),
            ),
          ),
          const SizedBox(height: 16),
          Observer(
            builder: (_) => TextField(
              onChanged: (value) => store.balance = value,
              decoration: const InputDecoration(
                hintText: 'Crédito',
                labelText: 'Crédito',
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
          ),
          const SizedBox(height: 20),
          Observer(
            builder: (_) => ElevatedButton(
              onPressed: store.canSubmit
                  ? () {
                      final bank = store.submit();
                      onSubmit(bank);
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Adicionar banco'),
            ),
          ),
        ],
      ),
    );
  }
}
