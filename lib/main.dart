import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(JurosCompostosApp());
}

class JurosCompostosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _initialAmountController = TextEditingController();
  final TextEditingController _monthlyContributionController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  bool _isRateAnnual = true;
  bool _isTimeInYears = true;
  double? _result;

  void _calculateCompoundInterest() {
    final double initialAmount = double.tryParse(_initialAmountController.text) ?? 0.0;
    final double monthlyContribution = double.tryParse(_monthlyContributionController.text) ?? 0.0;
    final double rate = double.tryParse(_rateController.text) ?? 0.0;
    final int time = int.tryParse(_timeController.text) ?? 0;

    if (initialAmount >= 0 && monthlyContribution >= 0 && rate > 0 && time > 0) {
      double periodRate = _isRateAnnual ? rate / 100 / 12 : rate / 100;
      int totalPeriods = _isTimeInYears ? time * 12 : time;

      double futureValue = initialAmount * pow(1 + periodRate, totalPeriods) +
          (monthlyContribution * (pow(1 + periodRate, totalPeriods) - 1) / periodRate);

      setState(() {
        _result = futureValue;
      });
    } else {
      setState(() {
        _result = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, insira valores válidos!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de Juros Compostos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _initialAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Valor Inicial (P)',
              ),
            ),
            TextField(
              controller: _monthlyContributionController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Contribuição Mensal (C)',
              ),
            ),
            TextField(
              controller: _rateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Taxa de Juros (%)',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Taxa é Anual?'),
                Switch(
                  value: _isRateAnnual,
                  onChanged: (value) {
                    setState(() {
                      _isRateAnnual = value;
                    });
                  },
                ),
              ],
            ),
            TextField(
              controller: _timeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Período (n)',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tempo em Anos?'),
                Switch(
                  value: _isTimeInYears,
                  onChanged: (value) {
                    setState(() {
                      _isTimeInYears = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateCompoundInterest,
              child: Text('Calcular'),
            ),
            SizedBox(height: 20),
            if (_result != null)
              Text(
                'Valor Futuro: ${_result!.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
