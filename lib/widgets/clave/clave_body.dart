import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/screens/foto/subir_foto_screen.dart';
import 'package:uniconecta/util/custom_form_field_validator.dart';
import 'package:uniconecta/widgets/registro_estudiantes/registro_input.dart';
import 'package:uniconecta/widgets/registro_estudiantes/registro_label.dart';
import 'package:uniconecta/widgets/shared/orange_button.dart';

class ClaveBody extends StatefulWidget {
  final Map<String, dynamic> datosRegistro;

  const ClaveBody({
    super.key,
    required this.datosRegistro,
  });

  @override
  State<ClaveBody> createState() => _ClaveBodyState();
}

class _ClaveBodyState extends State<ClaveBody> {
  final _formKey = GlobalKey<FormState>();
  String password = '';
  String passwordRepetida = '';

  bool _isFormValid = false;

  void _checkForm() {
    setState(() {
      _isFormValid = _formKey.currentState?.validate() ?? false;

      if (password != passwordRepetida) {
        _isFormValid = false;
      }
    });
  }

  void _submit() {
    if (_formKey.currentState?.validate() == true) {
      _formKey.currentState?.save();

      widget.datosRegistro['pass'] = password;

      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => SubirFotoScreen(datosRegistro: widget.datosRegistro,)),
      );
    }
  }

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
              child: Form(
                key: _formKey,
                // onChanged: _checkForm,
                // autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          size: 18.sp,
                          color: const Color.fromRGBO(255, 152, 5, 1),
                        ),
                      ],
                    ),
                    RegistroInput(
                      placeholder:
                          'Algo fácil de recordar, pero difícil de adivinar.',
                      validator: (value) {
                        password = value!;

                        return CustomFormFieldValidator.password(value,
                            esRequerido: true, nombreCampo: 'contraseña');
                      },
                      onSaved: (newValue) => password = newValue!,
                      readOnly: false,
                    ),
                    espaciado,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RegistroLabel(label: 'Confirma tu clave'),
                        SizedBox(width: 8), // Espacio entre texto e icono
                        Icon(
                          Icons.lock_outline,
                          size: 18.sp,
                          color: const Color.fromRGBO(255, 152, 5, 1),
                        ),
                      ],
                    ),
                    RegistroInput(
                      placeholder:
                          'Solo para estar seguro de que la escribiste bien',
                      validator: (value) {
                        passwordRepetida = value!;
                        return CustomFormFieldValidator.passwordConfirmation(
                            password, passwordRepetida);
                      },
                      onSaved: (newValue) => passwordRepetida = newValue!,
                      readOnly: false,
                    ),
                  ],
                ),
              )),
          Container(
            margin: EdgeInsets.symmetric(vertical: 38, horizontal: 38),
            child: Text(
              'Requisitos: *Mínimo 8 caracteres, incluye letras, números y al menos un Mínimo 8 caracteres, incluye letras, números y al menos un símbolo.',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.normal,
                fontSize: 13.sp,
                color: Color.fromRGBO(14, 14, 14, 1),
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 22),
              child: OrangeButton(
                onPressed: () {
                  _checkForm();
                  if (_isFormValid) _submit();
                },
                buttonText: '¡Listo, sigamos!',
                textWeight: FontWeight.w600,
                fontSize: 16.sp,
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
                    fontSize: 14.sp,
                    color: Colors.black,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
