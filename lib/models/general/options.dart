class Options {
  final String id;
  final String nombre;
  final String imagen;
  final String direccion;
  final String orden;
  final String activo;
  final String createdAt;
  final String updatedAt;

  Options({
    required this.id,
    required this.nombre,
    required this.imagen,
    required this.direccion,
    required this.orden,
    required this.activo,
    required this.createdAt,
    required this.updatedAt,
  });

  // Constructor para crear desde un Map (para JSON de API)
  factory Options.fromJson(Map<String, dynamic> json) {
    return Options(
      id: json['id'] ?? '',
      nombre: json['nombre'] ?? '',
      imagen: json['imagen'] ?? '',
      direccion: json['direccion'] ?? '',
      orden: json['orden'] ?? '',
      activo: json['activo'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  // Constructor para crear desde un Map (para base de datos)
  factory Options.fromMap(Map<String, dynamic> map) {
    return Options(
      id: map['id']?.toString() ?? '',
      nombre: map['nombre'] ?? '',
      imagen: map['imagen'] ?? '',
      direccion: map['direccion'] ?? '',
      orden: map['orden']?.toString() ?? '',
      activo: map['activo']?.toString() ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  // Convertir a Map (para base de datos)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'imagen': imagen,
      'direccion': direccion,
      'orden': orden,
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
      'imagen': imagen,
      'direccion': direccion,
      'orden': orden,
      'activo': activo,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  // Constructor para copiar con modificaciones
  Options copyWith({
    String? id,
    String? nombre,
    String? imagen,
    String? direccion,
    String? orden,
    String? activo,
    String? createdAt,
    String? updatedAt,
  }) {
    return Options(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      imagen: imagen ?? this.imagen,
      direccion: direccion ?? this.direccion,
      orden: orden ?? this.orden,
      activo: activo ?? this.activo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Verificar si la opción está activa
  bool get isActive => activo == '1';

  @override
  String toString() {
    return 'Options{id: $id, nombre: $nombre, imagen: $imagen, direccion: $direccion, orden: $orden, activo: $activo, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Options &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          nombre == other.nombre &&
          imagen == other.imagen &&
          direccion == other.direccion &&
          orden == other.orden &&
          activo == other.activo &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      id.hashCode ^
      nombre.hashCode ^
      imagen.hashCode ^
      direccion.hashCode ^
      orden.hashCode ^
      activo.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
