import 'package:mobx/mobx.dart';
import 'package:my_finance/models/income.dart';

part 'income.store.g.dart';

// ignore: library_private_types_in_public_api
class IncomeStore = _IncomeStore with _$IncomeStore;

abstract class _IncomeStore with Store {
  @observable
  ObservableList<Income> incomes = ObservableList<Income>();

  _IncomeStore() {
    incomes.add(
        Income(id: 0, name: 'Salário', amount: 3250, date: DateTime.now()));
    incomes.add(
        Income(id: 1, name: 'Freelancer', amount: 500, date: DateTime.now()));
  }

  @action
  void addIncome(Income income) {
    incomes.add(income);
  }

  @action
  void removeIncome(Income income) {
    final incomeIndex = incomes.indexWhere((i) => i.id == income.id);
    incomes.removeAt(incomeIndex);
  }

  @computed
  double get totalAmount {
    return incomes.fold(0.0, (sum, item) => sum + item.amount);
  }
}
