class ResponseLogin {

  ResponseLogin({required this.canLogin, required this.message});
  
  final bool canLogin;
  final String message;

  factory ResponseLogin.fromJson(Map<String, dynamic> json) {
    return ResponseLogin(
      canLogin: bool.parse(json['canLogIn']),
      message: json['message'] ?? '',
    );
  }
  
}