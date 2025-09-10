class ResponseRecoverPass {

  ResponseRecoverPass({required this.recoverStatus, required this.message});
  
  final bool recoverStatus;
  final String message;

  factory ResponseRecoverPass.fromJson(Map<String, dynamic> json) {
    return ResponseRecoverPass(
      recoverStatus: (json['estado'] == "CorreoOK"),
      message: json['mensaje'] ?? '',
    );
  }
  
}