import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:uniconecta/config/api/api_config.dart';
import 'package:uniconecta/models/inicio_sesion/response_login.dart';
import 'package:uniconecta/models/inicio_sesion/response_recover_pass.dart';
import 'package:uniconecta/providers/user_provider.dart';

class InicioSesionRepository {

  static Future<ResponseRecoverPass> sendRecoveryRequest(String email) async {
    // uri parse for the post
    Uri url = Uri.https(ApiConfig.production, ApiConfig.recoverPassword, {'email': email});

    //post to the url with the api config.
    Response response = await get(
      url,
      headers: ApiConfig.defaultHeaders,

    ).timeout(ApiConfig.defaultTimeout);

    //response management here
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final ResponseRecoverPass result = ResponseRecoverPass.fromJson(data);

      return result;
    } else {
      return ResponseRecoverPass(recoverStatus: false, message: 'Ha ocurrido un error, intentelo mas tarde.');
    }
  }

  static Future<ResponseLogin> sendLoginRequest(String email, String password, {required BuildContext context}) async {
    // uri parse for the post
    Uri url = Uri.https(ApiConfig.production, ApiConfig.sesionVerify);

    //post to the url with the api config.
    Response response = await post(
      url, 
      headers: ApiConfig.defaultHeaders,

      body: jsonEncode({
        'email': email,
        'password': password
      })
    ).timeout(ApiConfig.defaultTimeout);

    //response management here
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final ResponseLogin result = ResponseLogin.fromJson(data);

      if (context.mounted) {
        final UserProvider provider = Provider.of<UserProvider>(context, listen: false);
        provider.setUser(result.user);
      }

      return result;
    } else {
      return ResponseLogin(canLogin: false, message: 'Ha ocurrido un error, intentelo mas tarde.');
    }
  } 

}