
import 'package:mobx/mobx.dart';
import 'package:my_finance/models/bank.dart';

part 'bank.store.g.dart';

class BankStore = _BankStore with _$BankStore;

abstract class _BankStore with Store {
  @observable
  ObservableList<Bank> banks = ObservableList<Bank>();

  _BankStore() {
    banks.add(Bank(id: 0, name: 'Desconhecido', balance: 0));
    
    banks.add(Bank(id: 1, name: 'Banco 1', balance: 5000));
    banks.add(Bank(id: 2, name: 'Banco 2', balance: 2000));
  }

  @action
  void addBank(Bank bank) {
    banks.add(bank);
  }

  // TODO: On remove bank, set bakId to 0 for all expenses that have the bankId
  @action
  void removeBank(Bank bank) {
    final bankIndex = banks.indexWhere((b) => b.id == bank.id);
    banks.removeAt(bankIndex);
  }
}