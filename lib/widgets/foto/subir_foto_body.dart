import 'package:flutter/material.dart';
import 'package:uniconecta/screens/registro_confirmado/registro_confirmado_screen.dart';
import 'package:uniconecta/widgets/registro_estudiantes/registro_input.dart';
import 'package:uniconecta/widgets/registro_estudiantes/registro_label.dart';
import 'package:uniconecta/widgets/shared/orange_button.dart';

class SubirFotoBody extends StatefulWidget {
  const SubirFotoBody({super.key});

  @override
  State<SubirFotoBody> createState() => _SubirFotoBodyState();
}

class _SubirFotoBodyState extends State<SubirFotoBody> {
  final Color colorBotones = Color.fromRGBO(11, 119, 179, 1);
  bool aceptado = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 75),
              padding: EdgeInsets.symmetric(vertical: 46, horizontal: 25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RegistroLabel(label: 'Sube tu foto de perfil'),
                        RegistroInput(
                          placeholder:
                              'Ponle rostro a tu cuenta. ¡Queremos verte!',
                          readOnly: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8), // Espacio entre la columna y la flecha
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey[600],
                      size: 22,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => RegistroConfirmadoScreen()),
                      );
                    },
                    splashRadius:
                        20, // Opcional: para ajustar el radio del toque
                    tooltip:
                        'Siguiente', // Opcional: texto al mantener presionado
                  ),
                ],
              )),
          Align(
            alignment: Alignment.center,
            child: Container(
                width: 140,
                color: colorBotones,
                margin: EdgeInsets.only(top: 41, bottom: 31),
                child: TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/img/pictureIcon.png',
                          width: 16,
                          height: 16,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Elige una foto',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ))),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
                width: 140,
                color: colorBotones,
                margin: EdgeInsets.only(top: 20, bottom: 31),
                child: TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_a_photo_outlined,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Tomar foto',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ))),
          ),
          Container(
              margin: EdgeInsets.only(top: 22),
              child: OrangeButton(
                onPressed: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(builder: (_) => ChatScreen()),
                  // );
                },
                buttonText: 'Subir',
                textWeight: FontWeight.w600,
                width: 140,
              )),
          Container(
            margin: EdgeInsets.symmetric(vertical: 40),
            child: Align(
              alignment: Alignment.center,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 300),
                child: CheckboxListTile(
                  value: aceptado,
                  onChanged: (bool? value) {
                    setState(() {
                      aceptado = value ?? false;
                    });
                  },
                  title: Text(
                    "Acepto los términos y la política de tratamiento de datos de UNICAB. Tus datos están seguros con nosotros. Solo los usaremos para mejorar tu experiencia en CABIU.",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 8,
                      color: Colors.black,
                    ),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
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
