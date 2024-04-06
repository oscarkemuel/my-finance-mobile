import 'package:flutter/material.dart';
import 'package:my_finance/models/income.dart';
import 'package:intl/intl.dart';

class IncomeList extends StatelessWidget {
  final List<Income> incomes;
  final bool? isHome;
  final Function(Income income)? onTap;

  const IncomeList({
    super.key,
    required this.incomes,
    this.isHome,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (incomes.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text("Nenhuma receita cadastrada.", style: TextStyle(fontSize: 16)),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.separated(
        shrinkWrap: true,
        physics: isHome == true
            ? const NeverScrollableScrollPhysics()
            : const AlwaysScrollableScrollPhysics(),
        itemCount: incomes.length,
        itemBuilder: (context, index) {
          final income = incomes[index];
          return Card(
            elevation: 2,
            color: Colors.green[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              title: Text(income.name),
              titleTextStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
                        .format(income.amount),
                  ),
                  const SizedBox(width: 8),
                  Text(DateFormat('dd/MM/yyyy').format(income.date)),
                ],
              ),
              onTap: onTap != null ? () => onTap!(income) : null,
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
      ),
    );
  }
}
