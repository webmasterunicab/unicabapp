import 'package:flutter/material.dart';
import 'package:uniconecta/screens/calificaciones/calificaciones_screen.dart';
import 'package:uniconecta/widgets/shared/dropdowns_intermedia.dart';
import 'package:uniconecta/widgets/shared/navegationBar/main_navegation_bar.dart';
import 'package:uniconecta/widgets/shared/screen_name_display.dart';

class CalificacionesIntermediaScreen extends StatelessWidget {

  final int rol;
  final String email;

  const CalificacionesIntermediaScreen({super.key, required this.rol, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column( 
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MainNavegationBar(navType: NavBarTypes.alternative),
          SizedBox(height: 25),
          ScreenNameDisplay(name: "CALIFICACIONES"),
          SizedBox(height: 25),
          DropdownsIntermedia(rol: rol, email: email, nextScreenCallback: (String selectedEmail) {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => CalificacionesScreen(rol: 1, email: selectedEmail)));
          }),
        ],
      ),
    );
  }
}