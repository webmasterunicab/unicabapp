import 'package:flutter/material.dart';

class ScreenNameDisplay extends StatelessWidget {
  const ScreenNameDisplay({super.key, required this.name, this.suffix, this.suffixSize = 50});

  final Widget? suffix;
  final double? suffixSize;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.16),
            blurRadius: 6,
            offset: Offset(0, 3)
          )
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: suffixSize),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 9),
            child: Text(
              name,
              style: TextStyle(
                color: Color.fromRGBO(134, 132, 129, 1),
                fontFamily: 'Roboto',
                fontSize: 13,
                fontWeight: FontWeight.w600
              ),
            ),
          ),

          if (suffix != null)
            SizedBox(width: suffixSize, child: suffix!)
          else
            SizedBox(width: suffixSize),
        ]
      ),
    );
  }
}