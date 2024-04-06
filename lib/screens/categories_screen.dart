import 'package:flutter/material.dart';
import 'package:my_finance/models/category.dart';
import 'package:my_finance/widgets/category_form.dart';

class CategoriesScreen extends StatefulWidget {
  final List<Category> categories;
  final Function(Category) onAddCategory;
  final Function(int) onRemoveCategory;

  const CategoriesScreen({
    super.key,
    required this.categories,
    required this.onAddCategory,
    required this.onRemoveCategory,
  });

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  void _openCategoryFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return CategoryForm(
          onSubmit: (category) {
            widget.onAddCategory(category);
            setState(() {});
          },
        );
      },
    );
  }

  void _openModalToDeleteCategory(BuildContext context, Category category) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Excluir "${category.name}"'),
          titleTextStyle: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          content: const Text('Deseja realmente excluir esta categoria?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                widget.onRemoveCategory(category.id);
                Navigator.of(context).pop();
                setState(() {});
              },
              child: const Text('Excluir', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Category> categoriesToShow =
        widget.categories.length > 1 ? widget.categories.sublist(1) : [];

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
            child: categoriesToShow.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhuma categoria cadastrada.',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : GridView.builder(
                    itemCount: categoriesToShow.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      final category = categoriesToShow[index];
                      return GestureDetector(
                        onTap: () {
                          _openModalToDeleteCategory(context, category);
                        },
                        child: GridTile(
                          footer: Center(
                            child: Text(
                              category.name,
                              style: const TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ),
                          child: Icon(category.icon,
                              size: 40, color: Colors.grey[700]),
                        ),
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
