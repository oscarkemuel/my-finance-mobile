import 'package:mobx/mobx.dart';
import 'package:my_finance/daos/category_dao.dart';
import 'package:my_finance/models/category.dart';
import 'package:my_finance/stores/expense.store.dart';

part 'category.store.g.dart';

// ignore: library_private_types_in_public_api
class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store {
  final CategoryDao categoryDao;
  final ExpenseStore expenseStore;

  @observable
  ObservableList<Category> categories = ObservableList<Category>();

  _CategoryStore(this.categoryDao, this.expenseStore) {
    _loadCategories();
  }

  @action
  Future<void> _loadCategories() async {
    final categoryList = await categoryDao.getAllCategories();
    categories = ObservableList<Category>.of(categoryList);
  }

  @action
  Future<dynamic> addCategory(Category category) async {
    categories.add(category);
    await categoryDao.insertCategory(category);
  }

  @action
  Future<dynamic> removeCategory(Category category) async {
    await expenseStore.updateExpenseByExcludedCategory(category.id);
    await categoryDao.deleteCategory(category.id);

    final categoryIndex = categories.indexWhere((c) => c.id == category.id);
    categories.removeAt(categoryIndex);
  }
}