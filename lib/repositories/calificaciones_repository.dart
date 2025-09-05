import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:uniconecta/config/api/api_config.dart';
import 'package:uniconecta/models/calificaciones/estudiante_calificaciones_response.dart';
import 'package:uniconecta/models/intermedia_screen/estudiante_modelo.dart';

class CalificacionesRepository {
  Future<EstudianteCalificacionesResponse> obtenerCalificaciones(
      Map<String, dynamic> datosEnvio) async {
    final url = Uri.parse(ApiConfig.estudiantesCalificaciones);

    final request = http.Request("POST", url)
      ..headers.addAll(ApiConfig.defaultHeaders)
      ..body = jsonEncode(datosEnvio);

    final streamedResponse = await request.send();

    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body);
      return EstudianteCalificacionesResponse.fromJson(data);
    } else {
      return EstudianteCalificacionesResponse(
        status: 'error',
        mensaje: '¡Ha ocurrido un error inesperado, inténtalo más tarde!', 
        periodo: 0, 
        estudiante: EstudianteModelo(nombre: '', documento: '', correo: ''), 
        lineas: [],
      );
    }
  }
}
