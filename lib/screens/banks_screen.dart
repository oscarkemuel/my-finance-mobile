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

  void _openBankFormModal(BuildContext context, [Bank? bank]) {
    final bankStore = Provider.of<BankStore>(context, listen: false);

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        final double screenHeight = MediaQuery.of(context).size.height;
        final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        final double height = (screenHeight - keyboardHeight) * 0.7;

        return SizedBox(
          height: height,
          child: BankForm(
            bank: bank,
            onSubmit: (bank) {
              bankStore.addBank(bank);
              Navigator.of(context).pop();
            },
            onDelete: (bank) {
              bankStore.removeBank(bank);
            },
          ),
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
              onTap: (bank) => _openBankFormModal(context, bank),
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
