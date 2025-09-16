import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/models/registro/rol_modelo.dart';
import 'package:uniconecta/models/shared/user.dart';
import 'package:uniconecta/providers/user_provider.dart';
import 'package:uniconecta/repositories/usuario_service.dart';
import 'package:uniconecta/repositories/roles_repository.dart';
import 'package:uniconecta/screens/clave/clave_screen.dart';
import 'package:uniconecta/screens/general/general_screen.dart';
import 'package:uniconecta/util/custom_form_field_validator.dart';
import 'package:uniconecta/util/enums/ajustar_perfil/proceso.dart';
import 'package:uniconecta/widgets/registro_estudiantes/registro_dropdown.dart';
import 'package:uniconecta/widgets/registro_estudiantes/registro_input.dart';
import 'package:uniconecta/widgets/registro_estudiantes/registro_label.dart';
import 'package:uniconecta/widgets/shared/error_mensaje.dart';
import 'package:uniconecta/widgets/shared/loading/loading.dart';
import 'package:uniconecta/widgets/shared/orange_button.dart';

class RegistroBody extends StatefulWidget {
  final Proceso proceso;
  const RegistroBody({super.key, required this.proceso});

  @override
  State<RegistroBody> createState() => _RegistroBodyState();
}

class _RegistroBodyState extends State<RegistroBody> {
  final RolesRepository _repo = RolesRepository();
  final UsuarioService _registro = UsuarioService();

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

  void _submit() async {
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

      if (widget.proceso == Proceso.registro) {
        datosRegistro['proceso'] = 'Registro';
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (_) => ClaveScreen(datosRegistro: datosRegistro)),
        );
      }

      if (widget.proceso == Proceso.ajustarPerfil) {
        final provider = context.read<UserProvider>();
        datosRegistro['proceso'] = 'Ajustar perfil';
        datosRegistro['rol'] = provider.user!.userRole.toString();
        datosRegistro['pass'] = provider.user!.pass;
        final response = await _registro.subirDatosRegistro(datosRegistro);
        if (response.status != 'error') {
          provider.updateUser(
            name: nombre.trim(),
            email: correo.trim(),
            birthday: cumple.trim(),
            city: ciudad.trim(),
            visitedPlaces: lugaresVisitados.trim(),
            whyUnicab: porqueUnicab.trim(),
          );
        } else {
          _error = response.mensaje;
        }

        if (!mounted) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => GeneralScreen()),
          (Route<dynamic> route) =>
              false, // Esto elimina todas las rutas anteriores
        );
      }
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
        _error = '¡Ha ocurrido un error inesperado, inténtalo más tarde!';
        _cargando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider provider = context.watch<UserProvider>();
    User? user = provider.user;
    String initNombre = user?.name ?? '';
    String initCorreo = user?.email ?? '';
    String initCumple = user?.birthday ?? '';
    String initCiudad = user?.city ?? '';
    String initLugares = user?.visitedPlaces ?? '';
    String initPorqueUnicab = user?.whyUnicab ?? '';

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
                      initialValue: initNombre,
                      placeholder: 'Tal como te conocen en casa y en UNICAB.',
                      validator: (value) => CustomFormFieldValidator.texto(
                          value,
                          esRequerido: true,
                          nombreCampo: 'nombre'),
                      onSaved: (newValue) => nombre = newValue!,
                    ),
                    espaciadoElementosForm,
                    RegistroLabel(
                      label: '¿Cuándo es tu cumpleaños? (YYYY-MM-DD)',
                    ),
                    RegistroInput(
                      initialValue: initCumple,
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
                      initialValue: initCiudad,
                      placeholder:
                          'UNICAB es virtual, pero tú tienes un mundo propio.',
                      validator: (value) => CustomFormFieldValidator.texto(
                          value,
                          esRequerido: true,
                          nombreCampo: 'ciudad de recidencia'),
                      onSaved: (newValue) => ciudad = newValue!,
                    ),
                    espaciadoElementosForm,
                    if (widget.proceso == Proceso.registro)
                      RegistroLabel(
                        label: '¿Cuál es tu rol?',
                      ),
                    if (widget.proceso == Proceso.registro)
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
                    if (widget.proceso == Proceso.registro)
                      espaciadoElementosForm,
                    RegistroLabel(
                      label: 'Correo',
                    ),
                    RegistroInput(
                      initialValue: initCorreo,
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
                      style: TextStyle(
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
                      initialValue: initLugares,
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
                      initialValue: initPorqueUnicab,
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
          if (_error != null)
            Container(
                margin: EdgeInsets.symmetric(vertical: 2.w, horizontal: 2.w),
                padding: EdgeInsets.all(4.w),
                child: ErrorMensaje(mensaje: _error!)),
          Container(
              margin: EdgeInsets.symmetric(vertical: 25),
              child: OrangeButton(
                onPressed: () {
                  _checkForm();
                  if (_isFormValid) _submit();
                },
                buttonText: widget.proceso == Proceso.registro
                    ? '¡Listo, sigamos!'
                    : 'Actualizar perfil',
                textWeight: FontWeight.w600,
                fontSize: 16.sp,
              )),
          // Container(
          //   margin: EdgeInsets.only(top: 55),
          //   child: TextButton(
          //       onPressed: () {
          //         // Acción al presionar
          //       },
          //       child: Text(
          //         'Términos y privacidad (Enlace a políticas de datos)',
          //         style: TextStyle(
          //           fontFamily: 'Roboto',
          //           fontWeight: FontWeight.w400,
          //           fontSize: 14.sp,
          //           color: Colors.black,
          //         ),
          //       )),
          // ),
        ],
      ),
    );
  }
}
