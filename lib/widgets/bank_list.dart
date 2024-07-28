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
      if (bankStore.banks.isEmpty) {
        return const Padding(
          padding: EdgeInsets.all(16),
          child: Text("Nenhum banco cadastrado.",
              style: TextStyle(fontSize: 16, color: Colors.white)),
        );
      }

      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListView.separated(
          shrinkWrap: true,
          physics: isHome == true
              ? const NeverScrollableScrollPhysics()
              : const AlwaysScrollableScrollPhysics(),
          itemCount: bankStore.banks.length,
          itemBuilder: (context, index) {
            final bank = bankStore.banks[index];
            return GestureDetector(
              onTap: onTap == null ? null : () => onTap!(bank),
              child: Card(
                elevation: 4,
                color: Colors.grey[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.credit_card,
                            color: Colors.white,
                            size: 24,
                          ),
                          SizedBox(height: 8),
                          Text(
                            '**** **** **** ****',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            bank.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            NumberFormat.currency(
                                    locale: 'pt_BR', symbol: 'R\$')
                                .format(bank.balance),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10),
        ),
      );
    });
  }
}
