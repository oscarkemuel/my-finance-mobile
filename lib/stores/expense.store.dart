import 'package:mobx/mobx.dart';
import 'package:my_finance/daos/expense_dao.dart';
import 'package:my_finance/models/expense.dart';

part 'expense.store.g.dart';

// ignore: library_private_types_in_public_api
class ExpenseStore = _ExpenseStore with _$ExpenseStore;

abstract class _ExpenseStore with Store {
  final ExpenseDao expenseDao;

  @observable
  ObservableList<Expense> expenses = ObservableList<Expense>();

  _ExpenseStore(this.expenseDao) {
    _loadExpenses();
  }

  @action
  Future<void> _loadExpenses() async {
    final expenseList = await expenseDao.getAllExpenses();
    expenses = ObservableList<Expense>.of(expenseList);
    _sortExpenses();
  }

  @action
  Future<void> addExpense(Expense expense) async {
    expenses.add(expense);
    _sortExpenses();
    await expenseDao.insertExpense(expense);
  }

  @action
  Future<void> removeExpense(Expense expense) async {
    final expenseIndex = expenses.indexWhere((e) => e.id == expense.id);
    expenses.removeAt(expenseIndex);
    _sortExpenses();
    await expenseDao.deleteExpense(expense.id);
  }

  Future<void> updateExpenseByExcludedCategory(int categoryId) async {
    await expenseDao.updateExpenseByExcludedCategory(categoryId);
    await _loadExpenses();
  }

  Future<void> updateExpenseByExcludedBank(int bankId) async {
    await expenseDao.updateExpenseByExcludedBank(bankId);
    await _loadExpenses();
  }

  void _sortExpenses() {
    expenses.sort((a, b) => b.createdDate.compareTo(a.createdDate));
  }

  @computed
  double get totalAmount =>
      expenses.fold(0.0, (sum, item) => sum + item.amount);
}
