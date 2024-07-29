// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$IncomeStore on _IncomeStore, Store {
  Computed<double>? _$totalAmountComputed;

  @override
  double get totalAmount =>
      (_$totalAmountComputed ??= Computed<double>(() => super.totalAmount,
              name: '_IncomeStore.totalAmount'))
          .value;

  late final _$incomesAtom =
      Atom(name: '_IncomeStore.incomes', context: context);

  @override
  ObservableList<Income> get incomes {
    _$incomesAtom.reportRead();
    return super.incomes;
  }

  @override
  set incomes(ObservableList<Income> value) {
    _$incomesAtom.reportWrite(value, super.incomes, () {
      super.incomes = value;
    });
  }

  late final _$_loadIncomesAsyncAction =
      AsyncAction('_IncomeStore._loadIncomes', context: context);

  @override
  Future<void> _loadIncomes() {
    return _$_loadIncomesAsyncAction.run(() => super._loadIncomes());
  }

  late final _$addIncomeAsyncAction =
      AsyncAction('_IncomeStore.addIncome', context: context);

  @override
  Future<dynamic> addIncome(Income income) {
    return _$addIncomeAsyncAction.run(() => super.addIncome(income));
  }

  late final _$removeIncomeAsyncAction =
      AsyncAction('_IncomeStore.removeIncome', context: context);

  @override
  Future<dynamic> removeIncome(Income income) {
    return _$removeIncomeAsyncAction.run(() => super.removeIncome(income));
  }

  @override
  String toString() {
    return '''
incomes: ${incomes},
totalAmount: ${totalAmount}
    ''';
  }
}
