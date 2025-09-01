import 'package:uniconecta/models/financiero/financiero_data_model.dart';

class FinancieroResponseModel {
  
  final bool financieroCargado;
  final FinancieroDataModel? financieroData;

  FinancieroResponseModel({
    required this.financieroCargado,
    this.financieroData,
  });

  factory FinancieroResponseModel.fromJson(Map<String, dynamic> json) {
    return FinancieroResponseModel(
      financieroCargado: (json['status'] == 'success') ? true : false,
      financieroData: (json['financiera'] != null) 
        ? FinancieroDataModel.fromJson(json['financiera'].first as Map<String, dynamic>? ?? {})
        : null
    );
  }
}