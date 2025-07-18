import 'package:flutter/material.dart';

class ButtonExtrasAcuerdos extends StatelessWidget {
  const ButtonExtrasAcuerdos({super.key, required this.text, required this.iconPath});

  final String text;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 93,
      height: 71,
      child: TextButton(
        onPressed: () => {}, 
        style: TextButton.styleFrom(
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          textStyle: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 8,
          ),

          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))
        ),
      
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath, height: 20, width: 20,),
            SizedBox(height: 4,),
            Text(text, textAlign: TextAlign.center,),
          ],
        )
      ),
    );
  }
}