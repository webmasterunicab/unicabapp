import 'package:flutter/material.dart';
import 'package:uniconecta/widgets/observador_related/boton_azul_observador.dart';
import 'package:uniconecta/widgets/observador_related/resultado_observador.dart';
import 'package:uniconecta/widgets/shared/text_area.dart';
import 'package:uniconecta/widgets/shared/navegationBar/main_navegation_bar.dart';
import 'package:uniconecta/widgets/shared/orange_button.dart';
import 'package:uniconecta/widgets/shared/outlined_orange_button.dart';
import 'package:uniconecta/widgets/shared/screen_name_display.dart';

class ObservadorFaltaScreen extends StatelessWidget {
  const ObservadorFaltaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MainNavegationBar(navType: NavBarTypes.navegating),
                    SizedBox(height: 20),

                    ScreenNameDisplay(name: "OBSERVADOR"),
                    SizedBox(height: 20),

                    OrangeButton(buttonText: "Tipo de falta", onPressed: () {}, textWeight: FontWeight.w600, suffix: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white, size: 30), width: 200,),
                    SizedBox(height: 24),

                    OrangeOutlinedButton(buttonText: "Tipo 1", onPressed: () {}, width: 154,),
                    SizedBox(height: 12),

                    OrangeOutlinedButton(buttonText: "Tipo 2", onPressed: () {}, width: 154,),
                    SizedBox(height: 12),

                    OrangeOutlinedButton(buttonText: "Tipo 3", onPressed: () {}, width: 154,),
                    SizedBox(height: 30),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 33),
                      child: Row(
                        children: [
                          Text("Ingrese la observación", style: TextStyle(fontFamily: 'Roboto', fontSize: 17)),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),

                    Container(margin: EdgeInsets.symmetric(horizontal: 33), child: TextArea(fieldHeight: 136)),
                    SizedBox(height: 35),

                    BotonAzulObservador(buttonText: "Enviar", fontSize: 15, paddingRadius: EdgeInsets.symmetric(horizontal: 56, vertical: 22)),
                    SizedBox(height: 15),

                    ResultadoObservador(operationSuccess: true)
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