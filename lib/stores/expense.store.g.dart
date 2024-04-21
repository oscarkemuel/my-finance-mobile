// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ExpenseStore on _ExpenseStore, Store {
  Computed<double>? _$totalAmountComputed;

  @override
  double get totalAmount =>
      (_$totalAmountComputed ??= Computed<double>(() => super.totalAmount,
              name: '_ExpenseStore.totalAmount'))
          .value;

  late final _$expensesAtom =
      Atom(name: '_ExpenseStore.expenses', context: context);

  @override
  ObservableList<Expense> get expenses {
    _$expensesAtom.reportRead();
    return super.expenses;
  }

  @override
  set expenses(ObservableList<Expense> value) {
    _$expensesAtom.reportWrite(value, super.expenses, () {
      super.expenses = value;
    });
  }

  late final _$_loadExpensesAsyncAction =
      AsyncAction('_ExpenseStore._loadExpenses', context: context);

  @override
  Future<void> _loadExpenses() {
    return _$_loadExpensesAsyncAction.run(() => super._loadExpenses());
  }

  late final _$addExpenseAsyncAction =
      AsyncAction('_ExpenseStore.addExpense', context: context);

  @override
  Future<void> addExpense(Expense expense) {
    return _$addExpenseAsyncAction.run(() => super.addExpense(expense));
  }

  late final _$removeExpenseAsyncAction =
      AsyncAction('_ExpenseStore.removeExpense', context: context);

  @override
  Future<void> removeExpense(Expense expense) {
    return _$removeExpenseAsyncAction.run(() => super.removeExpense(expense));
  }

  @override
  String toString() {
    return '''
expenses: ${expenses},
totalAmount: ${totalAmount}
    ''';
  }
}
