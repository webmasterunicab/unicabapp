class SubidaImagenResponse {
  final String status;
  final String mensaje;
  final String url;

  SubidaImagenResponse({required this.status, required this.mensaje, required this.url});

   factory SubidaImagenResponse.fromJson(Map<String, dynamic> json) {
    return SubidaImagenResponse(
      status: json['status'] ?? '',
      mensaje: json['mensaje'] ?? '',
      url: json['url'] ?? '',
    );
  }
  
}