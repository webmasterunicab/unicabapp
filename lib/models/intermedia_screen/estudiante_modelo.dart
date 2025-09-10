class EstudianteModelo {
  final String nombre;
  final String documento;
  final String correo;

  EstudianteModelo(
      {required this.nombre, required this.documento, required this.correo});

  factory EstudianteModelo.fromJson(Map<String, dynamic> json) {
    return EstudianteModelo(
        nombre: json['nombre'] ?? '',
        documento: json['documento'] ?? '',
        correo: json['correo'] ?? ''
        );
  }
}
