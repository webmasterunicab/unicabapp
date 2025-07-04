import 'package:flutter/material.dart';
import '../../widgets/calificaciones/materias_topbar.dart';
import '../../widgets/calificaciones/materias_grid.dart';

class MateriasScreen extends StatelessWidget {
  const MateriasScreen({Key? key}) : super(key: key);

  static const String routeName = '/calificaciones';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F2F0), // Color de fondo consistente
      body: const Column(
        children: [
          // Topbar de calificaciones
          MateriasTopBar(),

          // Grid de materias
          MateriasGrid(),
        ],
      ),
    );
  }
}
