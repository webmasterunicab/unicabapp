class Materia {
  final String id;
  final String nombre;
  final String? codigo;
  final String? descripcion;
  final String activo;

  Materia({
    required this.id,
    required this.nombre,
    this.codigo,
    this.descripcion,
    required this.activo,
  });

  factory Materia.fromJson(Map<String, dynamic> json) {
    return Materia(
      id: json['id']?.toString() ?? '',
      nombre: json['nombre'] ?? json['nombre_materia'] ?? '',
      codigo: json['codigo'] ?? json['codigo_materia'],
      descripcion: json['descripcion'],
      activo: json['activo']?.toString() ?? '1',
    );
  }

  @override
  String toString() => 'Materia{id: $id, nombre: $nombre}';
}
