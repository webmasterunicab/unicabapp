class StudentModel {
  StudentModel({required this.name, required this.document});

  String name;
  String document;

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      name: json['nombre'] ?? '', 
      document: json['documento'] ?? ''
    );
  }
}
