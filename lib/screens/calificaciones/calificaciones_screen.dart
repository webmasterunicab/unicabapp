import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/widgets/calificaciones/pensamientos_grid.dart';
import 'package:uniconecta/widgets/shared/navegationBar/main_navegation_bar.dart';
import 'package:uniconecta/widgets/shared/screen_name_display.dart';

class CalificacionesScreen extends StatelessWidget {
  final int rol;
  final String email;
  final String nombreEstudiante;

  const CalificacionesScreen(
      {super.key,
      required this.rol,
      required this.email,
      required this.nombreEstudiante});

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
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1.h),
      child: Text(
        nombreEstudiante.toUpperCase(),
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
    /*return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MainNavegationBar(navType: NavBarTypes.alternative),
          SizedBox(height: 1.h),
          ScreenNameDisplay(name: "CALIFICACIONES"),
          SizedBox(height: 1.h),
          mostrarNombreEstudiante(),
          SizedBox(height: 1.h),
          PensamientosGrid(
            rol: rol,
            email: email,
            estudiante: nombreEstudiante,
          ),
        ],
      ),
    );*/

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MainNavegationBar(navType: NavBarTypes.alternative),
              SizedBox(height: 1.h),
              ScreenNameDisplay(name: "CALIFICACIONES"),
              SizedBox(height: 1.h),
              mostrarNombreEstudiante(),
              SizedBox(height: 1.h),
              PensamientosGrid(
                rol: rol,
                email: email,
                estudiante: nombreEstudiante,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
