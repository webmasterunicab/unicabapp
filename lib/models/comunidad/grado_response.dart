class GradoResponse {
  final String status;
  final String mensaje;
  final String grado;

  GradoResponse(
      {required this.status, required this.mensaje, required this.grado});

  factory GradoResponse.fromJson(Map<String, dynamic> json) {
    return GradoResponse(
        status: json['status'] ?? '',
        mensaje: json['mensaje'] ?? '',
        grado: json['grado'] ?? '');
  }
}
