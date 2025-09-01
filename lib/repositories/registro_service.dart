import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uniconecta/config/api/api_config.dart';
import 'package:uniconecta/models/registro/subida_imagen_response.dart';
import 'package:uniconecta/models/registro/usuario_registrado_response.dart';

class RegistroService {
  // Future<SubidaImagenResponse> subirImagen(File? imagen) async {
  //   if (imagen == null) {
  //     return SubidaImagenResponse(status: '', mensaje: '', url: '');
  //   }

  //   // Subida de la imagen
  //   final uri = Uri.parse(ApiConfig.subirImagen);
  //   final request = http.MultipartRequest('POST', uri);

  //   final stream = http.ByteStream(imagen.openRead());
  //   final length = await imagen.length();

  //   // final multipartFile = http.MultipartFile(
  //   //   'magen',
  //   //   stream,
  //   //   length,
  //   //   filename: basename(imagen.path),
  //   // );
  //   final multipartFile = http.MultipartFile(
  //     'ImagenA',
  //     stream,
  //     length,
  //     filename: basename(imagen.path),
  //   );

  //   request.files.add(multipartFile);

  //   final responseImage = await request.send();

  //   final respStr = await responseImage.stream.bytesToString();
  //   final Map<String, dynamic> jsonMap = json.decode(respStr);
  //   return SubidaImagenResponse.fromJson(jsonMap);
  // }

  // Future<UsuarioRegistradoResponse> subirDatosRegistro(
  //     Map<String, dynamic> datosEnvio) async {
  //   // POST de toda la data registrada
  //   // final urlLocal = Uri.parse(ApiConfig.registrarUsuarioL);
  //   final url = Uri.parse(ApiConfig.registrarUsuario);

  //   // final responseLocal = await http.post(
  //   //   urlLocal,
  //   //   headers: ApiConfig.defaultHeaders,
  //   //   body: jsonEncode(datosEnvio),
  //   // ).timeout(ApiConfig.defaultTimeout);

  //   // final dataL = jsonDecode(responseLocal.body);

  //   // print(UsuarioRegistradoResponse.fromJson(dataL));

  //   final response = await http.post(
  //     url,
  //     headers: ApiConfig.defaultHeaders,
  //     body: jsonEncode(datosEnvio),
  //   );

  //   final data = jsonDecode(response.body);

  //   return UsuarioRegistradoResponse.fromJson(data);
  // }

  Future<UsuarioRegistradoResponse> subirDatosRegistro(
      Map<String, dynamic> datosEnvio) async {
    final uri = Uri.parse(ApiConfig.registrarUsuario);
    final request = http.MultipartRequest('POST', uri);

    request.fields['rol'] = datosEnvio['rol'];
    request.fields['nombre'] = datosEnvio['nombre'];
    request.fields['correo'] = datosEnvio['correo'];
    request.fields['pass'] = datosEnvio['pass'];
    request.fields['ciudad'] = datosEnvio['ciudad'];
    request.fields['cumpleaños'] = datosEnvio['cumpleaños'];
    request.fields['lugaresVisitados'] = datosEnvio['lugaresVisitados'];
    request.fields['porqueUnicab'] = datosEnvio['porqueUnicab'];
    request.fields['proceso'] = datosEnvio['proceso'];
    request.fields['pass_registro_academico'] =
        datosEnvio['pass_registro_academico'] ?? '';

// Imagen con nombre original
    if (datosEnvio['ImagenA'] != null &&
        datosEnvio['originalFileName'] != null) {
      final file = await http.MultipartFile.fromPath(
        'ImagenA',
        datosEnvio['ImagenA'].path,
        filename: datosEnvio['originalFileName'],
      );
      request.files.add(file);
    } else {
      request.fields['ImagenA'] = '';
    }

    final response = await request.send();

    final respStr = await response.stream.bytesToString();

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final Map<String, dynamic> jsonMap = json.decode(respStr);
      return UsuarioRegistradoResponse.fromJson(jsonMap);
    } else {
      return UsuarioRegistradoResponse(
          statusImg: '',
          mensajeImg: '',
          status: 'error',
          mensaje: '¡Ha ocurrido un error inesperado, inténtalo más tarde!');
    }
  }

  Future<SubidaImagenResponse> actualizarFotoPerfil(
      Map<String, dynamic> datosEnvio) async {
    final uri = Uri.parse(ApiConfig.actualizarFotoPerfil);
    final request = http.MultipartRequest('POST', uri);

    request.fields['rol'] = datosEnvio['rol'];
    request.fields['email'] = datosEnvio['email'];

// Imagen con nombre original
    if (datosEnvio['ImagenA'] != null &&
        datosEnvio['originalFileName'] != null) {
      final file = await http.MultipartFile.fromPath(
        'ImagenA',
        datosEnvio['ImagenA'].path,
        filename: datosEnvio['originalFileName'].trim().replaceAll(" ", "_"),
      );
      request.files.add(file);
    } else {
      request.fields['ImagenA'] = '';
    }

    final response = await request.send();

    final respStr = await response.stream.bytesToString();

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final Map<String, dynamic> jsonMap = json.decode(respStr);
      return SubidaImagenResponse.fromJson(jsonMap);
    } else {
      return SubidaImagenResponse(
          status: 'error',
          mensaje: '¡Ha ocurrido un error inesperado, inténtalo más tarde!',
          url: '');
    }
  }
}
