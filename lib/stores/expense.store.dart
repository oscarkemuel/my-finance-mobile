import 'package:mobx/mobx.dart';
import 'package:my_finance/models/expense.dart';

part 'expense.store.g.dart';

class ExpenseStore = _ExpenseStore with _$ExpenseStore;

abstract class _ExpenseStore with Store {
  @observable
  ObservableList<Expense> expenses = ObservableList<Expense>();

  _ExpenseStore() {
    expenses.add(Expense(
      id: 2,
      name: 'Academia',
      amount: 130,
      date: DateTime.parse('2024-01-10'),
      categoryId: 3,
      bankId: 1,
    ));

    expenses.add(Expense(
      id: 3,
      name: 'Internet',
      amount: 106,
      date: DateTime.parse('2024-01-10'),
      categoryId: 6,
      bankId: 2,
    ));

    expenses.add(Expense(
      id: 8,
      name: 'Uber/99',
      amount: 250,
      date: DateTime.parse('2024-01-10'),
      categoryId: 2,
      bankId: 1,
    ));

    expenses.add(Expense(
      id: 4,
      name: 'Recarga celular',
      amount: 25,
      date: DateTime.parse('2024-01-10'),
      categoryId: 6,
      bankId: 2,
    ));

    expenses.add(Expense(
      id: 5,
      name: 'Amazon Prime',
      amount: 15,
      date: DateTime.parse('2024-01-10'),
      categoryId: 5,
      bankId: 1,
    ));

    expenses.add(Expense(
      id: 6,
      name: 'Spotify',
      amount: 12,
      date: DateTime.parse('2024-01-10'),
      categoryId: 5,
      bankId: 2,
    ));

    expenses.add(Expense(
      id: 7,
      name: 'Google Storage',
      amount: 8,
      date: DateTime.parse('2024-01-10'),
      categoryId: 6,
      bankId: 1,
    ));

    expenses.add(Expense(
      id: 9,
      name: 'Netflix',
      amount: 45,
      date: DateTime.parse('2024-01-10'),
      categoryId: 5,
      bankId: 2,
    ));

    expenses.add(Expense(
      id: 1,
      name: 'CDB',
      amount: 1250,
      date: DateTime.parse('2024-01-10'),
      categoryId: 7,
      bankId: 1,
    ));

    _sortExpenses();
  }

  void _sortExpenses() {
    expenses.sort((a, b) => b.createdDate.compareTo(a.createdDate));
  }

  @action
  void addExpense(Expense expense) {
    expenses.add(expense);
    _sortExpenses();
  }

  @action
  void removeExpense(Expense expense) {
    final expenseIndex = expenses.indexWhere((e) => e.id == expense.id);
    expenses.removeAt(expenseIndex);
    _sortExpenses();
  }

  @computed
  double get totalAmount =>
      expenses.fold(0.0, (sum, item) => sum + item.amount);
}
