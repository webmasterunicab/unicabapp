import 'package:flutter/material.dart';
import 'package:uniconecta/widgets/calificaciones/pensamientos_grid.dart';
import 'package:uniconecta/widgets/shared/navegationBar/main_navegation_bar.dart';
import 'package:uniconecta/widgets/shared/screen_name_display.dart';

class CalificacionesScreen extends StatelessWidget {
  final int rol;
  final String email;

  const CalificacionesScreen(
      {super.key, required this.rol, required this.email});

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
          PensamientosGrid(rol: rol, email: email,),
        ],
      ),
    );
  }
}
