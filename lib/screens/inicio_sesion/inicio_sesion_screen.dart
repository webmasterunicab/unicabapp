import 'package:flutter/material.dart';
import 'package:uniconecta/widgets/inicio_sesion/campo_sesion.dart';
import 'package:uniconecta/widgets/inicio_sesion/custom_button_sesion.dart';
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

            Image.asset(
              'assets/img/LOGO UNICONECTA.png',
              width: 154,
              height: 54,
            ),
            SizedBox(height: 42),

            CampoSesion(fieldLabel: "Usuario"),
            SizedBox(height: 36),

            CampoSesion(fieldLabel: "Contraseña"),
            SizedBox(height: 36),

            OrangeButton(
              buttonText: "Iniciar Sesión", 
              onPressed: () {
                
              },
            ),
            SizedBox(height: 42),

            CustomButtonSesion(
              buttonText: "Olvide mi contraseña", 
              onPressed: () {
              
              },
            ),
          ],
        ),
      ),
    );
  }
}