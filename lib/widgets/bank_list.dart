import 'package:flutter/material.dart';
import 'package:my_finance/models/bank.dart';
import 'package:intl/intl.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_finance/stores/bank.store.dart';
import 'package:provider/provider.dart';

class BankList extends StatelessWidget {
  final bool? isHome;
  final Function(Bank bank)? onTap;

  const BankList({
    super.key,
    this.isHome,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bankStore = Provider.of<BankStore>(context);
    
    return Observer(builder: (_) {
      if (bankStore.banks.isEmpty || bankStore.banks.length == 1) {
        return const Padding(
          padding: EdgeInsets.all(16),
          child: Text("Nenhum banco cadastrado.", style: TextStyle(fontSize: 16)),
        );
      }

      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListView.separated(
          shrinkWrap: true,
          physics: isHome == true
              ? const NeverScrollableScrollPhysics()
              : const AlwaysScrollableScrollPhysics(),
          itemCount: bankStore.banks.length - 1,
          itemBuilder: (context, index) {
            final bank = bankStore.banks[index + 1];
            return Card(
              elevation: 2,
              color: Colors.deepPurple[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                title: Text(bank.name),
                titleTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Crédito'),
                    const SizedBox(width: 8),
                    Text(
                      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
                          .format(bank.balance),
                    ),
                  ],
                ),
                onTap: () => onTap?.call(bank),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10),
        ),
      );
    });
  }
}
