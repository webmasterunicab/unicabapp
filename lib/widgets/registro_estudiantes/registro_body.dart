import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/models/registro/rol_modelo.dart';
import 'package:uniconecta/repositories/roles_repository.dart';
import 'package:uniconecta/screens/clave/clave_screen.dart';
import 'package:uniconecta/util/custom_form_field_validator.dart';
import 'package:uniconecta/widgets/registro_estudiantes/registro_dropdown.dart';
import 'package:uniconecta/widgets/registro_estudiantes/registro_input.dart';
import 'package:uniconecta/widgets/registro_estudiantes/registro_label.dart';
import 'package:uniconecta/widgets/shared/loading/loading.dart';
import 'package:uniconecta/widgets/shared/orange_button.dart';

class RegistroBody extends StatefulWidget {
  const RegistroBody({super.key});

  @override
  State<RegistroBody> createState() => _RegistroBodyState();
}

class _RegistroBodyState extends State<RegistroBody> {
  final RolesRepository _repo = RolesRepository();

  final _formKey = GlobalKey<FormState>();
  String nombre = '';
  String correo = '';
  String cumple = ''; //Formato fecha YYYY-MM-DD
  String ciudad = '';
  String rol = '';
  String lugaresVisitados = '';
  String porqueUnicab = '';
  String? rolSeleccionado;

  List<RolModelo> _registros = [];
  String? _error;

  bool _cargando = true;
  bool _isFormValid = false;

  void _checkForm() {
    setState(() {
      if (rolSeleccionado == null || rolSeleccionado == '') {
        _isFormValid = false;
      }

      _isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }

  void _submit() {
    if (_formKey.currentState?.validate() == true) {
      _formKey.currentState?.save();

      Map<String, dynamic> datosRegistro = {
        'nombre': nombre.trim(),
        'correo': correo.trim(),
        'cumpleaños': cumple.trim(), // Formato YYYY-MM-DD
        'ciudad': ciudad.trim(),
        'rol': rol.trim(),
        'lugaresVisitados': lugaresVisitados.trim(),
        'porqueUnicab': porqueUnicab.trim(),
      };

      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (_) => ClaveScreen(datosRegistro: datosRegistro)),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _cargarRegistros();
  }

  Future<void> _cargarRegistros() async {
    try {
      final data = await _repo.obtenerRoles();
      // asegura que el widget aún está en pantalla
      if (!mounted) return;
      setState(() {
        _registros = data;
        _cargando = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _cargando = false;
      });
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

    final espaciadoElementosForm = Padding(
      padding: EdgeInsets.only(bottom: 25),
    );

    if (_cargando) {
      return Loading();
    }

    if (_error != null) {
      return Scaffold(body: Center(child: Text('Error: $_error')));
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              width: 100.w,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 35),
              decoration: decoracion,
              child: Form(
                key: _formKey,
                // onChanged: _checkForm,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RegistroLabel(
                      label: '¿Cómo te llamas?',
                    ),
                    RegistroInput(
                      placeholder: 'Tal como te conocen en casa y en UNICAB.',
                      validator: (value) => CustomFormFieldValidator.texto(
                          value,
                          esRequerido: true,
                          nombreCampo: 'nombre'),
                      onSaved: (newValue) => nombre = newValue!,
                    ),
                    espaciadoElementosForm,
                    RegistroLabel(
                      label: '¿Cuándo es tu cumpleaños?',
                    ),
                    RegistroInput(
                      placeholder:
                          'No prometemos pastel, pero nos gusta saberlo.',
                      validator: (value) => CustomFormFieldValidator.fecha(
                          value,
                          esRequerido: true,
                          nombreCampo: 'fecha cumpleaños'),
                      onSaved: (newValue) => cumple = newValue!,
                    ),
                    espaciadoElementosForm,
                    RegistroLabel(
                      label: 'Ciudad de residencia',
                    ),
                    RegistroInput(
                      placeholder:
                          'UNICAB es virtual, pero tú tienes un mundo propio.',
                      validator: (value) => CustomFormFieldValidator.texto(
                          value,
                          esRequerido: true,
                          nombreCampo: 'ciudad de recidencia'),
                      onSaved: (newValue) => ciudad = newValue!,
                    ),
                    espaciadoElementosForm,
                    RegistroLabel(
                      label: '¿Cuál es tu rol?',
                    ),
                    RegistroDropdown(
                      registros: _registros,
                      valorSeleccionado: rolSeleccionado,
                      validator: (value) => CustomFormFieldValidator.texto(
                          value,
                          esRequerido: true,
                          nombreCampo: 'Rol'),
                      onChanged: (value) {
                        setState(() {
                          rolSeleccionado = value!;
                        });
                      },
                      onSaved: (newValue) => rol = newValue!,
                    ),
                    espaciadoElementosForm,
                    RegistroLabel(
                      label: 'Correo',
                    ),
                    RegistroInput(
                      placeholder: 'Para avisarte de cosas importantes.',
                      validator: (value) => CustomFormFieldValidator.correo(
                          value,
                          esRequerido: true,
                          nombreCampo: 'correo'),
                      onSaved: (newValue) => correo = newValue!,
                    ),
                    espaciadoElementosForm,
                    Text(
                        "Importante: los estudiantes deben registrarse con su correo institucional. Los acudientes deben hacerlo con el correo utilizado en el proceso de matrícula.",
                        style: 
                        TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.orange,
                        ),
                        ),
                    espaciadoElementosForm,
                    RegistroLabel(
                      label: '¿Qué lugares has viajado o te gustaría visitar?',
                    ),
                    RegistroInput(
                      placeholder:
                          '¿Qué sitios has explorado o sueñas conocer?',
                      validator: (value) => CustomFormFieldValidator.texto(
                          value,
                          esRequerido: false,
                          nombreCampo: 'lugares visitados'),
                      onSaved: (newValue) => lugaresVisitados = newValue!,
                    ),
                    espaciadoElementosForm,
                    RegistroLabel(
                      label: '¿Por qué elige a UNICAB?',
                    ),
                    RegistroInput(
                      placeholder:
                          'Cada historia es única. ¿Qué te trajo hasta aquí?',
                      validator: (value) => CustomFormFieldValidator.texto(
                          value,
                          esRequerido: false,
                          nombreCampo: '¿por qué UNICAB?'),
                      onSaved: (newValue) => porqueUnicab = newValue!,
                    ),
                  ],
                ),
              )),
          Container(
              margin: EdgeInsets.only(top: 55),
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
