import 'package:flutter/material.dart';
import 'package:uniconecta/widgets/registro_estudiantes/registro_input.dart';
import 'package:uniconecta/widgets/registro_estudiantes/registro_label.dart';

class RegistroBody extends StatelessWidget {
  const RegistroBody({super.key});

  @override
  Widget build(BuildContext context) {
    final decoracion = BoxDecoration(
      color: Colors.white, // fondo del container si lo necesitas
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

    final espaciado = 25.0;
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
                  SizedBox(
                    height: espaciado,
                  ),
                  RegistroLabel(
                    label: '¿Cuándo es tu cumpleaños?',
                  ),
                  RegistroInput(
                      placeholder:
                          'No prometemos pastel, pero nos gusta saberlo.'),
                  SizedBox(
                    height: espaciado,
                  ),
                  RegistroLabel(
                    label: '¿Desde dónde te conectas?',
                  ),
                  RegistroInput(
                      placeholder:
                          'UNICAB es virtual, pero tú tienes un mundo propio.'),
                  SizedBox(
                    height: espaciado,
                  ),
                  RegistroLabel(
                    label: '¿Cuál es tu rol?',
                  ),
                  RegistroInput(
                      placeholder:
                          'Dinos si eres estudiante, maestro mediador, padre de familia...'),
                  SizedBox(
                    height: espaciado,
                  ),
                  RegistroLabel(
                    label: 'Tu correo en UNICAB',
                  ),
                  RegistroInput(
                      placeholder:
                          'Para avisarte de cosas importantes. Nada de spam, lo prometemos.'),
                  SizedBox(
                    height: espaciado,
                  ),
                  RegistroLabel(
                    label: '¿Qué lugares has viajado o te gustaría visitar?',
                  ),
                  RegistroInput(
                      placeholder:
                          'El mundo es enorme, cuéntanos qué sitios ha explorado o sueñas conocer.'),
                  SizedBox(
                    height: espaciado,
                  ),
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
            child: TextButton(
                onPressed: () {
                  // Acción al presionar
                },
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromRGBO(255, 152, 5, 1),
                  padding: EdgeInsets.symmetric(vertical: 22, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  '¡Listo, sigamos!',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                )),
          ),
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
