import 'package:flutter/material.dart';
import 'package:my_finance/models/bank.dart';
import 'package:my_finance/models/category.dart';
import 'package:my_finance/models/expense.dart';

class ExpenseForm extends StatefulWidget {
  final void Function(Expense expense) onSubmit;
  final List<Bank> banks;
  final List<Category> categories;

  const ExpenseForm({
    super.key,
    required this.onSubmit,
    required this.banks,
    required this.categories,
  });

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  late int _selectedBankId;
  late int _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _selectedBankId = widget.banks.first.id;
    _selectedCategoryId = widget.categories.first.id;

    _nameController.addListener(_updateState);
    _amountController.addListener(_updateState);
  }

  @override
  void dispose() {
    _nameController.removeListener(_updateState);
    _amountController.removeListener(_updateState);
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

   void _updateState() {
    setState(() {});
  }

  void _submit() {
    final name = _nameController.text;
    final double amount;

    try {
      amount = double.parse(_amountController.text);
    } catch (e) {
      return;
    }

    final expense = Expense(
      id: DateTime.now().millisecondsSinceEpoch,
      name: name,
      amount: amount,
      bankId: _selectedBankId,
      categoryId: _selectedCategoryId,
      date: DateTime.now(),
    );

    widget.onSubmit(expense);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              hintText: 'Nome da despesa',
              labelText: 'Nome',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _amountController,
            decoration: const InputDecoration(
              hintText: 'Valor da despesa',
              labelText: 'Valor',
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Conta'),
                    DropdownButton<int>(
                      isExpanded: true,
                      value: _selectedBankId,
                      items: widget.banks
                          .map((bank) => DropdownMenuItem(
                                value: bank.id,
                                child: Text(bank.name),
                              ))
                          .toList(),
                      onChanged: (int? value) {
                        setState(() {
                          _selectedBankId = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16), // Para espaçar os Dropdowns
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Categoria'),
                    DropdownButton<int>(
                      isExpanded: true,
                      value: _selectedCategoryId,
                      items: widget.categories
                          .map((category) => DropdownMenuItem(
                                value: category.id,
                                child: Text(category.name),
                              ))
                          .toList(),
                      onChanged: (int? value) {
                        setState(() {
                          _selectedCategoryId = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _nameController.text.isNotEmpty &&
                    _amountController.text.isNotEmpty
                ? _submit
                : null,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('Adicionar despesa'),
          ),
        ],
      ),
    );
  }
}
