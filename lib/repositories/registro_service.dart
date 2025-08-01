import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:uniconecta/config/api/api_config.dart';
import 'package:uniconecta/models/registro/subida_imagen_response.dart';
import 'package:uniconecta/models/registro/usuario_registrado_response.dart';

class RegistroService {
  Future<SubidaImagenResponse> subirImagen(File? imagen) async {
    if (imagen == null) {
      return SubidaImagenResponse(status: '', mensaje: '', url: '');
    }

    // Subida de la imagen
    final uri = Uri.parse(ApiConfig.subirImagen);
    final request = http.MultipartRequest('POST', uri);

    final stream = http.ByteStream(imagen.openRead());
    final length = await imagen.length();

    // final multipartFile = http.MultipartFile(
    //   'magen',
    //   stream,
    //   length,
    //   filename: basename(imagen.path),
    // );
    final multipartFile = http.MultipartFile(
      'ImagenA',
      stream,
      length,
      filename: basename(imagen.path),
    );

    request.files.add(multipartFile);

    final responseImage = await request.send();

    final respStr = await responseImage.stream.bytesToString();
    final Map<String, dynamic> jsonMap = json.decode(respStr);
    return SubidaImagenResponse.fromJson(jsonMap);
  }

  Future<UsuarioRegistradoResponse> subirDatosRegistro(Map<String, dynamic> datosEnvio) async {
    // POST de toda la data registrada
    final url = Uri.parse(ApiConfig.insertarRegistro);

    final response = await http.post(
      url,
      headers: ApiConfig.defaultHeaders,
      body: jsonEncode(datosEnvio),
    );

    final data = jsonDecode(response.body);

    return UsuarioRegistradoResponse.fromJson(data);
  }
}
