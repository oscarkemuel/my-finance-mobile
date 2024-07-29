import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_finance/models/income.dart';
import 'package:intl/intl.dart';
import 'package:my_finance/stores/income.store.dart';
import 'package:provider/provider.dart';

class IncomeList extends StatelessWidget {
  final bool? isHome;
  final Function(Income income)? onTap;

  const IncomeList({
    super.key,
    this.isHome,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final incomeStore = Provider.of<IncomeStore>(context);

    return Observer(builder: (_) {
      if (incomeStore.incomes.isEmpty) {
        return const Center(
          child: Text("Nenhuma receita cadastrada.",
              style: TextStyle(fontSize: 18)),
        );
      }

      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListView.separated(
          shrinkWrap: true,
          physics: isHome == true
              ? const NeverScrollableScrollPhysics()
              : const AlwaysScrollableScrollPhysics(),
          itemCount: incomeStore.incomes.length,
          itemBuilder: (context, index) {
            final income = incomeStore.incomes[index];
            return GestureDetector(
              onTap: onTap != null ? () => onTap!(income) : null,
              child: Card(
                elevation: 4,
                color: Colors.teal[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.attach_money,
                        color: Colors.white,
                        size: 40,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              income.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              NumberFormat.currency(
                                      locale: 'pt_BR', symbol: 'R\$')
                                  .format(income.amount),
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            DateFormat('dd/MM/yyyy').format(income.date),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
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
