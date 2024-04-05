import 'package:flutter/material.dart';
import 'package:my_finance/models/bank.dart';
import 'package:my_finance/widgets/bank_form.dart';
import 'package:my_finance/widgets/bank_list.dart';

class BanksScreen extends StatefulWidget {
  final List<Bank> banks;
  final Function(Bank) onAddBank;
  final Function(int) onRemoveBank;

  const BanksScreen({
    super.key,
    required this.banks,
    required this.onAddBank,
    required this.onRemoveBank,
  });

  @override
  State<BanksScreen> createState() => _BanksScreenState();
}

class _BanksScreenState extends State<BanksScreen> {
  void _openBankFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return BankForm(
          onSubmit: (bank) {
            widget.onAddBank(bank);
            setState(() {});
          },
        );
      },
    );
  }

  void _openModalToDeleteBank(BuildContext context, Bank bank) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Excluir banco'),
          content: const Text('Deseja realmente excluir este banco?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                widget.onRemoveBank(bank.id);
                Navigator.of(context).pop();
                setState(() {});
              },
              child: const Text('Excluir'),
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
        title: const Text('Bancos'),
        titleTextStyle: const TextStyle(color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            BankList(
              banks: widget.banks,
              onTap: (bank) => _openModalToDeleteBank(context, bank),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openBankFormModal(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

