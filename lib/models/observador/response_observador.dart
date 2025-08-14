import 'package:uniconecta/models/observador/student_model.dart';
import 'package:uniconecta/models/observador/student_remark.dart';

class ResponseObservador {

  ResponseObservador({
    this.message, 
    required this.students, 
    required this.finalRemarks
  });
  
  String? message;

  List<StudentModel> students;
  List<StudentRemark> finalRemarks;

  factory ResponseObservador.fromJson(Map<String, dynamic> json) {
    return ResponseObservador(
      message: json['mensaje'] ?? '',

      students: (json['estudiantes'] as List<dynamic>?)
        ?.map((e) => StudentModel.fromJson(e as Map<String, dynamic>))
        .toList() ?? [],

      finalRemarks: (json['observacionesFinales'] as List<dynamic>?)
        ?.map((e) => StudentRemark.fromJson(e as Map<String, dynamic>))
        .toList() ?? []
    );
  }
}
