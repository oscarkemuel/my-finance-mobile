import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_finance/stores/expense.store.dart';
import 'package:my_finance/stores/income.store.dart';
import 'package:my_finance/widgets/bank_list.dart';
import 'package:my_finance/widgets/expense_list.dart';
import 'package:my_finance/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  void _navigateAndDisplayExpenses(BuildContext context) async {
    await Navigator.pushNamed(context, AppRoutes.EXPENSES);
  }

  @override
  Widget build(BuildContext context) {
    final incomeStore = Provider.of<IncomeStore>(context);
    final expenseStore = Provider.of<ExpenseStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Finance'),
        titleTextStyle: const TextStyle(color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Observer(builder: (_) {
                    final netBalance =
                        incomeStore.totalAmount - expenseStore.totalAmount;

                    final colorByNetBalance =
                        netBalance <= 0 ? Colors.red[600] : Colors.black;

                    return Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Saldo líquido',
                                style: TextStyle(fontSize: 10)),
                            Text(
                                NumberFormat.currency(
                                        locale: 'pt_BR', symbol: 'R\$')
                                    .format(netBalance),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: colorByNetBalance)),
                          ],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Receita total',
                              style: TextStyle(fontSize: 10)),
                          Observer(builder: (_) {
                            return Text(
                                NumberFormat.currency(
                                        locale: 'pt_BR', symbol: 'R\$')
                                    .format(incomeStore.totalAmount),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16));
                          })
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Observer(builder: (_) {
              final expensePercentage = incomeStore.totalAmount > 0
                  ? (expenseStore.totalAmount / incomeStore.totalAmount) * 100
                  : 0;
              final roundedExpensePercentage =
                  double.parse(expensePercentage.toStringAsFixed(2)) < 0
                      ? 0.0
                      : double.parse(expensePercentage.toStringAsFixed(2));
              final roundedRemainingPercentage =
                  double.parse((100 - expensePercentage).toStringAsFixed(2)) < 0
                      ? 0.0
                      : double.parse(
                          (100 - expensePercentage).toStringAsFixed(2));

              return SfCircularChart(
                legend: Legend(
                  isVisible: true,
                  overflowMode: LegendItemOverflowMode.wrap,
                  position: LegendPosition.bottom,
                ),
                series: <DoughnutSeries>[
                  DoughnutSeries<ChartData, String>(
                    dataSource: [
                      ChartData('Usado', roundedExpensePercentage),
                      ChartData('Restante', roundedRemainingPercentage),
                    ],
                    xValueMapper: (ChartData data, _) => data.category,
                    yValueMapper: (ChartData data, _) => data.value,
                    dataLabelMapper: (ChartData data, _) => '${data.value}%',
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      labelPosition: ChartDataLabelPosition.inside,
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold),
                    ),
                    enableTooltip: true,
                    radius: '85%',
                    innerRadius: '50%',
                    pointColorMapper: (ChartData data, _) =>
                        data.category == 'Usado'
                            ? Colors.red[300]
                            : Colors.green[300],
                  ),
                ],
              );
            }),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text('Últimas despesas',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ElevatedButton(
                  onPressed: () => _navigateAndDisplayExpenses(context),
                  child: const Text('Gerenciar'),
                ),
              ],
            ),
            const ExpenseList(
              displayCount: 4,
              isHome: true,
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Bancos',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const BankList(isHome: true),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.category, this.value);

  final String category;
  final double value;
}
