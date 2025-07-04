class News {
  final String id;
  final String titulo;
  final String texto;
  final String descripcion;
  final String foto;
  final String createdAt;
  final String updatedAt;

  News({
    required this.id,
    required this.titulo,
    required this.texto,
    required this.descripcion,
    required this.foto,
    required this.createdAt,
    required this.updatedAt,
  });

  // Constructor para crear desde un Map (para JSON de API)
  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'] ?? '',
      titulo: json['titulo'] ?? '',
      texto: json['texto'] ?? '',
      descripcion: json['descripcion'] ?? '',
      foto: json['foto'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  // Constructor para crear desde un Map (para base de datos)
  factory News.fromMap(Map<String, dynamic> map) {
    return News(
      id: map['id']?.toString() ?? '',
      titulo: map['titulo'] ?? '',
      texto: map['texto'] ?? '',
      descripcion: map['descripcion'] ?? '',
      foto: map['foto'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  // Convertir a Map (para base de datos)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'texto': texto,
      'descripcion': descripcion,
      'foto': foto,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  // Convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'texto': texto,
      'descripcion': descripcion,
      'foto': foto,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  // Constructor para copiar con modificaciones
  News copyWith({
    String? id,
    String? titulo,
    String? texto,
    String? descripcion,
    String? foto,
    String? createdAt,
    String? updatedAt,
  }) {
    return News(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      texto: texto ?? this.texto,
      descripcion: descripcion ?? this.descripcion,
      foto: foto ?? this.foto,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'News{id: $id, titulo: $titulo, texto: $texto, descripcion: $descripcion, foto: $foto, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is News &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          titulo == other.titulo &&
          texto == other.texto &&
          descripcion == other.descripcion &&
          foto == other.foto &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      id.hashCode ^
      titulo.hashCode ^
      texto.hashCode ^
      descripcion.hashCode ^
      foto.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
