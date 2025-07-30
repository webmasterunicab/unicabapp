import 'dart:convert';
import 'package:http/http.dart';
import 'package:uniconecta/models/inicio_sesion/response_login.dart';

class InicioSesionHelper {

  Future<ResponseLogin> sendLoginRequest(String email, String password) async {
    Uri url = Uri.parse('http://192.168.1.2/hostuniconecta/requests/inicioSesion/sesionVerify.php');
    Response response = await post(
      url, 

      headers: {
        'Content-Type': 'application/json',
      },

      body: jsonEncode({
        'email': email,
        'password': password
      })
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final ResponseLogin result = ResponseLogin.fromJson(data);

      return result;
    } else {
      return ResponseLogin(canLogin: false, message: 'Ha ocurrido un error, intentelo mas tarde.');
    }
  } 

}