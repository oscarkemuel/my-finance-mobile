import 'package:flutter/material.dart';
import 'package:my_finance/models/category.dart';
import 'package:my_finance/utils/index.dart';

class CategoryForm extends StatefulWidget {
  final void Function(Category category) onSubmit;
  final void Function(Category category)? onDelete;
  final Category? category;

  const CategoryForm({
    super.key,
    required this.onSubmit,
    this.onDelete,
    this.category,
  });

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final _nameController = TextEditingController();
  CategoryIdentifier? _selectedIcon;
  final _icons = Utils.iconMap;

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      _nameController.text = widget.category!.name;
      _selectedIcon = _icons.entries
          .firstWhere(
              (element) => element.value.identifier == widget.category!.icon)
          .key;
    }
  }

  void _submit() {
    if (_nameController.text.isEmpty || _selectedIcon == null) {
      return;
    }

    final category = Category(
      id: widget.category?.id ?? DateTime.now().millisecondsSinceEpoch,
      name: _nameController.text,
      icon: _icons[_selectedIcon]!.identifier,
    );

    widget.onSubmit(category);
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
                CategoryIdentifier key = _icons.keys.elementAt(index);
                CategoryIcon value = _icons[key]!;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIcon = key;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: _selectedIcon == key
                          ? Border.all(
                              color: Theme.of(context).primaryColor, width: 2)
                          : null,
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                    child: Icon(
                      value.icon,
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
                backgroundColor: Colors.green,
              ),
              child: Text(
                  widget.category == null
                      ? 'Adicionar Categoria'
                      : 'Atualizar Categoria',
                  style: const TextStyle(color: Colors.white)),
            ),
            if (widget.category != null) ...[
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (widget.onDelete != null) {
                    widget.onDelete!(widget.category!);
                  }
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.red,
                ),
                child: const Text('Excluir Categoria',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
