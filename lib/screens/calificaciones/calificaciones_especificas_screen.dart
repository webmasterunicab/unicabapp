import 'package:flutter/material.dart';
import 'package:uniconecta/models/calificaciones/linea_calificacion.dart';
import 'package:uniconecta/widgets/calificaciones/calificaciones_especificas.dart';
import 'package:uniconecta/widgets/shared/navegationBar/main_navegation_bar.dart';
import 'package:uniconecta/widgets/shared/screen_name_display.dart';

class CalificacionesEspecificasScreen extends StatelessWidget {
  final String tituloPensamiento;
  final List<LineaCalificacion> calificaciones;

  const CalificacionesEspecificasScreen({
    super.key,
    required this.tituloPensamiento,
    required this.calificaciones,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MainNavegationBar(navType: NavBarTypes.navegating),
          const SizedBox(height: 25),
          ScreenNameDisplay(name: tituloPensamiento),
          const SizedBox(height: 25),
          Expanded(
            child: CalificacionesEspecificas(calificaciones: calificaciones),
          ),
        ],
      ),
    );
  }
}
