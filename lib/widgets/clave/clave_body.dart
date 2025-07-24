import 'package:flutter/material.dart';
import 'package:uniconecta/screens/foto/subir_foto_screen.dart';
import 'package:uniconecta/widgets/registro_estudiantes/registro_input.dart';
import 'package:uniconecta/widgets/registro_estudiantes/registro_label.dart';
import 'package:uniconecta/widgets/shared/orange_button.dart';

class ClaveBody extends StatelessWidget {
  const ClaveBody({super.key});

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
      height: 25.0,
    );
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 75),
              padding: EdgeInsets.symmetric(vertical: 46, horizontal: 40),
              decoration: decoracion,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RegistroLabel(label: 'Elige tu clave secreta'),
                      SizedBox(width: 8), // Espacio entre texto e icono
                      Icon(
                        Icons.lock_outline,
                        size: 20,
                        color: const Color.fromRGBO(255, 152, 5, 1),
                      ),
                    ],
                  ),
                  RegistroInput(
                      placeholder:
                          'Algo fácil de recordar, pero difícil de adivinar.'),
                  espaciado,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RegistroLabel(label: 'Confirma tu clave'),
                      SizedBox(width: 8), // Espacio entre texto e icono
                      Icon(
                        Icons.lock_outline,
                        size: 20,
                        color: const Color.fromRGBO(255, 152, 5, 1),
                      ),
                    ],
                  ),
                  RegistroInput(
                      placeholder:
                          'Solo para estar seguro de que la escribiste bien'),
                ],
              )),
          Container(
            margin: EdgeInsets.symmetric(vertical: 38, horizontal: 38),
            child: Text(
              'Requisitos: *Mínimo 8 caracteres, incluye letras, números y al menos un Mínimo 8 caracteres, incluye letras, números y al menos un símbolo.',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.normal,
                fontSize: 10,
                color: Color.fromRGBO(14, 14, 14, 1),
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 22),
              child: OrangeButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => SubirFotoScreen()),
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
