import 'package:uniconecta/models/shared/user.dart';

class ResponseLogin {

  ResponseLogin({this.user, required this.canLogin, required this.message});
  
  final bool canLogin;
  final String message;
  final User? user;

  factory ResponseLogin.fromJson(Map<String, dynamic> json) {
    return ResponseLogin(
      canLogin: (json['status'] == 'success') ? true : false,
      message: json['mensaje'] ?? '',
      user: (json['registro'] != null) ? User.fromJson(json['registro']) : null,
    );
  }
  
}