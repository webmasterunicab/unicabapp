import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uniconecta/config/api/api_config.dart';
import 'package:uniconecta/models/cuenta/eliminar_cuenta_response.dart';
import 'package:uniconecta/models/registro/subida_imagen_response.dart';
import 'package:uniconecta/models/registro/usuario_registrado_response.dart';

class UsuarioService {
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

  Future<EliminarCuentaResponse> eliminarCuenta(
      Map<String, dynamic> datosEnvio) async {
    final uri = Uri.parse(ApiConfig.eliminarCuenta);

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "rol": datosEnvio['rol'],
        "email": datosEnvio['email'],
      }),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final respStr = response.body;
      final Map<String, dynamic> jsonMap = json.decode(respStr);
      return EliminarCuentaResponse.fromJson(jsonMap);
    } else {
      return EliminarCuentaResponse(
        status: 'error',
        mensaje: '¡Ha ocurrido un error inesperado, inténtalo más tarde!',
        megustaComentarios: '',
        megustaPublicaciones: '',
        comentariosPublicaciones: '',
        imagenes: '',
        publicaciones: '',
        fotoPerfil: '',
        usuarios: '',
      );
    }
  }
}
