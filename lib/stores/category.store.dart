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
    loadCategories();
  }

  @action
  Future<void> loadCategories() async {
    final categoryList = await categoryDao.getAllCategories();
    categories = ObservableList<Category>.of(categoryList);
  }

  @action
  Future<void> addCategory(Category category) async {
    if (categories.any((c) => c.id == category.id)) {
      await categoryDao.updateCategory(category);
      final index = categories.indexWhere((c) => c.id == category.id);
      if (index != -1) {
        categories[index] = category;
      }
    } else {
      await categoryDao.insertCategory(category);
      categories.add(category);
    }
  }

  @action
  Future<void> removeCategory(Category category) async {
    await expenseStore.updateExpenseByExcludedCategory(category.id);
    await categoryDao.deleteCategory(category.id);
    categories.removeWhere((c) => c.id == category.id);
  }
}
