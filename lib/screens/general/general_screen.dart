import 'package:flutter/material.dart';
import 'package:uniconecta/widgets/shared/main_navegation_bar.dart';
import 'package:uniconecta/widgets/shared/orange_button.dart';

class GeneralScreen extends StatelessWidget {
  const GeneralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Column(
        children: [
          MainNavegationBar(navType: NavBarTypes.normal),
          SizedBox(height: 32),

          OrangeButton(
            buttonText: "Calificaciones", 
            width: 324,
            prefix: Icon(Icons.terminal_rounded, color: Colors.white, size: 24,),
            suffix: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 24,), 
            textWeight: FontWeight.normal,
            onPressed: () {}
          ),
          SizedBox(height: 23),

          OrangeButton(
            buttonText: "Observador", 
            width: 324,
            prefix: Icon(Icons.terminal_rounded, color: Colors.white, size: 24,),
            suffix: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 24,), 
            textWeight: FontWeight.normal,
            onPressed: () {}
          ),
          SizedBox(height: 23),

          OrangeButton(
            buttonText: "Seguimientos y Acuerdos", 
            width: 324,
            prefix: Icon(Icons.terminal_rounded, color: Colors.white, size: 24,),
            suffix: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 24,), 
            textWeight: FontWeight.normal,
            onPressed: () {}
          ),
          SizedBox(height: 23),

          OrangeButton(
            buttonText: "Financiera", 
            width: 324,
            prefix: Icon(Icons.terminal_rounded, color: Colors.white, size: 24,),
            suffix: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 24,), 
            textWeight: FontWeight.normal,
            onPressed: () {}
          ),
          SizedBox(height: 23),

          OrangeButton(
            buttonText: "Comunidad", 
            width: 324,
            prefix: Icon(Icons.terminal_rounded, color: Colors.white, size: 24,),
            suffix: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 24,), 
            textWeight: FontWeight.normal,
            onPressed: () {}
          )
        ],
      )),
    );
  }
}