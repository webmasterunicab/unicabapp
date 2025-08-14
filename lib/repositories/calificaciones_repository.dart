import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:uniconecta/config/api/api_config.dart';
import 'package:uniconecta/models/calificaciones/estudiante_calificaciones_response.dart';

class CalificacionesRepository {
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
