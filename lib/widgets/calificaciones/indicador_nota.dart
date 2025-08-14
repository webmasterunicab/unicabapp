import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:uniconecta/widgets/calificaciones/custom_battery_indicator.dart';
//import 'package:battery_indicator/battery_indicator.dart';

class IndicadorNota extends StatelessWidget {
  final double nota;
  final String estado;
  static const double maxNota = 5.0;

  const IndicadorNota({super.key, required this.nota, required this.estado});

  // Porcentaje real de la nota
  double get porcentaje => nota / maxNota;

  // Color según rango
  Color getColor() {
    if (nota <= 3.4) return Colors.red;
    if (nota <= 3.9) return Colors.orange;
    if (nota <= 4.6) return Colors.green;
    return Colors.blue;
  }

  // Estado según rango
  // String getEstado() {
  //   if (nota <= 3.4) return "EN PROCESO";
  //   if (nota <= 3.9) return "POR ALCANZAR";
  //   if (nota <= 4.6) return "ALCANZADO POR MEJORAR";
  //   return "ALCANZADO";
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Indicador circular
        CircularPercentIndicator(
          radius: 50.0,
          lineWidth: 8.0,
          percent: porcentaje.clamp(0.0, 1.0),
          center: Text("${(porcentaje * 100).toStringAsFixed(0)}%"),
          progressColor: getColor(),
          backgroundColor: Colors.grey.shade200,
          circularStrokeCap: CircularStrokeCap.round,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            /*RotatedBox(
              quarterTurns: 3,
              child: CustomBatteryIndicator(
                batteryLevel: (porcentaje * 100).toInt(), // real %
                mainColor: getColor(),
                size: 25,
              ),
            ),*/
            CustomBatteryIndicator(
              batteryLevel: (porcentaje * 100).toInt(), // real %
              mainColor: getColor(),
              size: 25,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Nota: ${nota.toStringAsFixed(1)}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(estado, softWrap: true,),
                ],
              ),
            )
          ],
        ),
        // Indicador de batería
        /*BatteryIndicator(
          batteryLevel: (porcentaje * 100).toInt(), // real %
          batteryFromPhone: false,
          colorful: false, // usamos un solo color controlado
          showPercentNum: false,
          mainColor: getColor(),
          size: 25,
        ),
        const SizedBox(height: 5),
        // Nota y estado
        Text(
          "Nota: ${nota.toStringAsFixed(1)}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(getEstado()),*/
      ],
    );
  }
}
