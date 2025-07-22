import 'package:flutter/material.dart';
import 'package:uniconecta/widgets/clave/clave_body.dart';
import 'package:uniconecta/widgets/registro_estudiantes/registro_app_bar.dart';

class ClaveScreen extends StatelessWidget {
  const ClaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RegistroAppBar(mostrarTexto: false,),
      body: SafeArea(child: ClaveBody()),
    );
  }
}
