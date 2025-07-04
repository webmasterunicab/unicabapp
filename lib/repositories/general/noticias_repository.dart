import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/general/news.dart';
import '../../config/api_config.dart';

class NewsRepository {
  // Obtener noticias más recientes
  Future<List<News>> getRecentNews({int limit = 6}) async {
    try {
      final response = await http
          .get(
            Uri.parse(ApiConfig.noticiasUrl),
            headers: ApiConfig.defaultHeaders,
          )
          .timeout(ApiConfig.defaultTimeout);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['noticias'] != null) {
          final List<dynamic> noticiasJson = jsonData['noticias'];
          final news = noticiasJson.map((json) => News.fromJson(json)).toList();

          // Ordenar por fecha de creación descendente (más recientes primero)
          news.sort((a, b) => b.createdAt.compareTo(a.createdAt));

          return news.take(limit).toList();
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
    await getRecentNews();
  }
}
