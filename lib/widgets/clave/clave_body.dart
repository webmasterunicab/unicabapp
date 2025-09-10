import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/repositories/usuario_service.dart';
import 'package:uniconecta/screens/registro_confirmado/registro_confirmado_screen.dart';
import 'package:uniconecta/util/custom_form_field_validator.dart';
import 'package:uniconecta/widgets/registro_estudiantes/registro_input.dart';
import 'package:uniconecta/widgets/registro_estudiantes/registro_label.dart';
import 'package:uniconecta/widgets/shared/error_mensaje.dart';
import 'package:uniconecta/widgets/shared/loading/loading.dart';
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
  String passRegistroAcademico = '';
  String? _error;
  final _service = UsuarioService();

  bool _isFormValid = false;
  bool _cargando = false;
  bool terminosAceptados = false;

  Widget _mostrarError() {
    if (_error != null) {
      return Container(
          margin: EdgeInsets.symmetric(vertical: 2.w, horizontal: 2.w),
          padding: EdgeInsets.all(4.w),
          child: ErrorMensaje(mensaje: _error!));
    } else {
      return SizedBox.shrink();
    }
  }

  void _checkForm() {
    setState(() {
      _isFormValid = _formKey.currentState?.validate() ?? false;

      if (password != passwordRepetida) {
        _isFormValid = false;
      }
    });
  }

  void _submit() async {
    if (!terminosAceptados) {
      setState(() {
        _error = 'Debes aceptar los terminos y condiciones';
      });
      return;
    }

    if (_formKey.currentState?.validate() == true) {
      _formKey.currentState?.save();

      setState(() {
        _cargando = true;
      });

      widget.datosRegistro['pass'] = password.trim();
      widget.datosRegistro['pass_registro_academico'] =
          passRegistroAcademico.trim();

      try {
        final responseUsuario =
            await _service.subirDatosRegistro(widget.datosRegistro);

        // asegura que el widget aún está en pantalla
        if (!mounted) return;

        setState(() {
          if (responseUsuario.status == 'error') {
            _error = responseUsuario.mensaje;
          }
        });

        if (responseUsuario.status == 'error') return;

        if (!mounted) return;

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => RegistroConfirmadoScreen()),
          (Route<dynamic> route) =>
              false, // Esto elimina todas las rutas anteriores
        );
      } catch (e) {
        if (!mounted) return;
        setState(() {
          _error = "¡Ha ocurrido un error inesperado, inténtalo más tarde!";
        });
      } finally {
        setState(() {
          _cargando = false;
        });
      }
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

    if (_cargando) {
      return Loading();
    }

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
                    espaciado,
                    if (widget.datosRegistro['rol'] == "4" ||
                        widget.datosRegistro['rol'] == "5")
                      RegistroLabel(
                          label:
                              'Ingrese contraseña de acceso a Registro Académico:'),
                    if (widget.datosRegistro['rol'] == "4" ||
                        widget.datosRegistro['rol'] == "5")
                      RegistroInput(
                        placeholder: 'Contraseña registro académico',
                        validator: (value) => null,
                        onSaved: (newValue) =>
                            passRegistroAcademico = newValue!,
                      ),
                  ],
                ),
              )),
          Container(
            margin: EdgeInsets.symmetric(vertical: 38, horizontal: 38),
            child: Text(
              'Requisitos: * Mínimo 10 caracteres, incluye letras, números y al menos un símbolo.',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.normal,
                fontSize: 13.sp,
                color: Color.fromRGBO(14, 14, 14, 1),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 40),
            child: Align(
              alignment: Alignment.center,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 300),
                child: CheckboxListTile(
                  value: terminosAceptados,
                  onChanged: (bool? value) {
                    setState(() {
                      terminosAceptados = value ?? false;
                    });
                  },
                  title: Text(
                    "Acepto los términos y la política de tratamiento de datos de UNICAB. Tus datos están seguros con nosotros. Solo los usaremos para mejorar tu experiencia en UNICAB.",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: Colors.black,
                    ),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
          _mostrarError(),
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
