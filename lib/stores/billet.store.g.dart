// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billet.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BilletStore on _BilletStore, Store {
  late final _$billetsAtom =
      Atom(name: '_BilletStore.billets', context: context);

  @override
  ObservableList<Billet> get billets {
    _$billetsAtom.reportRead();
    return super.billets;
  }

  @override
  set billets(ObservableList<Billet> value) {
    _$billetsAtom.reportWrite(value, super.billets, () {
      super.billets = value;
    });
  }

  late final _$loadBilletsAsyncAction =
      AsyncAction('_BilletStore.loadBillets', context: context);

  @override
  Future<void> loadBillets() {
    return _$loadBilletsAsyncAction.run(() => super.loadBillets());
  }

  late final _$addBilletAsyncAction =
      AsyncAction('_BilletStore.addBillet', context: context);

  @override
  Future<dynamic> addBillet(Billet billet) {
    return _$addBilletAsyncAction.run(() => super.addBillet(billet));
  }

  late final _$removeBilletAsyncAction =
      AsyncAction('_BilletStore.removeBillet', context: context);

  @override
  Future<dynamic> removeBillet(Billet billet) {
    return _$removeBilletAsyncAction.run(() => super.removeBillet(billet));
  }

  @override
  String toString() {
    return '''
billets: ${billets}
    ''';
  }
}
