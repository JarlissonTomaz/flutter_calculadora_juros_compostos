
import 'dart:math';

import 'package:flutter/material.dart';

class CalculoCDIPage extends StatefulWidget {
  const CalculoCDIPage({super.key});

  @override
  State<CalculoCDIPage> createState() => _CalculoCDIPageState();
}

class _CalculoCDIPageState extends State<CalculoCDIPage> {
  final TextEditingController _valorController = TextEditingController();
  final TextEditingController _cdiController = TextEditingController();
  final TextEditingController _diasController = TextEditingController();

  double? _resultado;

  double calcularValorCorrigido(double valorInicial, double cdiAnual, int diasUteis) {
 double cdiDiario = pow(1 + cdiAnual, 1 / 252) - 1;
  // Retorna o valor final
  return valorInicial * pow(1 + cdiDiario, diasUteis);
  }

  void _calcular() {
    double valorInicial = double.parse(_valorController.text);
    double cdiAnual = double.parse(_cdiController.text) / 100; // Converter para decimal
    int diasUteis = int.parse(_diasController.text);

    setState(() {
      _resultado = calcularValorCorrigido(valorInicial, cdiAnual, diasUteis);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cálculo CDI'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _valorController,
              decoration: InputDecoration(labelText: 'Valor Inicial (R\$)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _cdiController,
              decoration: InputDecoration(labelText: 'CDI Anual (%)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _diasController,
              decoration: InputDecoration(labelText: 'Dias Úteis'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calcular,
              child: Text('Calcular'),
            ),
            if (_resultado != null)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Valor Corrigido: R\$ ${_resultado!.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
