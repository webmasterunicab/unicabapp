import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/calificaciones/materia.dart';
import '../models/calificaciones/calificacion.dart';
import '../models/calificaciones/inscripcion.dart';

class MateriasService {
  // URL específica para materias por estudiante
  static String get materiasEstudianteUrl =>
      '${ApiConfig.baseUrl}/materias_estudiante.php';

  // Obtener las materias que ve un estudiante específico
  static Future<List<Materia>> obtenerMateriasPorEstudiante(
      String estudianteId) async {
    try {
      final url = Uri.parse('$materiasEstudianteUrl?id=$estudianteId');

      final response = await http
          .get(
            url,
            headers: ApiConfig.defaultHeaders,
          )
          .timeout(ApiConfig.defaultTimeout);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        List<dynamic>? materiasData;

        // Estructura 1: {"success": true, "data": [...]}
        if (jsonResponse['success'] == true && jsonResponse['data'] != null) {
          final data = jsonResponse['data'];
          if (data is List) {
            materiasData = data;
          }
        }
        // Estructura 2: {"materias": [...]}
        else if (jsonResponse['materias'] != null) {
          final materias = jsonResponse['materias'];
          if (materias is List) {
            materiasData = materias;
          }
        }
        // Estructura 3: {"estudiante_materias": [...]}
        else if (jsonResponse['estudiante_materias'] != null) {
          final estudianteMaterias = jsonResponse['estudiante_materias'];
          if (estudianteMaterias is List) {
            materiasData = estudianteMaterias;
          }
        }

        if (materiasData != null && materiasData.isNotEmpty) {
          List<Materia> materias = [];

          for (final materiaJson in materiasData) {
            if (materiaJson is Map<String, dynamic>) {
              try {
                final materia = Materia.fromJson(materiaJson);
                materias.add(materia);
              } catch (e) {
                //print('⚠️ Error al procesar materia: $e');
                //print('⚠️ Datos de la materia: $materiaJson');
              }
            }
          }

          return materias;
        }

        return [];
      } else {
        throw Exception(
            'Error al obtener materias del estudiante: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Obtener todas las materias disponibles (opcional)
  static Future<List<Materia>> obtenerTodasLasMaterias() async {
    try {
      // Usar el endpoint base de materias sin parámetro ID
      final url = Uri.parse(materiasEstudianteUrl);

      final response = await http
          .get(
            url,
            headers: ApiConfig.defaultHeaders,
          )
          .timeout(ApiConfig.defaultTimeout);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        List<dynamic>? materiasData;

        if (jsonResponse['success'] == true && jsonResponse['data'] != null) {
          final data = jsonResponse['data'];
          if (data is List) {
            materiasData = data;
          }
        } else if (jsonResponse['materias'] != null) {
          final materias = jsonResponse['materias'];
          if (materias is List) {
            materiasData = materias;
          }
        }

        if (materiasData != null) {
          return materiasData
              .whereType<Map<String, dynamic>>()
              .map((json) => Materia.fromJson(json))
              .toList();
        }

        return [];
      } else {
        throw Exception('Error al obtener materias: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Obtener calificaciones del estudiante por materia (si el endpoint las devuelve)
  static Future<List<Calificacion>> obtenerCalificacionesPorEstudiante(
      String estudianteId) async {
    try {
      final url = Uri.parse(
          '$materiasEstudianteUrl?id=$estudianteId&incluir_calificaciones=true');

      final response = await http
          .get(
            url,
            headers: ApiConfig.defaultHeaders,
          )
          .timeout(ApiConfig.defaultTimeout);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        List<dynamic>? calificacionesData;

        if (jsonResponse['success'] == true && jsonResponse['data'] != null) {
          final data = jsonResponse['data'];
          if (data is List) {
            calificacionesData = data;
          }
        } else if (jsonResponse['calificaciones'] != null) {
          final calificaciones = jsonResponse['calificaciones'];
          if (calificaciones is List) {
            calificacionesData = calificaciones;
          }
        }

        if (calificacionesData != null) {
          return calificacionesData
              .whereType<Map<String, dynamic>>()
              .map((json) => Calificacion.fromJson(json))
              .toList();
        }

        return [];
      } else {
        throw Exception(
            'Error al obtener calificaciones: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Obtener inscripciones del estudiante
  static Future<List<Inscripcion>> obtenerInscripcionesPorEstudiante(
      String estudianteId) async {
    try {
      final url = Uri.parse(
          '${ApiConfig.baseUrl}/inscripciones_estudiante.php?id=$estudianteId');

      final response = await http
          .get(
            url,
            headers: ApiConfig.defaultHeaders,
          )
          .timeout(ApiConfig.defaultTimeout);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        List<dynamic>? inscripcionesData;

        if (jsonResponse['success'] == true && jsonResponse['data'] != null) {
          final data = jsonResponse['data'];
          if (data is List) {
            inscripcionesData = data;
          }
        } else if (jsonResponse['inscripciones'] != null) {
          final inscripciones = jsonResponse['inscripciones'];
          if (inscripciones is List) {
            inscripcionesData = inscripciones;
          }
        }

        if (inscripcionesData != null) {
          return inscripcionesData
              .whereType<Map<String, dynamic>>()
              .map((json) => Inscripcion.fromJson(json))
              .toList();
        }

        return [];
      } else {
        throw Exception(
            'Error al obtener inscripciones: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
