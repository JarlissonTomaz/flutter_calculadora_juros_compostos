
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelicCalculator extends StatefulWidget {
  const SelicCalculator({super.key});

  @override
  _SelicCalculatorState createState() => _SelicCalculatorState();
}

class _SelicCalculatorState extends State<SelicCalculator> {
  final _valueController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  double? _result;
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      
      appBar: AppBar(title: Text("Correção Selic")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _valueController,
              decoration: InputDecoration(labelText: "Valor inicial (R\$)"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _selectDate(context, isStart: true),
                    child: Text(_startDate == null
                        ? "Data inicial"
                        :  DateFormat('dd/MM/yyyy').format(_startDate!)),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _selectDate(context, isStart: false),
                    child: Text(_endDate == null
                        ? "Data final"
                        : DateFormat('dd/MM/yyyy').format(_endDate!),),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculate,
              child: Text("Calcular"),
            ),
            if (_result != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  "Resultado: R\$ ${_result!.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, {required bool isStart}) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        if (isStart) {
          _startDate = pickedDate;
        } else {
          _endDate = pickedDate;
        }
      });
    }
  }

  void _calculate() async {
    final value = double.tryParse(_valueController.text);
    if (value == null || _startDate == null || _endDate == null) {
      return;
    }

    // Aqui você implementaria a lógica de cálculo com base na API da Selic.
    // Por enquanto, estamos simulando um resultado.
    setState(() {
      _result = value * 1.05; // Simulando 5% de correção
    });
  }
}
