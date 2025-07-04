import 'package:flutter/material.dart';
import '../../widgets/calificaciones/calificaciones_topbar.dart';
import '../../widgets/calificaciones/calificaciones_list.dart';

class CalificacionesScreen extends StatelessWidget {
  final String inscripcionId;
  final String? materiaName;

  const CalificacionesScreen({
    Key? key,
    required this.inscripcionId,
    this.materiaName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          // TopBar de calificaciones
          CalificacionesTopBar(materiaName: materiaName),

          // Nombre de la materia
          if (materiaName != null) ...[
            Container(
              width: double.infinity,
              color: const Color(0xFFDDDBD7),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                materiaName!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],

          // Espaciado entre título y lista
          const SizedBox(height: 20),

          // Lista de calificaciones
          Expanded(
            child: CalificacionesList(inscripcionId: inscripcionId),
          ),
        ],
      ),
    );
  }
}
