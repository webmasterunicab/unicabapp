class UsuarioRegistradoResponse {
  final String status;
  final String mensaje;

  UsuarioRegistradoResponse({required this.status, required this.mensaje});

   factory UsuarioRegistradoResponse.fromJson(Map<String, dynamic> json) {
    return UsuarioRegistradoResponse(
      status: json['status'] ?? '',
      mensaje: json['mensaje'] ?? '',
    );
  }
  
}