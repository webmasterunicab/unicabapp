import 'package:flutter/material.dart';
import 'package:uniconecta/screens/clave/clave_screen.dart';
import 'package:uniconecta/widgets/registro_estudiantes/registro_input.dart';
import 'package:uniconecta/widgets/registro_estudiantes/registro_label.dart';
import 'package:uniconecta/widgets/shared/orange_button.dart';

class RegistroBody extends StatelessWidget {
  const RegistroBody({super.key});

  @override
  Widget build(BuildContext context) {
    final decoracion = BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(
              red: 0,
              blue: 0,
              green: 0,
              alpha: 0.16), // sombra negra con opacidad
          offset: Offset(0, 4), // solo hacia abajo (eje Y positivo)
          blurRadius: 6, // qué tan suave es la sombra
          spreadRadius: 0, // qué tanto se extiende
        ),
      ],
    );

    final espaciado = SizedBox(
                    height: 25.0 ,
                  );
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              decoration: decoracion,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RegistroLabel(
                    label: '¿Cómo te llamas?',
                  ),
                  RegistroInput(
                      placeholder: 'Tal como te conocen en casa y en UNICAB.'),
                  espaciado,
                  RegistroLabel(
                    label: '¿Cuándo es tu cumpleaños?',
                  ),
                  RegistroInput(
                      placeholder:
                          'No prometemos pastel, pero nos gusta saberlo.'),
                  espaciado,
                  RegistroLabel(
                    label: '¿Desde dónde te conectas?',
                  ),
                  RegistroInput(
                      placeholder:
                          'UNICAB es virtual, pero tú tienes un mundo propio.'),
                  espaciado,
                  RegistroLabel(
                    label: '¿Cuál es tu rol?',
                  ),
                  RegistroInput(
                      placeholder:
                          'Dinos si eres estudiante, maestro mediador, padre de familia...'),
                  espaciado,
                  RegistroLabel(
                    label: 'Tu correo en UNICAB',
                  ),
                  RegistroInput(
                      placeholder:
                          'Para avisarte de cosas importantes. Nada de spam, lo prometemos.'),
                  espaciado,
                  RegistroLabel(
                    label: '¿Qué lugares has viajado o te gustaría visitar?',
                  ),
                  RegistroInput(
                      placeholder:
                          'El mundo es enorme, cuéntanos qué sitios ha explorado o sueñas conocer.'),
                  espaciado,
                  RegistroLabel(
                    label: '¿Por qué elige a UNICAB?',
                  ),
                  RegistroInput(
                      placeholder:
                          'Cada historia es única. ¿Qué te trajo hasta aquí?'),
                ],
              )),
          Container(
              margin: EdgeInsets.only(top: 22),
              //TODO: Cambiar boton compartido para que acepte fontSize
              child: OrangeButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => ClaveScreen()),
                  );
                },
                buttonText: '¡Listo, sigamos!',
                textWeight: FontWeight.w600,
              )),
          Container(
            margin: EdgeInsets.only(top: 55),
            child: TextButton(
                onPressed: () {
                  // Acción al presionar
                },
                child: Text(
                  'Términos y privacidad (Enlace a políticas de datos)',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 6,
                    color: Colors.black,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
