// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BankStore on _BankStore, Store {
  late final _$banksAtom = Atom(name: '_BankStore.banks', context: context);

  @override
  ObservableList<Bank> get banks {
    _$banksAtom.reportRead();
    return super.banks;
  }

  @override
  set banks(ObservableList<Bank> value) {
    _$banksAtom.reportWrite(value, super.banks, () {
      super.banks = value;
    });
  }

  late final _$_BankStoreActionController =
      ActionController(name: '_BankStore', context: context);

  @override
  void addBank(Bank bank) {
    final _$actionInfo =
        _$_BankStoreActionController.startAction(name: '_BankStore.addBank');
    try {
      return super.addBank(bank);
    } finally {
      _$_BankStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeBank(Bank bank) {
    final _$actionInfo =
        _$_BankStoreActionController.startAction(name: '_BankStore.removeBank');
    try {
      return super.removeBank(bank);
    } finally {
      _$_BankStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
banks: ${banks}
    ''';
  }
}
