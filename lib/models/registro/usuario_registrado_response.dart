class UsuarioRegistradoResponse {
  String statusImg;
  String mensajeImg;
  String status;
  String mensaje;

  UsuarioRegistradoResponse({
    required this.statusImg,
    required this.mensajeImg,
    required this.status,
    required this.mensaje,
  });

  factory UsuarioRegistradoResponse.fromJson(Map<String, dynamic> json) {
    return UsuarioRegistradoResponse(
      status: json['status'] ?? '',
      mensaje: json['mensaje'] ?? '',
      statusImg: json['statusImg'] ?? '',
      mensajeImg: json['mensajeImg'] ?? '',
    );
  }
}
