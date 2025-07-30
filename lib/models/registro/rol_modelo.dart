class RolModelo {
  final String id;
  final String nombreRol;

  RolModelo({required this.id, required this.nombreRol});

   factory RolModelo.fromJson(Map<String, dynamic> json) {
    return RolModelo(
      id: json['id'] ?? '',
      nombreRol: json['rol'] ?? '',
    );
  }
  
}