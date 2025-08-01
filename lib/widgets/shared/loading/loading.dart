import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Fondo blanco para todo el espacio del SafeArea
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Image.asset(
          'assets/img/cargar.gif',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
