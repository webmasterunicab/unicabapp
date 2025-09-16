import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/models/calificaciones/linea_calificacion.dart';
import 'package:uniconecta/widgets/calificaciones/calificaciones_especificas.dart';
import 'package:uniconecta/widgets/calificaciones/screen_name_pensamiento.dart';
import 'package:uniconecta/widgets/shared/navegationBar/main_navegation_bar.dart';

class CalificacionesEspecificasScreen extends StatelessWidget {
  final String tituloPensamiento;
  final String estudiante;
  final List<LineaCalificacion> calificaciones;

  const CalificacionesEspecificasScreen({
    super.key,
    required this.tituloPensamiento,
    required this.calificaciones,
    required this.estudiante,
  });
  Widget mostrarNombreEstudiante() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.16),
              blurRadius: 6,
              offset: Offset(0, 3))
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2.h),
      child: Text(
        estudiante.toUpperCase(),
        style: TextStyle(
            color: Color.fromRGBO(134, 132, 129, 1),
            fontFamily: 'Roboto',
            fontSize: 13,
            fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MainNavegationBar(navType: NavBarTypes.navegating),
          ScreenNameDisplayPensamiento(name: tituloPensamiento),
          const SizedBox(height: 15),
          mostrarNombreEstudiante(),
          const SizedBox(height: 5),
          Expanded(
            child: CalificacionesEspecificas(calificaciones: calificaciones),
          ),
        ],
      ),
    );
  }
}
