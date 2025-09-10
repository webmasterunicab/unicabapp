import 'dart:convert';

import 'package:http/http.dart';
import 'package:uniconecta/config/api/api_config.dart';
import 'package:uniconecta/models/observador/response_observador.dart';

class ObservadorRepository {
  
  static Future<ResponseObservador> getRemarks({required int role, required String email}) async {
    // uri parse for the post
    Uri url = Uri.https(ApiConfig.https, ApiConfig.getRemarks);

    //post to the url with the api config.
    Response response = await post(
      url, 
      headers: ApiConfig.defaultHeaders,

      body: jsonEncode({
        'email': email,
        'rol': role
      })
    ).timeout(ApiConfig.defaultTimeout);

    //response management here
    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = jsonDecode(response.body);
      final ResponseObservador remarks = ResponseObservador.fromJson(decoded);

      return remarks;

    } else {
      return ResponseObservador(students: [], finalRemarks: []);
    }
  }

}