class FollowUpModel {
  FollowUpModel({
    required this.dependency,
    required this.charge,
    required this.date,
    required this.objective,
    required this.progress,
    required this.studentActions,
    required this.attendantActions,
    required this.commitments,
    required this.isOpen,
  });

  String dependency;
  String charge;
  String date;
  String objective;
  String progress;
  String studentActions;
  String attendantActions;
  String commitments;
  bool isOpen;

  factory FollowUpModel.fromJson(Map<String, dynamic> json) {
    return FollowUpModel(
      dependency: json['dependencia'] ?? '', 
      charge: json['cargo'] ?? '', 
      date: json['fecha'] ?? '', 
      objective: (json['objetivo'] == 'NA') ? '' : json['objetivo'] ?? '', 
      progress: (json['avances'] == 'NA') ? '' : json['avances'] ?? '', 
      studentActions: (json['acciones_est'] == 'NA') ? '' : json['acciones_est'] ?? '', 
      attendantActions: (json['acciones_acu'] == 'NA') ? '' : json['acciones_acu'] ?? '', 
      commitments: (json['compromisos'] == 'NA') ? '' : json['compromisos'] ?? '', 
      isOpen: (json['estado'] == "abierto") ? true : false
    );
  }
}