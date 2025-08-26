import 'package:uniconecta/models/comunidad/publicacion.dart';

class PublicacionesResponse {
  final String status;
  final String mensaje;
  final String email;
  final List<Publicacion> publicaciones;

  PublicacionesResponse(
      {required this.status,
      required this.mensaje,
      required this.email,
      required this.publicaciones});

  factory PublicacionesResponse.fromJson(Map<String, dynamic> json) {
    final List jsonList = json['publicaciones'] ?? [];

    final publicacionesList =
        jsonList.map((e) => Publicacion.fromJson(e)).toList();

    return PublicacionesResponse(
        status: json['status'] ?? '',
        mensaje: json['mensaje'] ?? '',
        email: json['email'] ?? '',
        publicaciones: publicacionesList);
  }
}
