import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/general/estudiante.dart';

class EstudianteService {
  // Obtener un estudiante por ID
  static Future<Estudiante?> obtenerEstudiantePorId(String id) async {
    try {
      final url = Uri.parse('${ApiConfig.estudiantesUrl}?id=$id');

      final response = await http
          .get(
            url,
            headers: ApiConfig.defaultHeaders,
          )
          .timeout(ApiConfig.defaultTimeout);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        // Verificar diferentes estructuras de respuesta
        List<dynamic>? estudiantesData;

        // Estructura 1: {"success": true, "data": [...]}
        if (jsonResponse['success'] == true && jsonResponse['data'] != null) {
          final data = jsonResponse['data'];
          if (data is List) {
            estudiantesData = data;
          } else if (data is Map<String, dynamic>) {
            estudiantesData = [data];
          }
        }
        // Estructura 2: {"estudiantes": [...]}
        else if (jsonResponse['estudiantes'] != null) {
          final estudiantes = jsonResponse['estudiantes'];
          if (estudiantes is List) {
            estudiantesData = estudiantes;
          } else if (estudiantes is Map<String, dynamic>) {
            estudiantesData = [estudiantes];
          }
        }

        // Buscar el estudiante por ID
        if (estudiantesData != null && estudiantesData.isNotEmpty) {
          // Si se especifica un ID, buscar ese estudiante específico
          for (final estudianteJson in estudiantesData) {
            if (estudianteJson is Map<String, dynamic>) {
              final estudianteId = estudianteJson['id']?.toString();
              if (estudianteId == id) {
                return Estudiante.fromJson(estudianteJson);
              }
            }
          }

          // Si no se encuentra por ID específico, devolver el primero (para compatibilidad)
          if (estudiantesData.isNotEmpty &&
              estudiantesData[0] is Map<String, dynamic>) {
            return Estudiante.fromJson(estudiantesData[0]);
          }
        }

        return null;
      } else {
        throw Exception('Error al obtener estudiante: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Obtener todos los estudiantes (opcional)
  static Future<List<Estudiante>> obtenerTodosLosEstudiantes() async {
    try {
      final url = Uri.parse(ApiConfig.estudiantesUrl);

      final response = await http
          .get(
            url,
            headers: ApiConfig.defaultHeaders,
          )
          .timeout(ApiConfig.defaultTimeout);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        List<dynamic>? estudiantesData;

        // Estructura 1: {"success": true, "data": [...]}
        if (jsonResponse['success'] == true && jsonResponse['data'] != null) {
          final data = jsonResponse['data'];
          if (data is List) {
            estudiantesData = data;
          }
        }
        // Estructura 2: {"estudiantes": [...]}
        else if (jsonResponse['estudiantes'] != null) {
          final estudiantes = jsonResponse['estudiantes'];
          if (estudiantes is List) {
            estudiantesData = estudiantes;
          }
        }

        if (estudiantesData != null) {
          return estudiantesData
              .whereType<Map<String, dynamic>>()
              .map((json) => Estudiante.fromJson(json))
              .toList();
        }

        return [];
      } else {
        throw Exception('Error al obtener estudiantes: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
