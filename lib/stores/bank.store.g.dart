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

  late final _$loadBanksAsyncAction =
      AsyncAction('_BankStore.loadBanks', context: context);

  @override
  Future<void> loadBanks() {
    return _$loadBanksAsyncAction.run(() => super.loadBanks());
  }

  late final _$addBankAsyncAction =
      AsyncAction('_BankStore.addBank', context: context);

  @override
  Future<dynamic> addBank(Bank bank) {
    return _$addBankAsyncAction.run(() => super.addBank(bank));
  }

  late final _$removeBankAsyncAction =
      AsyncAction('_BankStore.removeBank', context: context);

  @override
  Future<dynamic> removeBank(Bank bank) {
    return _$removeBankAsyncAction.run(() => super.removeBank(bank));
  }

  @override
  String toString() {
    return '''
banks: ${banks}
    ''';
  }
}
