import 'package:mobx/mobx.dart';
import 'package:my_finance/daos/income_dao.dart';
import 'package:my_finance/models/income.dart';

part 'income.store.g.dart';

// ignore: library_private_types_in_public_api
class IncomeStore = _IncomeStore with _$IncomeStore;

abstract class _IncomeStore with Store {
  final IncomeDao incomeDao;

  @observable
  ObservableList<Income> incomes = ObservableList<Income>();

  _IncomeStore(this.incomeDao) {
    _loadIncomes();
  }

  @action
  Future<void> _loadIncomes() async {
    final incomeList = await incomeDao.getAllIncomes();
    incomes = ObservableList<Income>.of(incomeList);
  }

  @action
  Future<dynamic> addIncome(Income income) async {
    if (incomes.any((i) => i.id == income.id)) {
      await incomeDao.updateIncome(income);
      final index = incomes.indexWhere((i) => i.id == income.id);
      if (index != -1) {
        incomes[index] = income;
      }
    } else {
      await incomeDao.insertIncome(income);
      incomes.add(income);
    }
  }

  @action
  Future<dynamic> removeIncome(Income income) async {
    final incomeIndex = incomes.indexWhere((i) => i.id == income.id);
    incomes.removeAt(incomeIndex);
    await incomeDao.deleteIncome(income.id);
  }

  @computed
  double get totalAmount {
    return incomes.fold(0.0, (sum, item) => sum + item.amount);
  }
}
