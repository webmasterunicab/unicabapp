import '../general/estudiante.dart';
import 'materia.dart';

class Inscripcion {
  final String id;
  final String estudianteId;
  final String materiaId;
  final String fechaInscripcion;
  final String activo;

  final Estudiante? estudiante;
  final Materia? materia;

  Inscripcion({
    required this.id,
    required this.estudianteId,
    required this.materiaId,
    required this.fechaInscripcion,
    required this.activo,
    this.estudiante,
    this.materia,
  });

  factory Inscripcion.fromJson(Map<String, dynamic> json) {
    return Inscripcion(
      id: json['id']?.toString() ?? '',
      estudianteId: json['estudiante_id']?.toString() ?? '',
      materiaId: json['materia_id']?.toString() ?? '',
      fechaInscripcion: json['fecha_inscripcion'] ?? '',
      activo: json['activo']?.toString() ?? '1',
      estudiante: json['estudiante_data'] != null
          ? Estudiante.fromJson(json['estudiante_data'])
          : null,
      materia: json['materia_data'] != null
          ? Materia.fromJson(json['materia_data'])
          : (json['materia_nombre'] != null)
              ? Materia.fromJson({
                  'id': json['materia_id']?.toString() ?? '',
                  'nombre': json['materia_nombre'] ?? '',
                  'codigo': json['materia_codigo'],
                  'descripcion': json['materia_descripcion'],
                  'activo': '1',
                })
              : null,
    );
  }

  String get nombreMateria => materia?.nombre ?? 'Materia sin nombre';
  String get codigoMateria => materia?.codigo ?? '';
  String get descripcionMateria => materia?.descripcion ?? '';
  String get nombreEstudiante => estudiante?.nombre ?? 'Estudiante sin nombre';

  @override
  String toString() =>
      'Inscripcion{id: $id, estudianteId: $estudianteId, materiaId: $materiaId}';
}
