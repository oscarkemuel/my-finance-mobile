import 'package:flutter/material.dart';
import 'package:my_finance/models/expense.dart';
import 'package:my_finance/stores/income.store.dart';
import 'package:my_finance/widgets/bank_list.dart';
import 'package:my_finance/widgets/expense_list.dart';
import 'package:my_finance/utils/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  final List<Expense> expenses;

  const HomeScreen({
    super.key,
    required this.expenses,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _navigateAndDisplayExpenses(BuildContext context) async {
    await Navigator.pushNamed(context, AppRoutes.EXPENSES);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
  final incomeStore = Provider.of<IncomeStore>(context);

    final totalIncome =
        incomeStore.incomes.fold(0.0, (sum, item) => sum + item.amount);
    final totalExpense =
        widget.expenses.fold(0.0, (sum, item) => sum + item.amount);
    final netBalance = totalIncome - totalExpense;
    final expensePercentage =
        totalIncome > 0 ? (totalExpense / totalIncome) * 100 : 0;
    final roundedExpensePercentage =
        double.parse(expensePercentage.toStringAsFixed(2));
    final roundedRemainingPercentage =
        double.parse((100 - expensePercentage).toStringAsFixed(2));

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
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: netBalance >= 0
                            ? Colors.green[100]
                            : Colors.red[100],
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
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Receita total',
                              style: TextStyle(fontSize: 10)),
                          Text(
                              NumberFormat.currency(
                                      locale: 'pt_BR', symbol: 'R\$')
                                  .format(totalIncome),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SfCircularChart(
              legend: Legend(
                isVisible: true,
                overflowMode: LegendItemOverflowMode.wrap,
                position: LegendPosition.bottom,
              ),
              series: <DoughnutSeries>[
                DoughnutSeries<ChartData, String>(
                  dataSource: [
                    ChartData('Usado', roundedExpensePercentage),
                    ChartData('Receita total', roundedRemainingPercentage),
                  ],
                  xValueMapper: (ChartData data, _) => data.category,
                  yValueMapper: (ChartData data, _) => data.value,
                  dataLabelMapper: (ChartData data, _) => '${data.value}%',
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    labelPosition: ChartDataLabelPosition.inside,
                    textStyle: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                  enableTooltip: true,
                  radius: '85%',
                  innerRadius: '50%',
                ),
              ],
            ),
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
            ExpenseList(
              expenses: widget.expenses,
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
