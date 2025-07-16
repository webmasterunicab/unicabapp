import 'package:flutter/material.dart';

class OrangeButton extends StatelessWidget {
  const OrangeButton({super.key, required this.buttonText, required this.onPressed});

  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Color.fromRGBO(255, 152, 5, 1),
        padding: EdgeInsets.all(20),
        
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        )
      ),

      onPressed: onPressed, 

      child: Text(
        buttonText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15
        ),
      ),
    );
  }
}