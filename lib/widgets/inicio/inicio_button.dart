import 'package:flutter/material.dart';
import 'package:uniconecta/screens/inicio_sesion/inicio_sesion_screen.dart';
import 'package:uniconecta/screens/registro_estudiante/registro_screen.dart';

class InicioButton extends StatelessWidget {
  final String btnNombre;
  final bool bottom;

  const InicioButton({super.key, required this.btnNombre, this.bottom = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final screen = btnNombre.contains("Registro") ? RegistroScreen() : InicioSesion();

        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => screen),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.transparent, // Fondo transparente
          border: Border(
            top: BorderSide(color: Colors.white, width: 1), // Borde superior
            bottom: ((bottom)
                ? BorderSide(color: Colors.white, width: 1)
                : BorderSide(color: Colors.transparent)),
            // Borde inferior
          ), // Borde blanco
          borderRadius: BorderRadius.zero, // Rectangular puro
        ),
        child: Center(
          child: Text(
            btnNombre,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
