import 'package:flutter/material.dart';
import 'package:uniconecta/widgets/foto/subir_foto_body.dart';
import 'package:uniconecta/widgets/registro_estudiantes/registro_app_bar.dart';

class SubirFotoScreen extends StatelessWidget {
  const SubirFotoScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: RegistroAppBar(
        mostrarTexto: false,
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      body: SafeArea(child: SubirFotoBody()),
    );
  }
}
