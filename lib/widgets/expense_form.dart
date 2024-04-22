import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:my_finance/models/bank.dart';
import 'package:my_finance/models/category.dart';
import 'package:my_finance/models/expense.dart';
import 'package:my_finance/stores/bank.store.dart';
import 'package:my_finance/stores/category.store.dart';
import 'package:provider/provider.dart';

class ExpenseForm extends StatefulWidget {
  final void Function(Expense expense) onSubmit;

  const ExpenseForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  late int _selectedBankId;
  late int _selectedCategoryId;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _selectedBankId = 0;
    _selectedCategoryId = 0;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_nameController.text.isEmpty || _amountController.text.isEmpty) {
      return;
    }
    final name = _nameController.text;
    final amount = double.tryParse(_amountController.text) ?? 0;

    final expense = Expense(
      id: DateTime.now().millisecondsSinceEpoch,
      name: name,
      amount: amount,
      bankId: _selectedBankId,
      categoryId: _selectedCategoryId,
      date: _selectedDate,
      createdDate: DateTime.now(),
    );

    widget.onSubmit(expense);
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final bankStore = Provider.of<BankStore>(context);
    final categoryStore = Provider.of<CategoryStore>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nome da despesa'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Valor da despesa'),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 20),
            Observer(builder: (_) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: DropdownButton<int>(
                      isExpanded: true,
                      value: _selectedBankId,
                      items: bankStore.banks
                          .map<DropdownMenuItem<int>>((Bank bank) {
                        return DropdownMenuItem<int>(
                          value: bank.id,
                          child: Text(bank.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedBankId = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButton<int>(
                      isExpanded: true,
                      value: _selectedCategoryId,
                      items: categoryStore.categories
                          .map<DropdownMenuItem<int>>((Category category) {
                        return DropdownMenuItem<int>(
                          value: category.id,
                          child: Text(category.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategoryId = value!;
                        });
                      },
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Data: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}',
                  style: const TextStyle(fontSize: 16),
                ),
                TextButton(
                  onPressed: _presentDatePicker,
                  child: const Text('Escolher Data'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.green,
              ),
              child: const Text('Adicionar despesa',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
