// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CategoryStore on _CategoryStore, Store {
  late final _$categoriesAtom =
      Atom(name: '_CategoryStore.categories', context: context);

  @override
  ObservableList<Category> get categories {
    _$categoriesAtom.reportRead();
    return super.categories;
  }

  @override
  set categories(ObservableList<Category> value) {
    _$categoriesAtom.reportWrite(value, super.categories, () {
      super.categories = value;
    });
  }

  late final _$loadCategoriesAsyncAction =
      AsyncAction('_CategoryStore.loadCategories', context: context);

  @override
  Future<void> loadCategories() {
    return _$loadCategoriesAsyncAction.run(() => super.loadCategories());
  }

  late final _$addCategoryAsyncAction =
      AsyncAction('_CategoryStore.addCategory', context: context);

  @override
  Future<void> addCategory(Category category) {
    return _$addCategoryAsyncAction.run(() => super.addCategory(category));
  }

  late final _$removeCategoryAsyncAction =
      AsyncAction('_CategoryStore.removeCategory', context: context);

  @override
  Future<void> removeCategory(Category category) {
    return _$removeCategoryAsyncAction
        .run(() => super.removeCategory(category));
  }

  @override
  String toString() {
    return '''
categories: ${categories}
    ''';
  }
}
