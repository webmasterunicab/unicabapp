class Estudiante {
  final String id;
  final String nombre;
  final String foto;
  final String? email;
  final String? carrera;
  final int? semestre;
  final String activo;
  final String createdAt;
  final String updatedAt;

  Estudiante({
    required this.id,
    required this.nombre,
    required this.foto,
    this.email,
    this.carrera,
    this.semestre,
    required this.activo,
    required this.createdAt,
    required this.updatedAt,
  });

  // Constructor para crear desde un Map (para JSON de API)
  factory Estudiante.fromJson(Map<String, dynamic> json) {
    return Estudiante(
      id: json['id'] ?? '',
      nombre: json['nombre'] ?? '',
      foto: json['foto'] ?? '',
      email: json['email'],
      carrera: json['carrera'],
      semestre: json['semestre'] != null
          ? int.tryParse(json['semestre'].toString())
          : null,
      activo: json['activo']?.toString() ?? '1',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  // Constructor para crear desde un Map (para base de datos)
  factory Estudiante.fromMap(Map<String, dynamic> map) {
    return Estudiante(
      id: map['id']?.toString() ?? '',
      nombre: map['nombre'] ?? '',
      foto: map['foto'] ?? '',
      email: map['email'],
      carrera: map['carrera'],
      semestre: map['semestre'] != null
          ? int.tryParse(map['semestre'].toString())
          : null,
      activo: map['activo']?.toString() ?? '1',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  // Convertir a Map (para base de datos)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'foto': foto,
      'email': email,
      'carrera': carrera,
      'semestre': semestre,
      'activo': activo,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  // Convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'foto': foto,
      'email': email,
      'carrera': carrera,
      'semestre': semestre,
      'activo': activo,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  // Constructor para copiar con modificaciones
  Estudiante copyWith({
    String? id,
    String? nombre,
    String? foto,
    String? email,
    String? carrera,
    int? semestre,
    String? activo,
    String? createdAt,
    String? updatedAt,
  }) {
    return Estudiante(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      foto: foto ?? this.foto,
      email: email ?? this.email,
      carrera: carrera ?? this.carrera,
      semestre: semestre ?? this.semestre,
      activo: activo ?? this.activo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'Estudiante{id: $id, nombre: $nombre, foto: $foto, email: $email, carrera: $carrera, semestre: $semestre, activo: $activo, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Estudiante &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          nombre == other.nombre &&
          foto == other.foto &&
          email == other.email &&
          carrera == other.carrera &&
          semestre == other.semestre &&
          activo == other.activo &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      id.hashCode ^
      nombre.hashCode ^
      foto.hashCode ^
      email.hashCode ^
      carrera.hashCode ^
      semestre.hashCode ^
      activo.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
