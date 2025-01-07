import 'dart:convert';
import 'package:http/http.dart' as http;

// Função para buscar os dados
Future<List<Map<String, dynamic>>> buscarDados() async {
  final url = Uri.parse(
      'https://api.bcb.gov.br/dados/serie/bcdata.sgs.11/dados?formato=json');
  final resposta = await http.get(url);

  if (resposta.statusCode == 200) {
    // Decodifica o JSON em uma lista de mapas
    final List<dynamic> dados = json.decode(resposta.body);
    return dados.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Erro ao carregar os dados: ${resposta.statusCode}');
  }
}
