// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$IncomeStore on _IncomeStore, Store {
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

  late final _$_IncomeStoreActionController =
      ActionController(name: '_IncomeStore', context: context);

  @override
  void addIncome(Income income) {
    final _$actionInfo = _$_IncomeStoreActionController.startAction(
        name: '_IncomeStore.addIncome');
    try {
      return super.addIncome(income);
    } finally {
      _$_IncomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeIncome(Income income) {
    final _$actionInfo = _$_IncomeStoreActionController.startAction(
        name: '_IncomeStore.removeIncome');
    try {
      return super.removeIncome(income);
    } finally {
      _$_IncomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
incomes: ${incomes}
    ''';
  }
}
