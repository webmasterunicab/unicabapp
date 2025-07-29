import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uniconecta/config/api/api_config.dart';
import 'package:uniconecta/models/registro/rol_modelo.dart';

class RolesRepository {
  Future<List<RolModelo>> obtenerRoles() async {
    final url = Uri.parse('${ApiConfig.baseUrl}/registro/roles.php');

     final response = await http.get(
            url,
            headers: ApiConfig.defaultHeaders,
          )
          .timeout(ApiConfig.defaultTimeout);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      final List registros = data['registros'];
      print(registros);
      return registros.map((e) => RolModelo.fromJson(e)).toList();
    } else {
      print('Error: ${response.statusCode}');
    }

    return [];
  }
}
