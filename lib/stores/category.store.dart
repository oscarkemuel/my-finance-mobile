import 'package:mobx/mobx.dart';
import 'package:my_finance/daos/category_dao.dart';
import 'package:my_finance/models/category.dart';

part 'category.store.g.dart';

// ignore: library_private_types_in_public_api
class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store {
  final CategoryDao categoryDao;

  @observable
  ObservableList<Category> categories = ObservableList<Category>();

  _CategoryStore(this.categoryDao) {
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

  // TODO: On remove category, set categoryId to 0 for all expenses that have the categoryId
  @action
  Future<dynamic> removeCategory(Category category) async {
    final categoryIndex = categories.indexWhere((c) => c.id == category.id);
    categories.removeAt(categoryIndex);
    await categoryDao.deleteCategory(category.id);
  }
}