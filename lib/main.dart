import 'package:flutter/material.dart';
import 'package:uniconecta/config/theme/app_theme.dart';
import 'package:uniconecta/screens/chat/chat_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme().theme(),
      home: const ChatScreen(),
    );
  }
}
