import 'package:uniconecta/models/calificaciones/estudiante_modelo.dart';

class EstudiantesAcudienteResponse {
  final String status;
  final String mensaje;
  final List<EstudianteModelo> estudiantes;

  EstudiantesAcudienteResponse(
      {required this.status, required this.mensaje, required this.estudiantes});

  factory EstudiantesAcudienteResponse.fromJson(Map<String, dynamic> json) {
    final List gradosList = json['estudiantes'] ?? [];
    final List<EstudianteModelo> estudiantesResponse =
        gradosList.map((e) => EstudianteModelo.fromJson(e)).toList();

    return EstudiantesAcudienteResponse(
      status: json['status'] ?? '',
      mensaje: json['mensaje'] ?? '',
      estudiantes: estudiantesResponse,
    );
  }
}
