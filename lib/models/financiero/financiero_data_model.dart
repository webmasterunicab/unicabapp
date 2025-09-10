class FinancieroDataModel {
  final int deudaAnterior;
  final int valorMatricula;

  final int? derechosGradoValor;
  final int? icfesValor;

  final bool derechosGradoPago;
  final bool icfesPago;

  final int pensionesPagas;
  final int pensionesPendientes;
  
  final int interesNoPago;
  final int totalPagado;
  final int saldoPendiente;


  FinancieroDataModel({
    required this.deudaAnterior, 
    required this.valorMatricula, 

    this.derechosGradoValor, 
    this.icfesValor,

    required this.derechosGradoPago,
    required this.icfesPago, 

    required this.pensionesPagas,
    required this.pensionesPendientes,

    required this.interesNoPago, 
    required this.totalPagado, 
    required this.saldoPendiente
  });

  factory FinancieroDataModel.fromJson(Map<String, dynamic> json) {
    int? pensionesPagas = int.tryParse(json['cantidad_pensiones_pagas']);
    int? pensionesTotal = int.tryParse(json['cantidad_pensiones']);

    int pensionesPendientes = (pensionesPagas != null && pensionesTotal != null) 
      ? pensionesTotal - pensionesPagas : 0;

    return FinancieroDataModel(
      pensionesPagas: pensionesPagas ?? 0,
      interesNoPago: int.tryParse(json['valor_recargo']) ?? 0,
      totalPagado: int.tryParse(json['total_pagado']) ?? 0,
      saldoPendiente: int.tryParse(json['saldo_pendiente']) ?? 0, 
      deudaAnterior: int.tryParse(json["deuda_anterior"]) ?? 0,
      valorMatricula: int.tryParse(json["matricula_ocp"]) ?? 0, 
      pensionesPendientes: pensionesPendientes, 

      derechosGradoPago: (json["pago_derechos_grado"] != "NO"), 
      icfesPago: (json['pago_icfes'] == "NO") ? false : true,

      icfesValor: int.tryParse(json["icfes"]),
      derechosGradoValor: int.tryParse(json["derechos_grado"]),
    );
  }
}