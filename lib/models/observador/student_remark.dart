import 'package:uniconecta/models/observador/follow_up_model.dart';
import 'package:uniconecta/models/observador/remark_model.dart';

class StudentRemark {
  
  StudentRemark({
    required this.name,
    required this.hasAssessment,
    required this.assessmentId,
    required this.assessmentDependency,
    required this.assessmentCharge,
    required this.assessmentDate,
    required this.assessmentReason,
    required this.assessmentPersonality,
    required this.assessmentGeneral,
    required this.hasFollowUps,
    required this.followUps,
    required this.hasRemarks,
    required this.remarks,
  });

  String name;

  bool hasAssessment;
  int assessmentId;

  String assessmentDependency;
  String assessmentCharge;
  String assessmentDate;
  String assessmentReason;
  String assessmentPersonality;
  String assessmentGeneral;

  bool hasFollowUps;
  List<FollowUpModel> followUps;
            
  bool hasRemarks;
  List<RemarkModel> remarks;

  factory StudentRemark.fromJson(Map<String, dynamic> json) {
    return StudentRemark(
      name: json['nombre'] ?? '', 

      hasAssessment: (json['conValoracion'] == 'SI'),
      assessmentId: (json['idValoracion'] is String) 
        ? int.tryParse(json['idValoracion']) ?? 0 
        : json['idValoracion'] ?? 0, 

      assessmentDependency: json['dependenciaValoracion'] ?? '', 
      assessmentCharge: json['cargoValoracion'] ?? '', 
      assessmentDate: json['fechaValoracion'] ?? '', 
      assessmentReason: json['motivoValoracion'] ?? '', 
      assessmentPersonality: json['personalidadValoracion'] ?? '', 
      assessmentGeneral: json['generalValoracion'] ?? '', 

      hasFollowUps: (json['conSeguimientos'] == 'SI'), 
      followUps: (json['seguimientos'] as List<dynamic>?)
        ?.map((e) => FollowUpModel.fromJson(e as Map<String, dynamic>))
        .toList() ?? [],

      hasRemarks: (json['conObservacionesTutores'] == 'SI'), 
      remarks: (json['observacionesTutores'] as List<dynamic>?)
        ?.map((e) => RemarkModel.fromJson(e as Map<String, dynamic>))
        .toList() ?? []
    );
  }
}