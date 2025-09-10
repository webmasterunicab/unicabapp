import 'package:flutter/material.dart';
import 'package:uniconecta/screens/observador/observador_screen.dart';
import 'package:uniconecta/widgets/shared/dropdowns_intermedia.dart';
import 'package:uniconecta/widgets/shared/navegationBar/main_navegation_bar.dart';
import 'package:uniconecta/widgets/shared/screen_name_display.dart';

class ObservadorIntermediaScreen extends StatelessWidget {

  final int rol;
  final String email;

  const ObservadorIntermediaScreen({super.key, required this.rol, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column( 
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MainNavegationBar(navType: NavBarTypes.navegating),
          SizedBox(height: 25),
          ScreenNameDisplay(name: "OBSERVADOR"),
          SizedBox(height: 25),
          DropdownsIntermedia(rol: rol, email: email, nextScreenCallback: (String selectedEmail) {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => ObservadorScreen(email: selectedEmail)));
          }),
        ],
      ),
    );
  }
}