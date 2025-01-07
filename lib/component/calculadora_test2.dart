
double calcularCorrecao({
  required double valorOriginal,
  required DateTime dataInicial,
  required DateTime dataFinal,
  required Map<DateTime, double> taxasSelicDiarias,
}) {
  double fator = 1.0;

  // Itera sobre cada dia no intervalo
  for (var dia = dataInicial;
      dia.isBefore(dataFinal) || dia.isAtSameMomentAs(dataFinal);
      dia = dia.add(Duration(days: 1))) {
    double taxaDia = taxasSelicDiarias[dia] ?? 0.0;
    fator *= (1 + taxaDia);
  }

  return valorOriginal * fator;
}
