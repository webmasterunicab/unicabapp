import 'package:flutter/material.dart';
import 'package:uniconecta/widgets/inicio/inicio_btn.dart';
import 'package:uniconecta/widgets/inicio/inicio_head.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(11, 119, 179, 1),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: Column(
            children: [
              InicioHead(),
              Expanded(
                child: Column(
                  children: [
                    InicioBtn(btnNombre: "Inicio de sesión", bottom: false,),
                    InicioBtn(btnNombre: "Registro",),
                    
                  ],
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
