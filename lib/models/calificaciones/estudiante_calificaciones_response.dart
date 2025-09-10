import 'package:uniconecta/models/intermedia_screen/estudiante_modelo.dart';
import 'package:uniconecta/models/calificaciones/linea_calificacion.dart';

class EstudianteCalificacionesResponse {
  final String status;
  final String mensaje;
  final int periodo;
  final EstudianteModelo estudiante;
  final List<LineaCalificacion> lineas;

  EstudianteCalificacionesResponse(
      {required this.status,
      required this.mensaje,
      required this.periodo,
      required this.estudiante,
      required this.lineas});

factory EstudianteCalificacionesResponse.fromJson(Map<String, dynamic> json) {
 
  final List<dynamic> lineasJson = json['lineas'] ?? [];

  final List<LineaCalificacion> lineasConvertidas =
      lineasJson.map((e) => LineaCalificacion.fromJson(e)).toList();

  return EstudianteCalificacionesResponse(
    status: json['status'] ?? '',
    mensaje: json['mensaje'] ?? '',
    periodo: json['periodo'] ?? '',
    estudiante: EstudianteModelo.fromJson(json['estudiante']),
    lineas: lineasConvertidas,
  );
}

}
