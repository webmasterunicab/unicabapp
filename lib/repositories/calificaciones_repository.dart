import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:uniconecta/config/api/api_config.dart';
import 'package:uniconecta/models/calificaciones/estudiante_calificaciones_response.dart';

class CalificacionesRepository {
  Future<EstudianteCalificacionesResponse> obtenerCalificaciones(
      Map<String, dynamic> datosEnvio) async {

    final url = Uri.parse(ApiConfig.estudiantesCalificaciones);


    final request = http.Request("GET", url)
      ..headers.addAll(ApiConfig.defaultHeaders)
      ..body = jsonEncode(datosEnvio);


    final streamedResponse = await request.send();


    final response = await http.Response.fromStream(streamedResponse);


    final data = jsonDecode(response.body);

    return EstudianteCalificacionesResponse.fromJson(data);
  }
}
