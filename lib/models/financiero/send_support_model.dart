class SendSupportModel {
  
  final String message;
  final bool success;

  SendSupportModel({
    required this.message,
    required this.success,
  });

  factory SendSupportModel.fromJson(Map<String, dynamic> json) {
    return SendSupportModel(
      message: json['mensaje'] ?? '',
      success: (json['status'] == "success")
    );
  }

}