import 'inscripcion.dart';

class Calificacion {
  final String id;
  final String inscripcionId;
  final double nota;
  final String periodo;
  final String fechaPublicacion;
  final String? descripcion;
  final String enProceso;
  final int orden;

  final Inscripcion? inscripcion;

  Calificacion({
    required this.id,
    required this.inscripcionId,
    required this.nota,
    required this.periodo,
    required this.fechaPublicacion,
    this.descripcion,
    required this.enProceso,
    required this.orden,
    this.inscripcion,
  });

  factory Calificacion.fromJson(Map<String, dynamic> json) {
    return Calificacion(
      id: json['id']?.toString() ?? '',
      inscripcionId: json['inscripcion_id']?.toString() ?? '',
      nota: json['nota'] != null
          ? double.tryParse(json['nota'].toString()) ?? 0.0
          : 0.0,
      periodo: json['periodo'] ?? '',
      fechaPublicacion: json['fecha_publicacion'] ?? '',
      descripcion: json['descripcion'],
      enProceso: json['en_proceso']?.toString() ?? '0',
      orden: json['orden'] != null
          ? int.tryParse(json['orden'].toString()) ?? 0
          : 0,
      inscripcion: json['inscripcion_data'] != null
          ? Inscripcion.fromJson(json['inscripcion_data'])
          : null,
    );
  }

  String get nombreMateria =>
      inscripcion?.nombreMateria ?? 'Materia sin nombre';
  String get nombreEstudiante =>
      inscripcion?.nombreEstudiante ?? 'Estudiante sin nombre';
  String get notaFormateada => nota.toStringAsFixed(1);
  bool get estaEnProceso => enProceso == '1';
  String get estadoProceso => estaEnProceso ? 'En proceso' : 'Finalizado';

  @override
  String toString() => 'Calificacion{id: $id, nota: $nota, periodo: $periodo}';
}
