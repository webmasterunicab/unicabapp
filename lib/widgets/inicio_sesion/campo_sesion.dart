import 'package:flutter/material.dart';

class CampoSesion extends StatelessWidget {
  const CampoSesion({
    super.key, 
    required this.fieldLabel, 
  });

  final String fieldLabel;

  @override
  Widget build(BuildContext context) {
    final UnderlineInputBorder border = UnderlineInputBorder(

      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(10),

    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),

      child: Column(
        children: [

          Align(
            alignment: Alignment.topLeft,

            child: Text(
              fieldLabel,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 13,
                color: Colors.white
              ),
            ),

          ),

          SizedBox(height: 9),

          TextFormField(
            decoration: InputDecoration(
              filled: true,
          
              enabledBorder: border,
              focusedBorder: border,
            ),
            
            style: TextStyle(
              fontFamily: 'Roboto'
            ),
          ),

        ]
      ),
    );
  }
}