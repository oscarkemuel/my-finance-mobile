import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_finance/models/category.dart';
import 'package:my_finance/stores/category.store.dart';
import 'package:my_finance/utils/index.dart';
import 'package:my_finance/widgets/category_form.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void _openCategoryFormModal(BuildContext context, [Category? category]) {
    final categoryStore = Provider.of<CategoryStore>(context, listen: false);

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return CategoryForm(
          category: category,
          onSubmit: (category) {
            categoryStore.addCategory(category);
            Navigator.of(context).pop();
          },
          onDelete: (category) {
            categoryStore.removeCategory(category);
          },
        );
      },
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoryStore = Provider.of<CategoryStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
        titleTextStyle: const TextStyle(color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Categorias',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Observer(
              builder: (_) {
                return categoryStore.categories.isEmpty
                    ? const Center(
                        child: Text(
                          'Nenhuma categoria cadastrada.',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    : GridView.builder(
                        itemCount: categoryStore.categories.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          final category = categoryStore.categories[index];
                          return GestureDetector(
                            onTap: () =>
                                _openCategoryFormModal(context, category),
                            child: GridTile(
                              footer: Center(
                                child: Text(
                                  category.name,
                                  style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              child: Icon(Utils.iconMap[category.icon]!.icon,
                                  size: 40, color: Colors.grey[700]),
                            ),
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openCategoryFormModal(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
