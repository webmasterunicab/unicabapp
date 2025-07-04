import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../config/api_config.dart';
import '../../models/calificaciones/calificacion.dart';

class CalificacionesRepository {
  // Obtener calificaciones de una inscripción específica
  Future<List<Calificacion>> obtenerCalificacionesPorInscripcion(
      String inscripcionId) async {
    try {
      final url = Uri.parse(
          '${ApiConfig.calificacionesInscripcionUrl}?id=$inscripcionId');

      final response = await http
          .get(
            url,
            headers: ApiConfig.defaultHeaders,
          )
          .timeout(ApiConfig.defaultTimeout);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        List<dynamic>? calificacionesData;

        // Manejar diferentes estructuras de respuesta
        if (jsonResponse['success'] == true && jsonResponse['data'] != null) {
          calificacionesData = jsonResponse['data'];
        } else if (jsonResponse['calificaciones'] != null) {
          calificacionesData = jsonResponse['calificaciones'];
        } else if (jsonResponse['calificaciones_inscripcion'] != null) {
          calificacionesData = jsonResponse['calificaciones_inscripcion'];
        }

        if (calificacionesData != null && calificacionesData.isNotEmpty) {
          List<Calificacion> calificaciones = [];

          for (final calificacionJson in calificacionesData) {
            if (calificacionJson is Map<String, dynamic>) {
              try {
                final calificacion = Calificacion.fromJson(calificacionJson);
                calificaciones.add(calificacion);
              } catch (e) {
                //print('⚠️ Error al procesar calificación: $e');
                //print('⚠️ Datos de la calificación: $calificacionJson');
              }
            }
          }

          return calificaciones;
        }

        return [];
      } else {
        throw Exception(
            'Error al obtener calificaciones de la inscripción: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Obtener calificaciones de múltiples inscripciones
  Future<List<Calificacion>> obtenerCalificacionesPorInscripciones(
      List<String> inscripcionIds) async {
    List<Calificacion> todasLasCalificaciones = [];

    for (String inscripcionId in inscripcionIds) {
      try {
        final calificaciones =
            await obtenerCalificacionesPorInscripcion(inscripcionId);
        todasLasCalificaciones.addAll(calificaciones);
      } catch (e) {
        // Continuar con las siguientes inscripciones aunque una falle
      }
    }

    return todasLasCalificaciones;
  }

  // Obtener promedio de calificaciones (método auxiliar)
  double calcularPromedio(List<Calificacion> calificaciones) {
    if (calificaciones.isEmpty) return 0.0;

    final calificacionesConNota =
        calificaciones.where((c) => c.nota > 0).toList();
    if (calificacionesConNota.isEmpty) return 0.0;

    final suma =
        calificacionesConNota.map((c) => c.nota).reduce((a, b) => a + b);
    return suma / calificacionesConNota.length;
  }
}
