import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CircularProgressWithText extends StatelessWidget {
  final double value;
  final Color color;
  final String text;

  const CircularProgressWithText({
    super.key,
    required this.value,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(80, 80),
      painter: _CircularTextPainter(
        value: value,
        color: color,
        text: text,
        textStyle: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
          color: color,
        ),
      ),
    );
  }
}

class _CircularTextPainter extends CustomPainter {
  final double value;
  final Color color;
  final String text;
  final TextStyle textStyle;

  _CircularTextPainter({
    required this.value,
    required this.color,
    required this.text,
    required this.textStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Fondo
    final backgroundPaint = Paint()
      ..color = color.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Progreso
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    final sweepAngle = 2 * 3.1415926 * value;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.1415926 / 2,
      sweepAngle,
      false,
      progressPaint,
    );

    // Texto en el centro
    final textSpan = TextSpan(text: text, style: textStyle);
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout();
    final offset = Offset(
      center.dx - (textPainter.width / 2),
      center.dy - (textPainter.height / 2),
    );
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
