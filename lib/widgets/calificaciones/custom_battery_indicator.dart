import 'package:flutter/material.dart';

class CustomBatteryIndicator extends StatelessWidget {
  final int batteryLevel;
  final Color mainColor;
  final double size;

  const CustomBatteryIndicator({
    super.key,
    required this.batteryLevel,
    required this.mainColor,
    this.size = 25,
  });

  @override
  Widget build(BuildContext context) {
    // Normalizar el nivel entre 0 y 100
    final level = batteryLevel.clamp(0, 100);

    // Alto total disponible para la carga
    final availableHeight = (size * 2) - 8;
    final fillHeight = (level / 100.0) * availableHeight;

    return SizedBox(
      width: size, // Ancho pequeño (batería vertical)
      height: size * 2.2, // Alto mayor para simular una batería vertical
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Contorno de la batería (parte exterior)
          Container(
            width: size,
            height: size * 2,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: mainColor, width: 1.5),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Container(
              margin: const EdgeInsets.all(2),
              width: size - 4, // Ancho interno
              height: availableHeight, // Alto interno
              decoration: BoxDecoration(
                color: mainColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // Parte llena de la batería (carga vertical)
          Positioned(
            bottom: 6, // Comienza desde abajo
            left: 2, // Margen izquierdo
            right: 2, // Margen derecho
            /*child: Container(
              height: fillHeight, // Altura según el porcentaje
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),*/
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500), // ⬅️ Animación aquí
              height: fillHeight,
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // Terminal superior de la batería
          Positioned(
            top: -2,
            left: 0,
            right: 0,
            child: Container(
              width: size * 0.4,
              height: 2,
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
