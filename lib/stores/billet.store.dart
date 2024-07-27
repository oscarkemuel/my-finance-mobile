import 'package:mobx/mobx.dart';
import 'package:my_finance/daos/billet_dao.dart';
import 'package:my_finance/models/billet.dart';

part 'billet.store.g.dart';

// ignore: library_private_types_in_public_api
class BilletStore = _BilletStore with _$BilletStore;

abstract class _BilletStore with Store {
  final BilletDao billetDao;

  @observable
  ObservableList<Billet> billets = ObservableList<Billet>();

  _BilletStore(this.billetDao) {
    loadBillets();
  }

  @action
  Future<void> loadBillets() async {
    final billetList = await billetDao.getAllBillets();
    billets = ObservableList<Billet>.of(billetList);
  }

  @action
  Future<dynamic> addBillet(Billet billet) async {
    final hasBillet = billets.any((b) => b.id == billet.id);
    if (!hasBillet) {
      await billetDao.insertBillet(billet);
      billets.add(billet);
    } else {
      await billetDao.updateBillet(billet);
      final index = billets.indexWhere((b) => b.id == billet.id);
      if (index != -1) {
        billets[index] = billet;
      }
    }
  }

  @action
  Future<dynamic> removeBillet(Billet billet) async {
    await billetDao.deleteBillet(billet.id);

    final billetIndex = billets.indexWhere((b) => b.id == billet.id);
    billets.removeAt(billetIndex);
  }
}
