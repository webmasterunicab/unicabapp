class UsuarioRegistradoResponse {
  final String status;
  final String mensaje;
  final String sentencia;

  UsuarioRegistradoResponse( {required this.status, required this.mensaje, required this.sentencia});

   factory UsuarioRegistradoResponse.fromJson(Map<String, dynamic> json) {
    return UsuarioRegistradoResponse(
      status: json['status'] ?? '',
      mensaje: json['mensaje'] ?? '',
      sentencia: json['sentencia'] ?? '',
    );
  }
  
}