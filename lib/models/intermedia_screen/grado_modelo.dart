class GradoModelo {
  final String id;
  final String grado;

  GradoModelo({required this.id, required this.grado});

    factory GradoModelo.fromJson(Map<String, dynamic> json) {
    return GradoModelo(
      id: json['id'] ?? '',
      grado: json['grado'] ?? '',
    );
  }
}