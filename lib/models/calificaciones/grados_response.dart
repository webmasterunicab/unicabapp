import 'package:uniconecta/models/calificaciones/grado_modelo.dart';

class GradosResponse {
  final String status;
  final String mensaje;
  final List<GradoModelo> grados;

  GradosResponse(
      {required this.status, required this.mensaje, required this.grados});

  factory GradosResponse.fromJson(Map<String, dynamic> json) {
    final List gradosList = json['grados'] ?? [];
    final List<GradoModelo> gradosResponse =
        gradosList.map((e) => GradoModelo.fromJson(e)).toList();

    return GradosResponse(
      status: json['status'] ?? '',
      mensaje: json['mensaje'] ?? '',
      grados: gradosResponse,
    );
  }
}
