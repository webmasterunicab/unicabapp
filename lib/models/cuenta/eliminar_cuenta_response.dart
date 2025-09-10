class EliminarCuentaResponse {
  String megustaComentarios;
  String megustaPublicaciones;
  String comentariosPublicaciones;
  String imagenes;
  String publicaciones;
  String fotoPerfil;
  String usuarios;
  String status;
  String mensaje;

  EliminarCuentaResponse({
    required this.megustaComentarios,
    required this.megustaPublicaciones,
    required this.comentariosPublicaciones,
    required this.imagenes,
    required this.publicaciones,
    required this.fotoPerfil,
    required this.usuarios,
    required this.status,
    required this.mensaje,
  });

  factory EliminarCuentaResponse.fromJson(Map<String, dynamic> json) {
    return EliminarCuentaResponse(
        megustaComentarios: json['megustaComentarios'] ?? '',
        megustaPublicaciones: json['megustaPublicaciones'] ?? '',
        comentariosPublicaciones: json['comentariosPublicaciones'] ?? '',
        imagenes: json['imagenes'] ?? '',
        publicaciones: json['publicaciones'] ?? '',
        fotoPerfil: json['fotoPerfil'] ?? '',
        usuarios: json['usuarios'] ?? '',
        status: json['status'] ?? '',
        mensaje: json['mensaje'] ?? '');
  }
}
