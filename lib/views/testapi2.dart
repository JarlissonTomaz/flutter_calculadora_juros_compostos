import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DatePickerExample2 extends StatefulWidget {
  const DatePickerExample2({super.key});

  @override
  State<DatePickerExample2> createState() => _DatePickerExample2State();
}

class _DatePickerExample2State extends State<DatePickerExample2> {
  DateTime? _dataInicial;
  DateTime? _dataFinal;
  double? _valorFinal;
  List<Map<String, dynamic>> _dados = [];
  final TextEditingController _valorInicialController = TextEditingController();

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  Future<void> carregarDados() async {
    final url = 'https://api.bcb.gov.br/dados/serie/bcdata.sgs.10844/dados?formato=json';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> dados = json.decode(response.body);

        setState(() {
          _dados = dados.cast<Map<String, dynamic>>();
        });
      } else {
        throw Exception('Falha ao carregar dados');
      }
    } catch (e) {
      print('Erro ao carregar dados: $e');
    }
  }

  double calcularValorFinal(
      double valorInicial, DateTime dataInicial, DateTime dataFinal) {
    int dias = dataFinal.difference(dataInicial).inDays; // Dias entre as datas
    double valorFinal = valorInicial;

    for (int i = 0; i <= dias; i++) {
      final dataAtual = dataInicial.add(Duration(days: i));
      final dataFormatada =
          "${dataAtual.day.toString().padLeft(2, '0')}/${dataAtual.month.toString().padLeft(2, '0')}/${dataAtual.year}";

      // Buscar a taxa para a data atual
      final taxaDiaria = (double.tryParse(buscarValor(dataFormatada) ?? '0') ?? 0) / 100;

      // Aplicar juros compostos
      valorFinal *= (1 + taxaDiaria);
    }

    return valorFinal;
  }

  String? buscarValor(String dataFormatada) {
    final item = _dados.firstWhere(
      (item) => item['data'] == dataFormatada,
      orElse: () => {},
    );
    return item['valor'];
  }

  Future<void> _selecionarData(BuildContext context, bool isInicial) async {
    final dataEscolhida = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1987),
      lastDate: DateTime.now(),
    );

    if (dataEscolhida != null) {
      setState(() {
        if (isInicial) {
          _dataInicial = dataEscolhida;
        } else {
          _dataFinal = dataEscolhida;
        }

        if (_dataInicial != null &&
            _dataFinal != null &&
            _valorInicialController.text.isNotEmpty) {
          final valorInicial = double.tryParse(_valorInicialController.text) ?? 0.0;

          // Calcular o valor final corrigido
          _valorFinal = calcularValorFinal(valorInicial, _dataInicial!, _dataFinal!);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Correção de Valores 2'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _valorInicialController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Valor Inicial',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selecionarData(context, true),
              child: Text(_dataInicial == null
                  ? 'Selecionar Data Inicial'
                  : 'Data Inicial: ${_dataInicial!.day}/${_dataInicial!.month}/${_dataInicial!.year}'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selecionarData(context, false),
              child: Text(_dataFinal == null
                  ? 'Selecionar Data Final'
                  : 'Data Final: ${_dataFinal!.day}/${_dataFinal!.month}/${_dataFinal!.year}'),
            ),
            SizedBox(height: 20),
            if (_valorFinal != null)
              Text(
                'Valor Final Corrigido: R\$ ${_valorFinal!.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
