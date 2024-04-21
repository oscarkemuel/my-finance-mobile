import 'package:mobx/mobx.dart';
import 'package:my_finance/daos/bank_dao.dart';
import 'package:my_finance/models/bank.dart';

part 'bank.store.g.dart';

// ignore: library_private_types_in_public_api
class BankStore = _BankStore with _$BankStore;

abstract class _BankStore with Store {
  final BankDao bankDao;

  @observable
  ObservableList<Bank> banks = ObservableList<Bank>();

  _BankStore(this.bankDao) {
    _loadBanks();
  }

  @action
  Future<void> _loadBanks() async {
    final bankList = await bankDao.getAllBanks();
    banks = ObservableList<Bank>.of(bankList);
  }

  @action
  Future<dynamic> addBank(Bank bank) async {
    banks.add(bank);
    await bankDao.insertBank(bank);
  }

// TODO: On remove bank, set bakId to 0 for all expenses that have the bankId
  @action
  Future<dynamic> removeBank(Bank bank) async {
    final bankIndex = banks.indexWhere((b) => b.id == bank.id);
    banks.removeAt(bankIndex);
    await bankDao.deleteBank(bank.id);
  }
}
