import 'package:flutter/material.dart';

class BotonAzulObservador extends StatelessWidget {
  const BotonAzulObservador({super.key, required this.buttonText, this.prefix, this.weight = FontWeight.w600, this.fontSize = 10, this.paddingRadius = const EdgeInsets.all(15)});

  final String buttonText;
  final Widget? prefix;
  final FontWeight? weight;
  final double? fontSize;
  final EdgeInsets paddingRadius;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},

      style: TextButton.styleFrom(
        backgroundColor: Color.fromRGBO(11, 119, 179, 1),
        padding: paddingRadius,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6))
        )
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (prefix != null) ...[prefix!, SizedBox(width: 3)],

          Text(buttonText, style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: weight,
            color: Colors.white,
            fontSize: fontSize
          ))
        ],
      )
    );
  }
}