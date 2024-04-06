import 'package:flutter/material.dart';
import 'package:my_finance/models/bank.dart';
import 'package:intl/intl.dart';

class BankList extends StatelessWidget {
  final List<Bank> banks;
  final bool? isHome;
  final Function(Bank bank)? onTap;

  const BankList({
    super.key,
    required this.banks,
    this.isHome,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (banks.isEmpty || banks.length == 1) {
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
        itemCount: banks.length - 1,
        itemBuilder: (context, index) {
          final bank = banks[index + 1];
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
              onTap: onTap != null ? () => onTap!(bank) : null,
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
      ),
    );
  }
}
