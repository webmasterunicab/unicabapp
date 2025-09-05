import 'package:flutter/material.dart';
import 'package:uniconecta/screens/inicio/inicio_screen.dart';

class SplashInicioScreen extends StatefulWidget {
  const SplashInicioScreen({super.key});

  @override
  State<SplashInicioScreen> createState() => _SplashInicioScreenState();
}

class _SplashInicioScreenState extends State<SplashInicioScreen> {
  @override
  void initState() {
    super.initState();

    // Espera 5 segundos y navega
    Future.delayed(const Duration(seconds: 6), () {

      if(!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const InicioScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Image.asset(
          "assets/video/salida.gif", // Asegúrate de poner tu GIF en assets
          fit: BoxFit.fill,
        ),
      );
  }
}