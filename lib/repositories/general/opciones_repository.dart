import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/general/options.dart';
import '../../config/api_config.dart';

class OptionsRepository {
  // Obtener todas las opciones desde la API
  Future<List<Options>> getAllOptions() async {
    try {
      final response = await http
          .get(
            Uri.parse(ApiConfig.opcionesUrl),
            headers: ApiConfig.defaultHeaders,
          )
          .timeout(ApiConfig.defaultTimeout);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['opciones'] != null) {
          final List<dynamic> opcionesJson = jsonData['opciones'];

          final options = opcionesJson
              .map((json) => Options.fromJson(json))
              .where((option) => option.isActive) // Solo opciones activas
              .toList();

          // Ordenar por el campo 'orden'
          options.sort((a, b) {
            final ordenA = int.tryParse(a.orden) ?? 999;
            final ordenB = int.tryParse(b.orden) ?? 999;
            return ordenA.compareTo(ordenB);
          });

          return options;
        } else {
          throw Exception('Formato de respuesta JSON inválido');
        }
      } else {
        throw Exception('Error HTTP: ${response.statusCode}');
      }
    } catch (e) {
      return [];
    }
  }

  // Método para compatibilidad con código existente
  Future<void> initializeWithSampleData() async {
    await getAllOptions();
  }
}
