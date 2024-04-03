import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;

  List<Widget> _screens = [
    const Center(
      child: Text('Home'),
    ),
    const Center(
      child: Text('Despesas'),
    ),
    const Center(
      child: Text('Bancos'),
    ),
    const Center(
      child: Text('Receitas'),
    ),
    const Center(
      child: Text('Categorias'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My finance app'),
        ),
        body: const Center(
          child: Text('My finance app'),
        ),
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
        ));
  }
}
