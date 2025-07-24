import 'package:flutter/material.dart';
import 'package:uniconecta/screens/general/general_screen.dart';
import 'package:uniconecta/widgets/inicio_sesion/campo_sesion.dart';
import 'package:uniconecta/widgets/inicio_sesion/custom_button_sesion.dart';
import 'package:uniconecta/widgets/shared/navegationBar/main_navegation_bar.dart';
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
                    MainNavegationBar(navType: NavBarTypes.noBody),
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 51),
                            child: Image.asset(
                              'assets/img/LOGO UNICONECTA.png',
                              width: 154,
                              height: 54,
                            ),
                          ),
                          const SizedBox(height: 138),
      
                          CampoSesion(fieldLabel: "Usuario"),
                          const SizedBox(height: 47),
      
                          CampoSesion(fieldLabel: "Contraseña"),
                          const SizedBox(height: 36),
      
                          OrangeButton(
                            buttonText: "Iniciar Sesión",
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => GeneralScreen()), (Route<dynamic> route) => false);
                            },
                            textWeight: FontWeight.w600,
                          ),
                          const SizedBox(height: 42),
      
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
