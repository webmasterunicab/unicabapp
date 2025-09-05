import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:uniconecta/config/api/api_config.dart';
import 'package:uniconecta/models/calificaciones/estudiantes_acudiente_response.dart';
import 'package:uniconecta/models/calificaciones/estudiantes_grado_response.dart';
import 'package:uniconecta/models/calificaciones/grados_response.dart';

class IntermediaRepository {
  Future<GradosResponse> obtenerGrados() async {
    final url = Uri.parse(ApiConfig.grados);

    final response = await http
        .get(
          url,
          headers: ApiConfig.defaultHeaders,
        )
        .timeout(ApiConfig.defaultTimeout);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body);
      return GradosResponse.fromJson(data);
    } else {
      return GradosResponse(
        status: 'error',
        mensaje: '¡Ha ocurrido un error inesperado, inténtalo más tarde!',
        grados: [],
      );
    }
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

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body);
      return EstudiantesGradoResponse.fromJson(data);
    } else {
      return EstudiantesGradoResponse(
        status: 'error',
        mensaje: '¡Ha ocurrido un error inesperado, inténtalo más tarde!',
        estudiantes: [],
      );
    }
  }

  Future<EstudiantesAcudienteResponse> obtenerEstudiantesPorAcudiente(
      Map<String, dynamic> datosEnvio) async {
    final url = Uri.parse(ApiConfig.estudiantesAcudiente);

    final request = http.Request("GET", url)
      ..headers.addAll(ApiConfig.defaultHeaders)
      ..body = jsonEncode(datosEnvio);

    final streamedResponse = await request.send();

    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body);
      return EstudiantesAcudienteResponse.fromJson(data);
    } else {
      return EstudiantesAcudienteResponse(
        status: 'error',
        mensaje: '¡Ha ocurrido un error inesperado, inténtalo más tarde!',
        estudiantes: [],
      );
    }
  }
}
