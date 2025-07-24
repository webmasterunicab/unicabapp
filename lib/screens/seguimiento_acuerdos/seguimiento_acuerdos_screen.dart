import 'package:flutter/material.dart';
import 'package:uniconecta/screens/registro_acuerdos/registro_acuerdos_screen.dart';
import 'package:uniconecta/widgets/seguimiento_acuerdos/seguimiento_card.dart';
import 'package:uniconecta/widgets/shared/navegationBar/main_navegation_bar.dart';
import 'package:uniconecta/widgets/shared/orange_button.dart';
import 'package:uniconecta/widgets/shared/screen_name_display.dart';

class SeguimientoAcuerdosScreen extends StatelessWidget {
  const SeguimientoAcuerdosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<SeguimientoCard> acuerdosList = [
      SeguimientoCard(acuerdos: "Acuerdos1", pensamiento: "Pensamiento", date: "Fecha", status: 1),
      SeguimientoCard(acuerdos: "Acuerdos2", pensamiento: "Pensamiento", date: "Fecha", status: 1),
      SeguimientoCard(acuerdos: "Acuerdos3", pensamiento: "Pensamiento", date: "Fecha", status: 1),
      SeguimientoCard(acuerdos: "Acuerdos4", pensamiento: "Pensamiento", date: "Fecha", status: 1),
    ];

    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
        
          children: [
            MainNavegationBar(navType: NavBarTypes.navegating),
            SizedBox(height: 31),
          
            ScreenNameDisplay(
              name: "SEGUIMIENTO Y ACUERDOS", 
              suffix: OrangeButton(buttonText: "Editar", 
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => RegistroAcuerdos()));
                }, 
                textWeight: FontWeight.normal, 
                padding: EdgeInsets.all(0),
                fontSize: 10,
              ),
              suffixSize: 69,
            ),
        
            for (int i=0; i < acuerdosList.length; i++)
              acuerdosList[i]
          ],
        ),
      ),
    );
  }
}