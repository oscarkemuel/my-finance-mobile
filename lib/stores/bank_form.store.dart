import 'package:mobx/mobx.dart';
import 'package:my_finance/models/bank.dart';

part 'bank_form.store.g.dart';

class BankFormStore = _BankFormStore with _$BankFormStore;

abstract class _BankFormStore with Store {
  @observable
  String name = '';

  @observable
  String balance = '';

  @computed
  bool get canSubmit => name.isNotEmpty && double.tryParse(balance) != null;

  Bank submit() {
    return Bank(
      id: DateTime.now().millisecondsSinceEpoch,
      name: name,
      balance: double.parse(balance),
    );
  }
}
