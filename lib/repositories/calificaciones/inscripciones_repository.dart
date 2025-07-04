import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../config/api_config.dart';
import '../../models/calificaciones/materia.dart';

class InscripcionesRepository {
  // Obtener datos específicos de una materia por su ID
  Future<Materia?> obtenerMateriaPorId(String materiaId) async {
    try {
      final url = Uri.parse(
          '${ApiConfig.materiasUrl}?id=$materiaId');

      final response = await http
          .get(
            url,
            headers: ApiConfig.defaultHeaders,
          )
          .timeout(ApiConfig.defaultTimeout);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        Map<String, dynamic>? materiaData;

        // Manejar diferentes estructuras de respuesta
        if (jsonResponse['success'] == true && jsonResponse['data'] != null) {
          final data = jsonResponse['data'];
          if (data is Map<String, dynamic>) {
            materiaData = data;
          } else if (data is List && data.isNotEmpty) {
            materiaData = data.first;
          }
        } else if (jsonResponse['materia'] != null) {
          materiaData = jsonResponse['materia'];
        } else if (jsonResponse['materias'] != null &&
            jsonResponse['materias'].isNotEmpty) {
          materiaData = jsonResponse['materias'].first;
        }

        if (materiaData != null) {
          try {
            final materia = Materia.fromJson(materiaData);
            return materia;
          } catch (e) {
            //print('⚠️ Error al procesar materia: $e');
            //print('⚠️ Datos de la materia: $materiaData');
          }
        }

        return null;
      } else {
        throw Exception('Error al obtener materia: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Obtener múltiples materias por sus IDs
  Future<List<Materia>> obtenerMateriasPorIds(List<String> materiaIds) async {
    List<Materia> materias = [];

    for (String materiaId in materiaIds) {
      try {
        final materia = await obtenerMateriaPorId(materiaId);
        if (materia != null) {
          materias.add(materia);
        }
      } catch (e) {
        // Continuar con las siguientes materias aunque una falle
      }
    }

    return materias;
  }
}
