import 'package:uniconecta/models/intermedia_screen/estudiante_modelo.dart';

class EstudiantesGradoResponse {
  final String status;
  final String mensaje;
  final List<EstudianteModelo> estudiantes;

  EstudiantesGradoResponse(
      {required this.status, required this.mensaje, required this.estudiantes});

  factory EstudiantesGradoResponse.fromJson(Map<String, dynamic> json) {
    final List estudiantesJson = json['estudiantes'] ?? [];
    final List<EstudianteModelo> estudiantesLista =
        estudiantesJson.map((e) => EstudianteModelo.fromJson(e)).toList();

    return EstudiantesGradoResponse(
        status: json['status'],
        mensaje: json['mensaje'],
        estudiantes: estudiantesLista);
  }
}
