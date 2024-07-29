import 'package:mobx/mobx.dart';
import 'package:my_finance/daos/bank_dao.dart';
import 'package:my_finance/models/bank.dart';
import 'package:my_finance/stores/expense.store.dart';

part 'bank.store.g.dart';

// ignore: library_private_types_in_public_api
class BankStore = _BankStore with _$BankStore;

abstract class _BankStore with Store {
  final BankDao bankDao;
  final ExpenseStore expenseStore;

  @observable
  ObservableList<Bank> banks = ObservableList<Bank>();

  _BankStore(this.bankDao, this.expenseStore) {
    loadBanks();
  }

  @action
  Future<void> loadBanks() async {
    final bankList = await bankDao.getAllBanks();
    banks = ObservableList<Bank>.of(bankList);
  }

  @action
  Future<dynamic> addBank(Bank bank) async {
    final hasBank = banks.any((b) => b.id == bank.id);
    if (!hasBank) {
      await bankDao.insertBank(bank);
      banks.add(bank);
    } else {
      await bankDao.updateBank(bank);
      final index = banks.indexWhere((b) => b.id == bank.id);
      if (index != -1) {
        banks[index] = bank;
      }
    }
  }

  @action
  Future<dynamic> removeBank(Bank bank) async {
    final hasDependency = expenseStore.hasDependencyOfBank(bank.id);

    if (hasDependency) {
      return;
    }

    await expenseStore.updateExpenseByExcludedBank(bank.id);
    await bankDao.deleteBank(bank.id);

    final bankIndex = banks.indexWhere((b) => b.id == bank.id);
    banks.removeAt(bankIndex);
  }
}
