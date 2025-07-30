import 'package:flutter/material.dart';
import 'package:uniconecta/widgets/clave/clave_body.dart';
import 'package:uniconecta/widgets/registro_estudiantes/registro_app_bar.dart';

class ClaveScreen extends StatelessWidget {
  final String nombre;
  final String correo;
  final String cumple; //Formato fecha YYYY-MM-DD
  final String ciudad;
  final String rol;
  final String lugaresVisitados;
  final String porqueUnicab;

  const ClaveScreen({
    super.key,
    required this.nombre,
    required this.correo,
    required this.cumple,
    required this.ciudad,
    required this.rol,
    required this.lugaresVisitados,
    required this.porqueUnicab,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RegistroAppBar(
        mostrarTexto: false,
      ),
      body: SafeArea(
          child: ClaveBody(
        rol: rol,
        ciudad: ciudad,
        cumple: cumple,
        lugaresVisitados: lugaresVisitados,
        nombre: nombre,
        porqueUnicab: porqueUnicab,
        correo: correo,
      )),
    );
  }
}
