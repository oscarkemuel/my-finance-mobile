import 'package:flutter/material.dart';
import 'package:my_finance/models/billet.dart';
import 'package:my_finance/stores/billet.store.dart';
import 'package:my_finance/widgets/billet_form.dart';
import 'package:my_finance/widgets/billet_list.dart';
import 'package:provider/provider.dart';

class BilletsScreen extends StatefulWidget {
  const BilletsScreen({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _BilletsScreenState createState() => _BilletsScreenState();
}

class _BilletsScreenState extends State<BilletsScreen> {
  void _openBilletFormModal(BuildContext context, [Billet? billet]) {
    final billetStore = Provider.of<BilletStore>(context, listen: false);

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return BilletForm(
          billet: billet,
          onSubmit: (billet) {
            billetStore.addBillet(billet);
            Navigator.of(context).pop();
          },
          onDelete: (billet) {
            billetStore.removeBillet(billet);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boletos'),
        titleTextStyle: const TextStyle(color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Boletos',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BilletList(
              onTap: (bank) => _openBilletFormModal(context, bank),
            ),
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openBilletFormModal(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
