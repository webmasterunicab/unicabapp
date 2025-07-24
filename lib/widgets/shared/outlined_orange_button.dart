import 'package:flutter/material.dart';

class OrangeOutlinedButton extends StatelessWidget {
  const OrangeOutlinedButton({super.key, required this.buttonText, required this.onPressed, this.width, this.height});

  final double? width;
  final double? height;

  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,

      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 9),
          
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),  
          ),
      
          side: BorderSide(
            color: Color.fromRGBO(255, 152, 5, 1),
            width: 1
          )
        ),
      
        
        onPressed: onPressed, 
      
        child: Text(
          buttonText,
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.black,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}