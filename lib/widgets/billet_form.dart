import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_finance/models/billet.dart';
import 'package:intl/intl.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BilletForm extends StatefulWidget {
  final void Function(Billet billet) onSubmit;
  final void Function(Billet billet)? onDelete;
  final Billet? billet;

  const BilletForm({
    super.key,
    required this.onSubmit,
    this.onDelete,
    this.billet,
  });

  @override
  State<BilletForm> createState() => _BilletFormState();
}

class _BilletFormState extends State<BilletForm> {
  final _codeController = TextEditingController();
  final _amountController = TextEditingController();
  final _companyController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDueDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.billet != null) {
      _codeController.text = widget.billet!.code;
      _amountController.text = widget.billet!.amount.toString();
      _companyController.text = widget.billet!.company;
      _descriptionController.text = widget.billet!.description;
      _selectedDueDate = widget.billet!.dueDate;
    }
  }

  void _submit() {
    if (_codeController.text.isEmpty ||
        _amountController.text.isEmpty ||
        _companyController.text.isEmpty ||
        _descriptionController.text.isEmpty) {
      return;
    }

    final code = _codeController.text;
    final amount = double.tryParse(_amountController.text) ?? 0;
    final company = _companyController.text;
    final description = _descriptionController.text;

    final billet = Billet(
      id: widget.billet?.id ?? DateTime.now().millisecondsSinceEpoch,
      code: code,
      amount: amount,
      dueDate: _selectedDueDate,
      company: company,
      description: description,
    );

    widget.onSubmit(billet);
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
        _selectedDueDate = pickedDate;
      });
    });
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);

      if (barcodeScanRes == '-1') {
        return;
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _codeController.text = barcodeScanRes;
    });
  }

  void _copyCodeToClipboard() {
    Clipboard.setData(ClipboardData(text: _codeController.text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Código copiado para a área de transferência')),
    );
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
              controller: _codeController,
              decoration: InputDecoration(
                labelText: 'Código do boleto',
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.camera_alt),
                      onPressed: scanBarcodeNormal,
                    ),
                    if (widget.billet != null)
                      IconButton(
                        icon: const Icon(Icons.copy),
                        onPressed: _copyCodeToClipboard,
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Valor do boleto'),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _companyController,
              decoration: const InputDecoration(labelText: 'Empresa'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Vencimento: ${DateFormat('dd/MM/yyyy').format(_selectedDueDate)}',
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
                  widget.billet == null
                      ? 'Adicionar boleto'
                      : 'Atualizar boleto',
                  style: const TextStyle(color: Colors.white)),
            ),
            if (widget.billet != null) ...[
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (widget.onDelete != null) {
                    widget.onDelete!(widget.billet!);
                  }
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.red,
                ),
                child: const Text('Excluir boleto',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
