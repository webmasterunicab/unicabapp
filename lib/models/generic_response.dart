class GenericResponse {

final String status;
final String mensaje;

  GenericResponse({required this.status, required this.mensaje});

factory GenericResponse.fromJson(Map<String,dynamic> json) {
  return GenericResponse(
    status: json['status'] ?? '', 
    mensaje: json['mensaje'] ?? ''
    );
}

}