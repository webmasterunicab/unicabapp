import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/general/menu.dart';
import '../../config/api_config.dart';

class MenuRepository {
  // Obtener menús para dropdown del perfil
  Future<List<Menu>> getProfileMenus() async {
    try {
      final response = await http
          .get(
            Uri.parse(ApiConfig.menusUrl),
            headers: ApiConfig.defaultHeaders,
          )
          .timeout(ApiConfig.defaultTimeout);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['menus'] != null) {
          final List<dynamic> menusJson = jsonData['menus'];
          return menusJson.map((json) => Menu.fromJson(json)).toList();
        } else {
          throw Exception('Formato de respuesta JSON inválido');
        }
      } else {
        throw Exception('Error HTTP: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('❌ Error al obtener menús: $e');
      return [];
    }
  }

  // Método para compatibilidad con código existente
  Future<void> initializeWithSampleData() async {
    await getProfileMenus();
  }
}
