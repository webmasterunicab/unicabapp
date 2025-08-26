import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ErrorMensaje extends StatelessWidget {
  final String mensaje;

  const ErrorMensaje({super.key, required this.mensaje});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red[50], // fondo suave rojo
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error,
            color: Colors.red[800],
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              mensaje,
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.red.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
