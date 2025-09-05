import 'dart:convert';

import 'package:http/http.dart';
import 'package:uniconecta/config/api/api_config.dart';
import 'package:uniconecta/models/cuenta/cambiar_pass_response.dart';

class CambiarPasswordRepository {

  static Future<CambiarPassResponse> sendRequest({required String email, required int role, required String newPassword}) async {
    // uri parse for the post
    Uri url = Uri.https(ApiConfig.https, ApiConfig.cambiarPassword);

    Request getRequest = Request("POST", url)
      ..headers.addAll(ApiConfig.defaultHeaders)
      ..body = jsonEncode({
        'email': email,
        'rol': role,
        'pass': newPassword
      });

    final StreamedResponse streamed = await getRequest.send().timeout(ApiConfig.defaultTimeout);

    //post to the url with the api config
    Response response = await Response.fromStream(streamed);

    //response management here
    if (response.statusCode == 200) {
      return CambiarPassResponse.fromJson(jsonDecode(response.body));

    } else {
      return CambiarPassResponse(status: false, mensaje: "Ha ocurrido un error, intentelo mas tarde.");
    }
  }

}