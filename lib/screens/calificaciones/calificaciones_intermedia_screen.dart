import 'package:flutter/material.dart';
import 'package:uniconecta/widgets/calificaciones/dropdowns_calificaciones.dart';
import 'package:uniconecta/widgets/shared/navegationBar/main_navegation_bar.dart';
import 'package:uniconecta/widgets/shared/screen_name_display.dart';

class CalificacionesIntermediaScreen extends StatelessWidget {
  const CalificacionesIntermediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column( 
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MainNavegationBar(navType: NavBarTypes.alternative),
          SizedBox(height: 25),
          ScreenNameDisplay(name: "CALIFICACIONES"),
          SizedBox(height: 25),
          DropdownsCalificaciones(),
        ],
      ),
    );
  }
}