import 'package:flutter/material.dart';
import 'package:uniconecta/util/enums/ajustar_perfil/proceso.dart';
import 'package:uniconecta/widgets/registro_estudiantes/registro_app_bar.dart';
import 'package:uniconecta/widgets/registro_estudiantes/registro_body.dart';

class RegistroScreen extends StatelessWidget {
  const RegistroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RegistroAppBar(mostrarTexto: true,),
      body: SafeArea(child: RegistroBody(proceso: Proceso.registro,)),
    );
  }
}
