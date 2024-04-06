import 'package:flutter/material.dart';
import 'package:my_finance/models/category.dart';

class CategoryForm extends StatefulWidget {
  final void Function(Category category) onSubmit;

  const CategoryForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final _nameController = TextEditingController();
  IconData? _selectedIcon;

  final List<IconData> _icons = [
    Icons.home,
    Icons.fastfood,
    Icons.movie,
    Icons.shopping_cart,
    Icons.flight,
    Icons.fitness_center,
    Icons.pets,
    Icons.settings,
    Icons.school,
    Icons.local_hospital,
    Icons.directions_bus,
    Icons.more_horiz,
  ];

  void _submit() {
    if (_nameController.text.isEmpty || _selectedIcon == null) {
      return;
    }

    final category = Category(
      id: DateTime.now().millisecondsSinceEpoch,
      name: _nameController.text,
      icon: _selectedIcon!,
    );

    widget.onSubmit(category);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nome da Categoria'),
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              itemCount: _icons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIcon = _icons[index];
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: _selectedIcon == _icons[index]
                          ? Border.all(
                              color: Theme.of(context).primaryColor, width: 2)
                          : null,
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                    child: Icon(
                      _icons[index],
                      size: 40,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Adicionar Categoria'),
            ),
          ],
        ),
      ),
    );
  }
}
