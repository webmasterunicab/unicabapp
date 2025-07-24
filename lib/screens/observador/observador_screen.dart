import 'package:flutter/material.dart';
import 'package:uniconecta/screens/observador_falta/observador_falta_screen.dart';
import 'package:uniconecta/widgets/observador_related/pensamiento_card_observador.dart';
import 'package:uniconecta/widgets/shared/navegationBar/main_navegation_bar.dart';
import 'package:uniconecta/widgets/shared/orange_button.dart';
import 'package:uniconecta/widgets/shared/screen_name_display.dart';

class ObservadorScreen extends StatelessWidget {
  const ObservadorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MainNavegationBar(navType: NavBarTypes.navegating),
            SizedBox(height: 31),
        
            ScreenNameDisplay(
              name: "OBSERVADOR", 
              suffix: OrangeButton(buttonText: "Editar", 
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => ObservadorFaltaScreen()));
                }, 
                textWeight: FontWeight.normal, 
                padding: EdgeInsets.all(0),
                fontSize: 10,
              ),
              suffixSize: 69,
            ),

            PensamientoCardObservador(pensamientoName: 'Pensamiento', teacherName: 'Maestro Mediador', date: 'Fecha'),
            PensamientoCardObservador(pensamientoName: 'Pensamiento', teacherName: 'Maestro Mediador', date: 'Fecha'),
            PensamientoCardObservador(pensamientoName: 'Pensamiento', teacherName: 'Maestro Mediador', date: 'Fecha'),
            PensamientoCardObservador(pensamientoName: 'Pensamiento', teacherName: 'Maestro Mediador', date: 'Fecha'),
          ],
        ),
      ),
    );
  }
}