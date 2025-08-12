import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/models/calificaciones/estudiante_modelo.dart';
import 'package:uniconecta/models/calificaciones/grado_modelo.dart';
import 'package:uniconecta/repositories/calificaciones_repository.dart';
import 'package:uniconecta/widgets/calificaciones/dropdown_calificaciones.dart';
import 'package:uniconecta/widgets/shared/loading/loading.dart';

class DropdownsCalificaciones extends StatefulWidget {
  const DropdownsCalificaciones({super.key});

  @override
  State<DropdownsCalificaciones> createState() =>
      _DropdownsCalificacionesState();
}

class _DropdownsCalificacionesState extends State<DropdownsCalificaciones> {
  final CalificacionesRepository _repo = CalificacionesRepository();
  List<GradoModelo> _grados = [];
  List<EstudianteModelo> _estudiantes = [];

  bool _cargando = true;
  String? _error;

  String? idGrado;
  String? correoEstudiante;

  @override
  void initState() {
    super.initState();
    _cargarRegistros();
  }

  Future<void> _cargarRegistros() async {
    try {
      final data = await _repo.obtenerGrados();

      if (!mounted) return;
      setState(() {
        _grados = data.grados;
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

  Future<void> _cargarEstudiantes() async {
    _cargando = true;

    try {
      if (idGrado == null) return;

      final data = await _repo.obtenerEstudiantesPorGrado({"idGrado": idGrado});

      if (!mounted) return;
      setState(() {
        _estudiantes = data.estudiantes;
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

  Widget _loader () {
     return Container(
      margin: EdgeInsets.only(top: 5.h),
       child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0B77B3)),
        ),
           ),
     );
  }

  Widget _mostrarDropdownEstudiantes() {
    if (_estudiantes.isNotEmpty) {
      return SizedBox(
        width: 80.w,
        child: DropdownCalificaciones(
          estudiantes: _estudiantes,
          hintText: "Selecciona un estudiante",
          validator: (String? value) {
            if (value == "NA") {
              return "Debe seleccionar un estudiante";
            }
            return null;
          },
          valorSeleccionado: correoEstudiante,
          onChanged: (value) {
            setState(() {
              correoEstudiante = value!;
            });
          },
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_cargando) {
      return _loader();
    }

    return SafeArea(
        child: Column(
      children: [
        SizedBox(
          height: 2.h,
        ),
        SizedBox(
          width: 80.w, // ajusta ancho
          child: DropdownCalificaciones(
            grados: _grados,
            hintText: "Selecciona un Grado",
            validator: (String? value) {
              if (value == "NA") {
                return "Debe seleccionar un grado valido";
              }
              return null;
            },
            valorSeleccionado: idGrado,
            onChanged: (value) {
              setState(() {
                if (value != "NA") {
                  idGrado = value;
                }

                correoEstudiante = null;
              });

              _cargarEstudiantes();
            },
          ),
        ),
        SizedBox(height: 2.h),
        _mostrarDropdownEstudiantes(),
      ],
    ));
  }
}
