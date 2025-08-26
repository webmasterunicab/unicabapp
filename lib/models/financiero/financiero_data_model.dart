class FinancieroDataModel {
  FinancieroDataModel({
    required this.pensionesPagas,
    required this.interesNoPago, 
    required this.totalPagado, 
    required this.saldoPendiente
  });

  final int pensionesPagas;
  final int interesNoPago;
  final int totalPagado;
  final int saldoPendiente;

  factory FinancieroDataModel.fromJson(Map<String, dynamic> json) {
    return FinancieroDataModel(
      pensionesPagas: int.tryParse(json['cantidad_pensiones_pagas']) ?? 0,
      interesNoPago: int.tryParse(json['valor_recargo']) ?? 0,
      totalPagado: int.tryParse(json['total_pagado']) ?? 0,
      saldoPendiente: int.tryParse(json['saldo_pendiente']) ?? 0,
    );
  }
}