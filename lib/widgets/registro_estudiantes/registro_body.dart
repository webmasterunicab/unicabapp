import 'package:flutter/material.dart';
import 'package:uniconecta/models/registro/rol_modelo.dart';
import 'package:uniconecta/repositories/roles_repository.dart';
import 'package:uniconecta/screens/clave/clave_screen.dart';
import 'package:uniconecta/widgets/registro_estudiantes/registro_input.dart';
import 'package:uniconecta/widgets/registro_estudiantes/registro_label.dart';
import 'package:uniconecta/widgets/shared/orange_button.dart';

class RegistroBody extends StatefulWidget {
  const RegistroBody({super.key});

  @override
  State<RegistroBody> createState() => _RegistroBodyState();
}

class _RegistroBodyState extends State<RegistroBody> {
    final _formKey = GlobalKey<FormState>();
    final RolesRepository _repo = RolesRepository();
    List<RolModelo> _registros = [];
    String? seleccionada;

    bool _cargando = true;
    String? _error;

    @override
  void initState() {
    super.initState();
    _cargarRegistros();
  }

  Future<void> _cargarRegistros() async {
    try {
      final data = await _repo.obtenerRoles();
      setState(() {
        _registros = data;
        _cargando = false;
      });
    } catch (e) {
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

    final espaciado = SizedBox(
      height: 25.0,
    );

    if (_cargando) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_error != null) {
      return Scaffold(body: Center(child: Text('Error: $_error')));
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              decoration: decoracion,
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RegistroLabel(
                      label: '¿Cómo te llamas?',
                    ),
                    RegistroInput(
                        placeholder:
                            'Tal como te conocen en casa y en UNICAB.'),
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
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Rol',
                        border: OutlineInputBorder(),
                      ),
                      value: seleccionada,
                      items: _registros.map((rol) {
                        return DropdownMenuItem<String>(
                          value: rol.nombreRol,
                          child: Text(rol.nombreRol),
                        );
                      }).toList(),
                      onChanged: (valor) {
                        setState(() {
                          seleccionada = valor ?? '';
                        });
                      },
                      validator: (valor) {
                        if (valor == null || valor.isEmpty) {
                          return 'Por favor selecciona un rol';
                        }
                        return null;
                      },
                    ),
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
                ),
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
