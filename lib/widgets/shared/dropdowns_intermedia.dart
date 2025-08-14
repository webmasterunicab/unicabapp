import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/models/intermedia_screen/estudiante_modelo.dart';
import 'package:uniconecta/models/intermedia_screen/grado_modelo.dart';
import 'package:uniconecta/repositories/intermedia_repository.dart';
import 'package:uniconecta/screens/calificaciones/calificaciones_screen.dart';
import 'package:uniconecta/widgets/shared/dropdown_intermedia.dart';

class DropdownsIntermedia extends StatefulWidget {
  final int rol;
  final String email;
  final String siguientePantalla;

  const DropdownsIntermedia(
      {super.key,
      required this.rol,
      required this.email,
      required this.siguientePantalla});

  @override
  State<DropdownsIntermedia> createState() =>
      _DropdownsIntermediaState();
}

class _DropdownsIntermediaState extends State<DropdownsIntermedia> {
  final IntermediaRepository _repo = IntermediaRepository();
  List<GradoModelo> _grados = [];
  List<EstudianteModelo> _estudiantes = [];

  bool _cargando = true;
  String? _error;

  String? idGrado;
  String? correoEstudiante;

  @override
  void initState() {
    super.initState();

    if (widget.rol == 2) {
      _cargarEstudiantesPorAcudiente();
    } else {
      _cargarRegistros();
    }
  }

  Future<void> _cargarRegistros() async {
    try {
      final data = await _repo.obtenerGrados();

      if (!mounted) return;
      setState(() {
        if (data.status != "error") {
          _grados = data.grados;
        } else {
          _error = data.mensaje;
        }
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

  Future<void> _cargarEstudiantesPorGrado() async {
    _cargando = true;

    try {
      if (idGrado == null) return;

      final data = await _repo.obtenerEstudiantesPorGrado({"idGrado": idGrado});

      if (!mounted) return;
      setState(() {
        if (data.status != "error") {
          _estudiantes = data.estudiantes;
        } else {
          _error = data.mensaje;
        }
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

  Future<void> _cargarEstudiantesPorAcudiente() async {
    _cargando = true;

    try {
      if (widget.rol != 2) return;

      final data =
          await _repo.obtenerEstudiantesPorAcudiente({"email": widget.email});

      if (!mounted) return;
      setState(() {
        if (data.status != "error") {
          _estudiantes = data.estudiantes;
        } else {
          _error = data.mensaje;
        }
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

  Widget _loader() {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
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
        child: DropdownIntermedia(
          estudiantes: _estudiantes,
          hintText: "Selecciona un estudiante",
          validator: (String? value) {
            if (value == "NINGUNO") {
              return "Debe seleccionar un estudiante";
            }
            return null;
          },
          valorSeleccionado: correoEstudiante,
          onChanged: (value) {
            setState(() {
              if (correoEstudiante == 'NINGUNO' || value! == 'NINGUNO') {
                correoEstudiante = null;
                return;
              } else {
                correoEstudiante = value;
              }
            });

            if (widget.siguientePantalla == "calificaciones") {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => CalificacionesScreen(rol: 1, email: value!)));
            }

          },
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _mostrarDropdownGrados() {
    if (widget.rol != 1 && widget.rol != 2) {
      return SizedBox(
        width: 80.w, // ajusta ancho
        child: DropdownIntermedia(
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

            _cargarEstudiantesPorGrado();
          },
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget buildErrorWidget(String? error) {
    if (error == null || error.isEmpty) {
      return const SizedBox.shrink(); // No muestra nada si no hay error
    }

    return Container(
      margin: EdgeInsets.only(top: 10.h, left: 5.w, right: 5.w),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade300, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withValues(alpha: 0.1), // nuevo método
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade400, size: 18.sp),
          SizedBox(width: 2.w),
          Expanded(
            child: Text(
              error,
              style: TextStyle(
                color: Colors.red.shade800,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_cargando) {
      return _loader();
    }

    if (_error != null) {
      return SafeArea(
        child: buildErrorWidget(_error),
      );
    }

    return SafeArea(
        child: Column(
      children: [
        _mostrarDropdownGrados(),
        SizedBox(height: 2.h),
        _mostrarDropdownEstudiantes(),
      ],
    ));
  }
}
