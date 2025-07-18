import 'package:flutter/material.dart';
import 'package:uniconecta/config/theme/app_theme.dart';
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
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().theme(),
      home: VideoInicioScreen(),
    );
  }
}
