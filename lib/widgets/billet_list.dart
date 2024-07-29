import 'package:flutter/material.dart';
import 'package:my_finance/models/billet.dart';
import 'package:intl/intl.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_finance/stores/billet.store.dart';
import 'package:provider/provider.dart';

class BilletList extends StatelessWidget {
  final bool? isHome;
  final Function(Billet billet)? onTap;

  const BilletList({
    super.key,
    this.isHome,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final billetStore = Provider.of<BilletStore>(context);

    return Observer(builder: (_) {
      if (billetStore.billets.isEmpty) {
        return const Center(
          child:
              Text("Nenhum boleto cadastrado.", style: TextStyle(fontSize: 18)),
        );
      }

      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListView.separated(
          shrinkWrap: true,
          physics: isHome == true
              ? const NeverScrollableScrollPhysics()
              : const AlwaysScrollableScrollPhysics(),
          itemCount: billetStore.billets.length,
          itemBuilder: (context, index) {
            final billet = billetStore.billets[index];
            return Card(
              elevation: 2,
              color: Colors.white70,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                leading: const Icon(Icons.qr_code, color: Colors.blueGrey),
                title: Text(
                  billet.company,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      'Valor: ${NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(billet.amount)}',
                      style: const TextStyle(color: Colors.black87),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Vencimento: ${DateFormat('dd/MM/yyyy').format(billet.dueDate)}',
                      style: const TextStyle(color: Colors.black87),
                    ),
                  ],
                ),
                trailing: const Icon(
                  Icons.receipt,
                  color: Colors.blueGrey,
                  size: 55,
                ),
                onTap: onTap == null
                    ? null
                    : () {
                        onTap!(billet);
                      },
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10),
        ),
      );
    });
  }
}
