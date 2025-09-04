import 'package:flutter/material.dart';
import 'package:uniconecta/screens/inicio/inicio_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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