import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../config/api_config.dart';
import '../../models/calificaciones/inscripcion.dart';

class MateriasRepository {
  // Obtener inscripciones del estudiante (desde materias_estudiante.php)
  Future<List<Inscripcion>> obtenerInscripcionesPorEstudiante(
      String estudianteId) async {
    try {
      final url = Uri.parse(
          '${ApiConfig.materiasEstudianteUrl}?id=$estudianteId');

      final response = await http
          .get(
            url,
            headers: ApiConfig.defaultHeaders,
          )
          .timeout(ApiConfig.defaultTimeout);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        List<dynamic>? inscripcionesData;

        // Manejar diferentes estructuras de respuesta
        if (jsonResponse['success'] == true && jsonResponse['data'] != null) {
          inscripcionesData = jsonResponse['data'];
        } else if (jsonResponse['inscripciones'] != null) {
          inscripcionesData = jsonResponse['inscripciones'];
        } else if (jsonResponse['materias_estudiante'] != null) {
          inscripcionesData = jsonResponse['materias_estudiante'];
        }

        if (inscripcionesData != null && inscripcionesData.isNotEmpty) {
          List<Inscripcion> inscripciones = [];

          for (final inscripcionJson in inscripcionesData) {
            if (inscripcionJson is Map<String, dynamic>) {
              try {
                final inscripcion = Inscripcion.fromJson(inscripcionJson);
                inscripciones.add(inscripcion);
              } catch (e) {
                //print('⚠️ Error al procesar inscripción: $e');
                //print('⚠️ Datos de la inscripción: $inscripcionJson');
              }
            }
          }

          return inscripciones;
        }

        return [];
        } else {
        throw Exception(
            'Error al obtener inscripciones del estudiante: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('❌ Exception en obtenerInscripcionesPorEstudiante: $e');
      rethrow;
    }
  }
}
