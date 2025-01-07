class CorrectionCalculator {
  static double calcularCorrecao(double valorInicial, List<Map<String, dynamic>> indices) {
    double valorCorrigido = valorInicial;

    for (var indice in indices) {
      valorCorrigido *= (1 + double.parse(indice["valor"]));
    }

    return valorCorrigido;
  }
}
