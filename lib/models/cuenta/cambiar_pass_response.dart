class CambiarPassResponse {
  bool status;
  String mensaje;

  CambiarPassResponse({
    required this.status,
    required this.mensaje,
  });

  factory CambiarPassResponse.fromJson(Map<String, dynamic> json) {
    return CambiarPassResponse(
      status: (json['status'] == "success"), 
      mensaje: json['mensaje'] ?? ''
    );
  }
}
