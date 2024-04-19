import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:my_finance/models/category.dart';

part 'category.store.g.dart';

class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store {
  @observable
  ObservableList<Category> categories = ObservableList<Category>();

  _CategoryStore() {
    categories.add(Category(id: 0, name: 'Desconhecida', icon: Icons.help));
    categories.add(Category(id: 1, name: 'Comida', icon: Icons.food_bank));
    categories.add(Category(id: 2, name: 'Transporte', icon: Icons.directions_bus));
    categories.add(Category(id: 3, name: 'Saúde', icon: Icons.local_hospital));
    categories.add(Category(id: 4, name: 'Educação', icon: Icons.school));
    categories.add(Category(id: 5, name: 'Entretenimento', icon: Icons.movie));
    categories.add(Category(id: 6, name: 'Serviços', icon: Icons.settings));
    categories.add(Category(id: 7, name: 'Outros', icon: Icons.more_horiz));
  }

  @action
  void addCategory(Category category) {
    categories.add(category);
  }

  // TODO: On remove category, set categoryId to 0 for all expenses that have the categoryId
  @action
  void removeCategory(Category category) {
    final categoryIndex = categories.indexWhere((c) => c.id == category.id);
    categories.removeAt(categoryIndex);
  }
}