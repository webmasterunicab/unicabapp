import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/widgets/calificaciones/circular_progress_with_text.dart';

class CalificacionesEspecificas extends StatefulWidget {
  const CalificacionesEspecificas({super.key});

  @override
  State<CalificacionesEspecificas> createState() =>
      _CalificacionesEspecificasState();
}

class _CalificacionesEspecificasState extends State<CalificacionesEspecificas> {
  int? _expandedId;

  final espaciado = SizedBox(
    height: 5.w,
  );

  int _convertirCalificacionAPorcentaje(double calificacion) {
    return ((calificacion * 100) / 5.0).round();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        children: [
          _buildPanel(
            index: 0,
            titulo: 'Primer Periodo',
            porcentaje: 100,
            retroalimentacion: '¡Excelente progreso! Sigue así.',
            color: Colors.orange,
          ),
          espaciado,
          _buildPanel(
            index: 1,
            titulo: 'Segundo Periodo',
            porcentaje: 6,
            retroalimentacion: 'Buen trabajo, pero puedes mejorar.',
            color: Colors.orange,
          ),
          espaciado,
          _buildPanel(
            index: 2,
            titulo: 'Tercer Periodo',
            porcentaje: 45,
            retroalimentacion: 'Necesitas repasar algunos temas.',
            color: Colors.orange,
          ),
          espaciado,
          _buildPanel(
            index: 3,
            titulo: 'Cuarto Periodo',
            porcentaje: 95,
            retroalimentacion: 'Dominio casi total del contenido.',
            color: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildPanel({
    required int index,
    required String titulo,
    required int porcentaje,
    required String retroalimentacion,
    required Color color,
  }) {
    final isExpanded = _expandedId == index;

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _expandedId = isExpanded ? null : index;
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  titulo,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                AnimatedRotation(
                  turns: isExpanded ? 0.5 : 0, // gira la flecha
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.85),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      Icons.expand_more,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  flex: 45, // 45%
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(244, 242, 240, 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(8.w),
                    child: Column(
                      children: [
                        CircularProgressWithText(
                          value: porcentaje / 100,
                          color: Colors.orange,
                          text: '$porcentaje%',
                        ),
                        SizedBox(
                          height: 8.w,
                        ),
                        Text("Nota: 5.0")
                      ],
                    ),
                  ),
                ),
                const Spacer(flex: 5), // 5% separación
                Expanded(
                  flex: 50, // 50%
                  child: Text(
                    retroalimentacion,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
          crossFadeState:
              isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 250),
        ),
      ],
    );
  }
}
