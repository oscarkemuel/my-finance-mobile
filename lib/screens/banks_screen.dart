import 'package:flutter/material.dart';
import 'package:my_finance/models/bank.dart';
import 'package:my_finance/stores/bank.store.dart';
import 'package:my_finance/widgets/bank_form.dart';
import 'package:my_finance/widgets/bank_list.dart';
import 'package:provider/provider.dart';

class BanksScreen extends StatelessWidget {
  const BanksScreen({
    super.key,
  });

  void _openBankFormModal(BuildContext context) {
    final bankStore = Provider.of<BankStore>(context, listen: false);

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return BankForm(
          onSubmit: (bank) {
            bankStore.addBank(bank);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void _openModalToDeleteBank(BuildContext context, Bank bank) {
    final bankStore = Provider.of<BankStore>(context, listen: false);

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Excluir "${bank.name}"'),
          titleTextStyle: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          content: const Text('Deseja realmente excluir este banco?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
                onPressed: () {
                  bankStore.removeBank(bank);
                  Navigator.of(context).pop();
                },
                child:
                    const Text('Excluir', style: TextStyle(color: Colors.red))),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bancos'),
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
                'Bancos',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BankList(
              onTap: (bank) => _openModalToDeleteBank(context, bank),
            ),
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openBankFormModal(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
