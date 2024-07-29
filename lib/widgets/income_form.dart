import 'package:flutter/material.dart';
import 'package:my_finance/models/income.dart';
import 'package:intl/intl.dart';

class IncomeForm extends StatefulWidget {
  final void Function(Income income) onSubmit;
  final void Function(Income income)? onDelete;
  final Income? income;

  const IncomeForm({
    super.key,
    required this.onSubmit,
    this.onDelete,
    this.income,
  });

  @override
  State<IncomeForm> createState() => _IncomeFormState();
}

class _IncomeFormState extends State<IncomeForm> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.income != null) {
      _nameController.text = widget.income!.name;
      _amountController.text = widget.income!.amount.toString();
      _selectedDate = widget.income!.date;
    }
  }

  void _submit() {
    if (_nameController.text.isEmpty || _amountController.text.isEmpty) {
      return;
    }
    final name = _nameController.text;
    final amount = double.tryParse(_amountController.text) ?? 0;

    final income = Income(
      id: widget.income?.id ?? DateTime.now().millisecondsSinceEpoch,
      name: name,
      amount: amount,
      date: _selectedDate,
    );

    widget.onSubmit(income);
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
              decoration: const InputDecoration(labelText: 'Nome da receita'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Valor recebido'),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
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
              child: Text(
                  widget.income == null
                      ? 'Adicionar receita'
                      : 'Atualizar receita',
                  style: const TextStyle(color: Colors.white)),
            ),
            if (widget.income != null) ...[
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (widget.onDelete != null) {
                    widget.onDelete!(widget.income!);
                  }
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.red,
                ),
                child: const Text('Excluir receita',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
