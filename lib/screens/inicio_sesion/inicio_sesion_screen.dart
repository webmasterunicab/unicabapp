import 'package:flutter/material.dart';
import 'package:uniconecta/widgets/shared/orange_button.dart';

class InicioSesion extends StatelessWidget {
  const InicioSesion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(11, 119, 179, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset('assets/img/LOGO UNICONECTA.png'),
            SizedBox(height: 36),

            _SesionField(fieldLabel: "Usuario"),
            SizedBox(height: 92),

            _SesionField(fieldLabel: "Contraseña"),
            SizedBox(height: 36),

            OrangeButton(buttonText: "Iniciar Sesión"),
            SizedBox(height: 42),

            _CustomOrangeButton(buttonText: "Olvide mi contraseña"),
          ],
        ),
      ),
    );
  }
}

class _CustomOrangeButton extends StatelessWidget {
  const _CustomOrangeButton({required this.buttonText});
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {}, 

      child: Text(
        buttonText,
        style: TextStyle(
          color: Color.fromRGBO(255, 152, 5, 1),
          fontSize: 15
        ),
      ),
    );
  }
}

class _SesionField extends StatelessWidget {
  const _SesionField({
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
          ),

        ]
      ),
    );
  }
}