import 'package:uniconecta/models/calificaciones/estudiante_modelo.dart';

class AcudienteResponse {
  final String status;
  final String mensaje;
  final List<EstudianteModelo> estudiantes;

  AcudienteResponse(
      {required this.status, required this.mensaje, required this.estudiantes});
}
