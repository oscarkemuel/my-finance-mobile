import 'package:flutter/material.dart';
import 'package:my_finance/models/bank.dart';
import 'package:my_finance/models/category.dart';
import 'package:my_finance/models/expense.dart';
import 'package:my_finance/models/income.dart';
import 'package:my_finance/screens/home_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Income> incomes;
  final List<Expense> expenses;
  final List<Bank> banks;
  final List<Category> categories;

  const TabsScreen({
    super.key,
    required this.incomes,
    required this.expenses,
    required this.banks,
    required this.categories,
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
        banks: widget.banks,
        categories: widget.categories,
      )
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
        appBar: AppBar(
          title: const Text("My finance app"),
          titleTextStyle: const TextStyle(color: Colors.white),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: _screens[_selectedScreenIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.money_off),
              label: 'Despesas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance),
              label: 'Bancos',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.attach_money), label: 'Receitas'),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categorias',
            ),
          ],
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.grey,
          onTap: _selectScreen,
          currentIndex: _selectedScreenIndex,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        ));
  }
}
