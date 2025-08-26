import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:uniconecta/config/api/api_config.dart';
import 'package:uniconecta/models/comunidad/grado_response.dart';
import 'package:uniconecta/models/comunidad/mis_publicaciones_response.dart';
import 'package:uniconecta/models/generic_response.dart';

class ComunidadRepository {
  Future<GradoResponse> obtenerGradoEstudiante(
      Map<String, dynamic> datosEnvio) async {
    final url = Uri.parse(ApiConfig.estudianteGrado);

    final request = http.Request("POST", url)
      ..headers.addAll(ApiConfig.defaultHeaders)
      ..body = jsonEncode(datosEnvio);

    final streamedResponse = await request.send();

    final response = await http.Response.fromStream(streamedResponse);

    final data = jsonDecode(response.body);

    return GradoResponse.fromJson(data);
  }

  Future<GenericResponse> subirPublicacion(
      Map<String, dynamic> datosEnvio) async {
    final uri = Uri.parse(ApiConfig.subirPublicacion);
    final request = http.MultipartRequest('POST', uri);

    request.fields['email'] = datosEnvio['email'];
    request.fields['rol'] = datosEnvio['rol'];
    request.fields['texto'] = datosEnvio['texto'];

    if (datosEnvio['ImgPublicacion'] != null) {
      final stream = http.ByteStream(datosEnvio['ImgPublicacion'].openRead());
      final length = await datosEnvio['ImgPublicacion'].length();

      final multipartFile = http.MultipartFile(
        'ImgPublicacion',
        stream,
        length,
        filename: basename(datosEnvio['ImgPublicacion'].path),
      );

      request.files.add(multipartFile);
    } else {
      request.fields['ImgPublicacion'] = '';
    }

    final response = await request.send();

    final respStr = await response.stream.bytesToString();

    final Map<String, dynamic> jsonMap = json.decode(respStr);

    return GenericResponse.fromJson(jsonMap);
  }

  Future<PublicacionesResponse> obtenerMisPublicaciones(
      Map<String, dynamic> datosEnvio) async {
    final url = Uri.parse(ApiConfig.obtenerMisPublicaciones);

    final request = http.Request("POST", url)
      ..headers.addAll(ApiConfig.defaultHeaders)
      ..body = jsonEncode(datosEnvio);

    final streamedResponse = await request.send();

    final response = await http.Response.fromStream(streamedResponse);

    final data = jsonDecode(response.body);

    return PublicacionesResponse.fromJson(data);
  }

    Future<PublicacionesResponse> obtenerTodasPublicaciones(
      Map<String, dynamic> datosEnvio) async {
    final url = Uri.parse(ApiConfig.obtenerTodasPublicaciones);

    final request = http.Request("POST", url)
      ..headers.addAll(ApiConfig.defaultHeaders)
      ..body = jsonEncode(datosEnvio);

    final streamedResponse = await request.send();

    final response = await http.Response.fromStream(streamedResponse);

    final data = jsonDecode(response.body);

    return PublicacionesResponse.fromJson(data);
  }

  Future<GenericResponse> darLikePublicacion(Map<String, dynamic> datosEnvio) async {
    final url = Uri.parse(ApiConfig.darLikePublicacion);

    final request = http.Request("POST", url)
      ..headers.addAll(ApiConfig.defaultHeaders)
      ..body = jsonEncode(datosEnvio);

    final streamedResponse = await request.send();

    final response = await http.Response.fromStream(streamedResponse);

    final data = jsonDecode(response.body);

    return GenericResponse.fromJson(data);
  }
}
