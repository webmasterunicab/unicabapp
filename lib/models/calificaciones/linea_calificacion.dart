class LineaCalificacion {
  final String shortname;
  final String pensamiento;
  final String periodo;
  final String sigla;
  final String calificacion;
  final String criterioEvaluacion;
  final String descripcionValoracionInstitucional;
  final String escalaValoracionInstitucional;

  LineaCalificacion( 
      {required this.periodo, required this.sigla, required this.shortname,
      required this.calificacion,
      required this.criterioEvaluacion,
      required this.descripcionValoracionInstitucional,
      required this.escalaValoracionInstitucional,
      required this.pensamiento});

      factory LineaCalificacion.fromJson(Map<String, dynamic> json){
        return LineaCalificacion(
          shortname: json['shortname'] ?? '', 
          calificacion: json['calificacion'] ?? '', 
          criterioEvaluacion: json['criterio_evaluacion'] ?? '', 
          descripcionValoracionInstitucional: json['descripcion_valoracion_institucional'] ?? '', 
          escalaValoracionInstitucional: json['escala_valoracion_institucional'] ?? '', 
          periodo: json['idnumber'] ?? '', 
          sigla: json['sigla'] ?? '',
          pensamiento: json['pensamiento'] ?? ''
          );
      }
}
