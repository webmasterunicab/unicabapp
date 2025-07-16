import 'package:flutter/material.dart';
import 'package:uniconecta/widgets/registro_acuerdos/button_extras_acuerdos.dart';
import 'package:uniconecta/widgets/shared/main_navegation_bar.dart';
import 'package:uniconecta/widgets/shared/outlined_orange_button.dart';

class RegistroAcuerdos extends StatelessWidget {
  const RegistroAcuerdos({super.key});

  @override
  Widget build(BuildContext context) {
    const double espacioBotones = 14;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            MainNavegationBar(navType: NavBarTypes.navegating), // IMPORTANT: Navegacion

            SizedBox(height: 31),

            Container(
              width: double.infinity,
              alignment: Alignment.center,

              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.16),
                    blurRadius: 6,
                    offset: Offset(0, 3)
                  )
                ],
              ),

              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 9),
                child: Text(
                  "REGISTRO ACUERDOS",
                  style: TextStyle(
                    color: Color.fromRGBO(134, 132, 129, 1),
                    fontSize: 15,
                    fontWeight: FontWeight.w600
                  ),
                ),
              )
            ),
            
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Text(
                "¿Desde qué área realizarás el seguimiento?",
                style: TextStyle(
                  color: Color.fromRGBO(14, 14, 14, 1),
                  fontSize: 17
                ),
              ),
            ),

            OrangeOutlinedButton(buttonText: "P. Matemático", onPressed: () {}, width: 154,),
            SizedBox(height: espacioBotones),
            OrangeOutlinedButton(buttonText: "P. Bioético", onPressed: () {}, width: 154,),
            SizedBox(height: espacioBotones),
            OrangeOutlinedButton(buttonText: "P. H. Español", onPressed: () {}, width: 154,),
            SizedBox(height: espacioBotones),
            OrangeOutlinedButton(buttonText: "P. H. Inglés", onPressed: () {}, width: 154,),
            SizedBox(height: espacioBotones),
            OrangeOutlinedButton(buttonText: "P. Social", onPressed: () {}, width: 154,),
            SizedBox(height: espacioBotones),
            OrangeOutlinedButton(buttonText: "P. Tecnológico", onPressed: () {}, width: 154,),
            SizedBox(height: espacioBotones),
            OrangeOutlinedButton(buttonText: "Psicología", onPressed: () {}, width: 154,),

            SizedBox(height: 30),
            Container(
              width: 325,
              decoration: BoxDecoration(
                color: Color.fromRGBO(221, 219, 215, 1), 
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: Padding(
                padding: EdgeInsets.all(14),
                child: Row(
                  children: [
                    ButtonExtrasAcuerdos(text: "Manual De Convivencia", iconPath: "assets/img/iconoFaltas.png"),
                    SizedBox(width: 9),
                    ButtonExtrasAcuerdos(text: "Deberes y\nResponsabilidades", iconPath: "assets/img/iconoDeberes.png"),
                    SizedBox(width: 9),
                    ButtonExtrasAcuerdos(text: "Faltas y consecuencias", iconPath: "assets/img/iconoFaltas.png"),
                  ],
                ),  
              ),
            ),
          ],
        ),
      ),
    );
  }
}