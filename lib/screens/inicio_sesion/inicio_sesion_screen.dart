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
      backgroundColor: const Color.fromRGBO(11, 119, 179, 1),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    MainNavegationBar(
                      navType: NavBarTypes.noBody,
                      canGetBackHere: true,
                    ),
      
                    // Este Expanded está dentro del IntrinsicHeight y funciona bien
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/img/LOGO UNICONECTA.png',
                            width: 154,
                            height: 54,
                          ),
                          const SizedBox(height: 25),
      
                          CampoSesion(fieldLabel: "Usuario"),
                          const SizedBox(height: 30),
      
                          CampoSesion(fieldLabel: "Contraseña"),
                          const SizedBox(height: 30),
      
                          OrangeButton(
                            buttonText: "Iniciar Sesión",
                            onPressed: () {},
                            textWeight: FontWeight.w600,
                          ),
                          const SizedBox(height: 30),
      
                          CustomButtonSesion(
                            buttonText: "Olvide mi contraseña",
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
