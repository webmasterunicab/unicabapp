import 'package:flutter/material.dart';
import 'package:uniconecta/screens/estado_financiero/estado_financiero_screen.dart';
import 'package:uniconecta/widgets/shared/dropdowns_intermedia.dart';
import 'package:uniconecta/widgets/shared/navegationBar/main_navegation_bar.dart';
import 'package:uniconecta/widgets/shared/screen_name_display.dart';

class FinancieroIntermediaScreen extends StatelessWidget {

  final int rol;
  final String email;

  const FinancieroIntermediaScreen({super.key, required this.rol, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column( 
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MainNavegationBar(navType: NavBarTypes.navegating),
          SizedBox(height: 25),
          ScreenNameDisplay(name: "ESTADO FINANCIERO"),
          SizedBox(height: 25),
          DropdownsIntermedia(rol: rol, email: email, nextScreenCallback: (String selectedEmail, String nombreEstudiante) {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => EstadoFinanciero(obtainedEmail: selectedEmail)));
          }),
        ],
      ),
    );
  }
}