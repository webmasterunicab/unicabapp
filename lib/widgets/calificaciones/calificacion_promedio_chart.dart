import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CalificacionChart extends StatelessWidget {
  final Map<String, double> promedios;

  const CalificacionChart({super.key, required this.promedios});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: 90, // Altura fija para gráfico + etiquetas
          child: CustomPaint(
            painter: _CalificacionChartPainter(promedios),
            size: Size(constraints.maxWidth, 200),
          ),
        );
      },
    );
  }
}

class _CalificacionChartPainter extends CustomPainter {
  final Map<String, double> promedios;

  _CalificacionChartPainter(this.promedios);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    // Línea roja en 3.5
    final linePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const maxCalificacion = 5.0;
    final yLinea = size.height - (3.5 / maxCalificacion) * size.height;
    canvas.drawLine(Offset(0, yLinea), Offset(size.width, yLinea), linePaint);

    final int count = promedios.length;
    if (count == 0) return;

    final double pasoX = size.width / (count + 1);
    final double anchoBarra = pasoX * 0.6;
    final double margenX = pasoX * 0.2;

    int index = 0;
    for (var entry in promedios.entries) {
      final String pensamiento = entry.key;
      final double valor = entry.value;
      final double alturaBarra = (valor / maxCalificacion) * size.height;
      final double x = margenX + index * pasoX;

      // Barras siempre AZULES (sin condicional, como pediste)
      //final barPaint = Paint()..color = Colors.blue[700]!;

      // Color condicional
      final colorBarra = valor < 3.5 ? Colors.red[700]! : Colors.green[700]!;
      final barPaintColored = Paint()..color = colorBarra;

      // Dibujar barra
      if (alturaBarra > 0 && anchoBarra > 0) {
        canvas.drawRect(
            Rect.fromLTWH(
                x, size.height - alturaBarra, anchoBarra, alturaBarra),
            //barPaint,
            barPaintColored);
      }

      // Dibujar VALOR en BLANCO, dentro de la barra, en la PARTE SUPERIOR
      final textSpanValor = TextSpan(
        text: valor.toStringAsFixed(1),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14.sp,
        ),
      );

      final textPainterValor = TextPainter(
        text: textSpanValor,
        textDirection: TextDirection.ltr,
      );
      textPainterValor.layout();

      final yTextValor = size.height -
          alturaBarra +
          5; // Justo arriba del borde inferior de la barra
      final xTextValor =
          x + (anchoBarra - textPainterValor.width) / 2; // Centrado horizontal

      textPainterValor.paint(canvas, Offset(xTextValor, yTextValor));

      // Dibujar ETIQUETA (inicial) en BLANCO, dentro de la barra, en la PARTE INFERIOR
      final textSpanInicial = TextSpan(
        text: _obtenerInicial(pensamiento),
        style: TextStyle(
          color: const Color.fromARGB(255, 0, 0, 0),
          fontWeight: FontWeight.bold,
          fontSize: 14.sp,
        ),
      );

      final textPainterInicial = TextPainter(
        text: textSpanInicial,
        textDirection: TextDirection.ltr,
      );
      textPainterInicial.layout();

      final yTextInicial =
          size.height - 0; // Fijo en la parte inferior de la barra
      final xTextInicial = x +
          (anchoBarra - textPainterInicial.width) / 2; // Centrado horizontal

      textPainterInicial.paint(canvas, Offset(xTextInicial, yTextInicial));

      index++;
    }
  }

  @override
  bool shouldRepaint(covariant _CalificacionChartPainter oldDelegate) {
    return oldDelegate.promedios != promedios;
  }

  String _obtenerInicial(String pensamiento) {
    if (pensamiento.isEmpty) return "";
    if (pensamiento == "HUMANÍSTICO E") {
      return "E";
    } else if (pensamiento == "HUMANÍSTICO I") {
      return "I";
    } else {
      return pensamiento[0].toUpperCase(); // Solo la primera letra
    }
  }
}
