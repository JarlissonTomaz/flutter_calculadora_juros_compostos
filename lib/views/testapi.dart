import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Para carregar o arquivo local

class DatePickerExample extends StatefulWidget {
  const DatePickerExample({super.key});

  @override
  _DatePickerExampleState createState() => _DatePickerExampleState();
}

class _DatePickerExampleState extends State<DatePickerExample> {
  DateTime? _selectedDate; // Data selecionada no DatePicker
  String? _valor; // Valor correspondente à data selecionada
  List<Map<String, dynamic>> _dados = []; // Lista de dados carregados

  @override
  void initState() {
    super.initState();
    carregarDados(); // Carregar os dados ao iniciar o app
  }

  // Carregar os dados do arquivo local (ou poderia ser uma API)
  Future<void> carregarDados() async {
    final String response =
        await rootBundle.loadString('assets/dados.json'); // Arquivo local
    final List<dynamic> dados = json.decode(response);

    setState(() {
      _dados = dados.cast<Map<String, dynamic>>();
    });
  }

  // Método para buscar o valor correspondente à data
  String? buscarValor(String dataFormatada) {
    final item = _dados.firstWhere(
      (item) => item['data'] == dataFormatada,
  
    );
    return item?['valor'];
  }

  // Exibir o DatePicker
  Future<void> _selecionarData(BuildContext context) async {
    final dataEscolhida = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1987),
      lastDate: DateTime.now(),
    );

    if (dataEscolhida != null) {
      setState(() {
        _selectedDate = dataEscolhida;

        // Formatar a data no formato "DD/MM/AAAA" para correspondência
        final dataFormatada =
            "${dataEscolhida.day.toString().padLeft(2, '0')}/${dataEscolhida.month.toString().padLeft(2, '0')}/${dataEscolhida.year}";

        // Buscar o valor correspondente
        _valor = buscarValor(dataFormatada);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar Valor por Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _selectedDate == null
                  ? 'Nenhuma data selecionada'
                  : 'Data selecionada: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selecionarData(context),
              child: Text('Selecionar Data'),
            ),
            SizedBox(height: 20),
            if (_valor != null)
              Text('Valor: $_valor')
            else if (_selectedDate != null)
              Text('Nenhum valor encontrado para a data selecionada.'),
          ],
        ),
      ),
    );
  }
}
