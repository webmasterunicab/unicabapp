import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomButtonSesion extends StatelessWidget {
  const CustomButtonSesion({super.key, required this.buttonText, required this.onPressed});
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed, 

      child: Text(
        buttonText,
        style: TextStyle(
          fontFamily: 'Roboto',
          color: Color.fromRGBO(255, 152, 5, 1),
          fontSize: 15.sp
        ),
      ),
    );
  }
}