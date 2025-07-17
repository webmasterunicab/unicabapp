import 'package:flutter/material.dart';
import 'package:uniconecta/widgets/inicio_sesion/campo_sesion.dart';
import 'package:uniconecta/widgets/inicio_sesion/custom_button_sesion.dart';
import 'package:uniconecta/widgets/shared/main_navegation_bar.dart';
import 'package:uniconecta/widgets/shared/orange_button.dart';

class InicioSesion extends StatelessWidget {
  const InicioSesion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(11, 119, 179, 1),
      body: Center(
        child: Column(
          children: [
            MainNavegationBar(navType: NavBarTypes.noBody, canGoBack: true), // App bar custom
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/img/LOGO UNICONECTA.png',
                    width: 154,
                    height: 54,
                  ),
                  SizedBox(height: 25),
              
                  CampoSesion(fieldLabel: "Usuario"),
                  SizedBox(height: 30),
              
                  CampoSesion(fieldLabel: "Contraseña"),
                  SizedBox(height: 30),
              
                  OrangeButton(
                    buttonText: "Iniciar Sesión", 
                    onPressed: () {
              
                    },
                  ),
                  SizedBox(height: 30),
              
                  CustomButtonSesion(
                    buttonText: "Olvide mi contraseña", 
                    onPressed: () {
                    
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}