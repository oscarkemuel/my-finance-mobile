import 'package:flutter/material.dart';
import 'package:my_finance/models/bank.dart';

class BankList extends StatelessWidget {
  final List<Bank> banks;
  final bool? isHome;

  const BankList({super.key, required this.banks, this.isHome});

  @override
  Widget build(BuildContext context) {
    // Verifica se a lista de bancos está vazia ou tem apenas um elemento
    if (banks.isEmpty || banks.length == 1) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
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
        itemCount: banks.length - 1, // Ajusta o itemCount para excluir o primeiro elemento
        itemBuilder: (context, index) {
          // Ajusta o índice para começar do segundo item da lista
          final bank = banks[index + 1];
          return Card(
            elevation: 2,
            color: Colors.deepPurple[50],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              title: Text(bank.name),
              subtitle: Text('Limite: R\$${bank.balance.toStringAsFixed(2)}'),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
      ),
    );
  }
}
