import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:uniconecta/config/api/api_config.dart';
import 'package:uniconecta/models/calificaciones/estudiante_calificaciones_response.dart';
import 'package:uniconecta/models/calificaciones/estudiantes_acudiente_response.dart';
import 'package:uniconecta/models/calificaciones/estudiantes_grado_response.dart';
import 'package:uniconecta/models/calificaciones/grados_response.dart';

class CalificacionesRepository {
  Future<GradosResponse> obtenerGrados() async {
    final url = Uri.parse(ApiConfig.grados);

    final response = await http
        .get(
          url,
          headers: ApiConfig.defaultHeaders,
        )
        .timeout(ApiConfig.defaultTimeout);

    final data = jsonDecode(response.body);
    return GradosResponse.fromJson(data);

    // return GradosResponse(status: 'error', mensaje: 'Ocurrio un error inesperado', grados: []);
  }

  Future<EstudiantesGradoResponse> obtenerEstudiantesPorGrado(
      Map<String, dynamic> datosEnvio) async {
    // final urlLocal = Uri.parse(ApiConfig.usuariosRolesL);
    final url = Uri.parse(ApiConfig.estudiantesGrado);

    final response = await http
        .post(
          url,
          body: jsonEncode(datosEnvio),
          headers: ApiConfig.defaultHeaders,
        )
        .timeout(ApiConfig.defaultTimeout);

    final data = jsonDecode(response.body);
    return EstudiantesGradoResponse.fromJson(data);
  }

  Future<EstudiantesAcudienteResponse> obtenerEstudiantesPorAcudiente(
      Map<String, dynamic> datosEnvio) async {
    // final urlLocal = Uri.parse(ApiConfig.usuariosRolesL);
    final url = Uri.parse(ApiConfig.estudiantesAcudiente);

    final response = await http
        .post(
          url,
          body: jsonEncode(datosEnvio),
          headers: ApiConfig.defaultHeaders,
        )
        .timeout(ApiConfig.defaultTimeout);

    final data = jsonDecode(response.body);
    return EstudiantesAcudienteResponse.fromJson(data);
  }

    Future<EstudianteCalificacionesResponse> obtenerCalificaciones(
      Map<String, dynamic> datosEnvio) async {
    // final urlLocal = Uri.parse(ApiConfig.usuariosRolesL);
    final url = Uri.parse(ApiConfig.estudiantesCalificaciones);

    final response = await http
        .post(
          url,
          body: jsonEncode(datosEnvio),
          headers: ApiConfig.defaultHeaders,
        )
        .timeout(ApiConfig.defaultTimeout);

    final data = jsonDecode(response.body);

    return EstudianteCalificacionesResponse.fromJson(data);
  }
}
