import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uniconecta/config/theme/app_theme.dart';
import 'package:uniconecta/screens/estado_financiero/estado_financiero_screen.dart';
import 'package:uniconecta/screens/general/general_screen.dart';
import 'package:uniconecta/screens/inicio/inicio_screen.dart';
import 'package:uniconecta/screens/video_inicio/video_inicio_screen.dart';

void main() {
  runApp(const MyApp());

  // Invisible status bar on android
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparente
      statusBarIconBrightness: Brightness.light, // color de íconos
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UNICONECTA',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().theme(),
      home: InicioScreen(),
    );
  }
}
