class RemarkModel {
  RemarkModel({
    required this.dependency,
    required this.charge,
    required this.date,
    required this.remark
  });

  String dependency;
  String charge;
  String date;
  String remark;

  factory RemarkModel.fromJson(Map<String, dynamic> json) {
    return RemarkModel(
      dependency: json['dependencia'] ?? '',
      charge: json['cargo'] ?? '',
      date: json['fecha'] ?? '',
      remark: json['observacion'] ?? ''
    );
  }
}