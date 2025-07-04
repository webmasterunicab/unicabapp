class Menu {
  final String id;
  final String titulo;
  final String enlace;
  final String createdAt;
  final String updatedAt;

  Menu({
    required this.id,
    required this.titulo,
    required this.enlace,
    required this.createdAt,
    required this.updatedAt,
  });

  // Constructor para crear desde un Map (para JSON de API)
  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'] ?? '',
      titulo: json['titulo'] ?? '',
      enlace: json['enlace'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  // Constructor para crear desde un Map (para base de datos)
  factory Menu.fromMap(Map<String, dynamic> map) {
    return Menu(
      id: map['id']?.toString() ?? '',
      titulo: map['titulo'] ?? '',
      enlace: map['enlace'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  // Convertir a Map (para base de datos)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'enlace': enlace,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  // Convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'enlace': enlace,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  // Constructor para copiar con modificaciones
  Menu copyWith({
    String? id,
    String? titulo,
    String? enlace,
    String? createdAt,
    String? updatedAt,
  }) {
    return Menu(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      enlace: enlace ?? this.enlace,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'Menu{id: $id, titulo: $titulo, enlace: $enlace, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Menu &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          titulo == other.titulo &&
          enlace == other.enlace &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      id.hashCode ^
      titulo.hashCode ^
      enlace.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
