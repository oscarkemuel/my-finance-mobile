import 'package:flutter/material.dart';
import 'package:my_finance/models/expense.dart';
import 'package:my_finance/models/income.dart';
import 'package:my_finance/screens/banks_screen.dart';
import 'package:my_finance/screens/categories_screen.dart';
import 'package:my_finance/screens/home_screen.dart';
import 'package:my_finance/screens/incomes_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Income> incomes;
  final List<Expense> expenses;
  final Function(Income) onAddIncome;
  final Function(int) onRemoveIncome;

  const TabsScreen({
    super.key,
    required this.incomes,
    required this.expenses,
    required this.onAddIncome,
    required this.onRemoveIncome,
  });

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(
        incomes: widget.incomes,
        expenses: widget.expenses,
      ),
      IncomesScreen(
        incomes: widget.incomes,
        onAddIncome: widget.onAddIncome,
        onRemoveIncome: widget.onRemoveIncome,
      ),
      const CategoriesScreen(),
      const BanksScreen(),
    ];
  }

  _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_selectedScreenIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.attach_money), label: 'Receitas'),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categorias',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance),
              label: 'Bancos',
            ),
          ],
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.grey,
          onTap: _selectScreen,
          currentIndex: _selectedScreenIndex,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          showUnselectedLabels: true,
        ));
  }
}
