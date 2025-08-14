import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/models/calificaciones/linea_calificacion.dart';
import 'package:uniconecta/widgets/calificaciones/indicador_nota.dart';

class CalificacionesEspecificas extends StatefulWidget {
  final List<LineaCalificacion> calificaciones;

  const CalificacionesEspecificas({super.key, required this.calificaciones});

  @override
  State<CalificacionesEspecificas> createState() =>
      _CalificacionesEspecificasState();
}

class _CalificacionesEspecificasState extends State<CalificacionesEspecificas> {
  int? _expandedId;

  final espaciado = SizedBox(height: 5.w);

  @override
  Widget build(BuildContext context) {
    if (widget.calificaciones.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 6.w),
        child: const Text('No hay calificaciones para mostrar.'),
      );
    }

    const Map<String, String> periodosMap = {
      'TP1': 'Primer Periodo',
      'TP2': 'Segundo Periodo',
      'TP3': 'Tercer Periodo',
      'TP4': 'Cuarto Periodo',
    };

    // Agrupamos por periodo normalizado y seleccionamos el que tiene nota
    final Map<String, LineaCalificacion> mejoresPorPeriodo = {};

    for (var cal in widget.calificaciones) {
      String codigoPeriodo = cal.periodo.toUpperCase().trim();
      if (codigoPeriodo.endsWith("I")) {
        codigoPeriodo = codigoPeriodo.substring(0, 3);
      }

      double nota = double.tryParse(cal.calificacion) ?? 0.0;

      // Si no existe un registro para este periodo o el actual tiene mejor nota
      if (!mejoresPorPeriodo.containsKey(codigoPeriodo) ||
          nota >
              (double.tryParse(
                      mejoresPorPeriodo[codigoPeriodo]!.calificacion) ??
                  0.0)) {
        mejoresPorPeriodo[codigoPeriodo] = cal;
      }
    }

    // Lista final filtrada
    final List<LineaCalificacion> filtradas = mejoresPorPeriodo.values.toList();

    Color colorNota(double nota) {
      if (nota <= 3.4) return Colors.red;
      if (nota <= 3.9) return Colors.orange;
      if (nota <= 4.6) return Colors.green;
      return Colors.blue;
    }

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: ListView.separated(
          itemCount: filtradas.length,
          separatorBuilder: (_, __) => espaciado,
          itemBuilder: (_, i) {
            final cal = filtradas[i];
            final double nota = double.tryParse(cal.calificacion) ?? 0.0;

            String codigoPeriodo = cal.periodo.toUpperCase().trim();
            if (codigoPeriodo.endsWith("I")) {
              codigoPeriodo = codigoPeriodo.substring(0, 3);
            }

            String titulo = periodosMap[codigoPeriodo] ?? codigoPeriodo;
            final int porcentaje = ((nota * 100) / 5.0).round();

            final String retro = "${_capitalizar(cal.criterioEvaluacion)}\n\n"
                "${_capitalizar(cal.descripcionValoracionInstitucional)}";

            final Color color = colorNota(nota);

            return _buildPanel(
              index: i,
              titulo: titulo,
              porcentaje: porcentaje,
              retroalimentacion: retro,
              color: color,
              nota: nota,
              estado: cal.escalaValoracionInstitucional,
            );
          },
        ),
      ),
    );
  }

  String _capitalizar(String texto) {
    if (texto.isEmpty) return texto;

    texto = texto.trim();

    // Si contiene ":", nos quedamos con el texto después de los dos puntos
    if (texto.contains(":")) {
      int index = texto.indexOf(":");
      if (index != texto.length - 1) {
        texto = texto.substring(index + 1).trim();
      }
    }

    // Capitalizamos la primera letra y lo demás en minúscula
    return texto[0].toUpperCase() + texto.substring(1).toLowerCase();
  }

  Widget _buildPanel(
      {required int index,
      required String titulo,
      required int porcentaje,
      required String retroalimentacion,
      required Color color,
      required double nota,
      required String estado}) {
    final isExpanded = _expandedId == index;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _expandedId = isExpanded ? null : index;
            });
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
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
                Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start, // Alinea arriba
              children: [
                Expanded(
                  flex: 45,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(244, 242, 240, 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 8.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Evita que se centre
                      children: [
                        // CircularProgressWithText(
                        //     value: porcentaje / 100,
                        //     color: color,
                        //     text: '$porcentaje%',
                        //   ),
                        //   SizedBox(height: 3.w),
                        //   Text("Nota: ${nota.toStringAsFixed(1)}"),

                        IndicadorNota(
                          nota: nota,
                          estado: estado,
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(flex: 5),
                Expanded(
                  flex: 50,
                  child: Text(
                    retroalimentacion,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontFamily: 'Roboto',
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
