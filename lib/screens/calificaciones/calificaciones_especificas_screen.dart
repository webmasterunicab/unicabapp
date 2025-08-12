import 'package:flutter/material.dart';
import 'package:uniconecta/widgets/calificaciones/calificaciones_especificas.dart';
import 'package:uniconecta/widgets/shared/navegationBar/main_navegation_bar.dart';
import 'package:uniconecta/widgets/shared/screen_name_display.dart';

class CalificacionesEspecificasScreen extends StatelessWidget {
  const CalificacionesEspecificasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column( 
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MainNavegationBar(navType: NavBarTypes.navegating),
          SizedBox(height: 25),
          ScreenNameDisplay(name: "Pensamiento test"),
          SizedBox(height: 25),
          CalificacionesEspecificas(),
        ],
      ),
    );
  }
} 