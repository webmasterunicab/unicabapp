import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/models/calificaciones/linea_calificacion.dart';
import 'package:uniconecta/repositories/calificaciones_repository.dart';
import 'package:uniconecta/screens/calificaciones/calificaciones_especificas_screen.dart';
import 'package:uniconecta/widgets/shared/error_mensaje.dart';
import 'package:uniconecta/util/chart_utils.dart'; // ← ¡Importa la función de promedios!
import 'package:uniconecta/widgets/calificaciones/calificacion_promedio_chart.dart'; // ← ¡Importa el widget!

class PensamientosGrid extends StatefulWidget {
  final int rol;
  final String email;
  final String estudiante;

  const PensamientosGrid(
      {super.key,
      required this.rol,
      required this.email,
      required this.estudiante});

  @override
  State<PensamientosGrid> createState() => _PensamientosGridState();
}

class _PensamientosGridState extends State<PensamientosGrid> {
  final CalificacionesRepository _repo = CalificacionesRepository();

  String? estudiante;
  bool _cargando = true;
  String? _error;

  final Map<String, List<LineaCalificacion>> agrupados = {
    'bioetico': [],
    'matematico': [],
    'esp': [],
    'ingles': [],
    'social': [],
    'tecnologico': []
  };

  @override
  void initState() {
    super.initState();
    _cargarRegistros();
  }

  Map<String, double> promedios = {};

  Future<void> _cargarRegistros() async {
    try {
      final data =
          await _repo.obtenerCalificaciones({"email": widget.email, "rol": 1});

      promedios = calcularPromediosPorPensamiento(data.lineas);

      for (final linea in data.lineas) {
        if (linea.pensamiento.toLowerCase().contains('bioético')) {
          agrupados['bioetico']?.add(linea);
        } else if (linea.pensamiento.toLowerCase().contains('numérico')) {
          agrupados['matematico']?.add(linea);
        } else if (linea.pensamiento.toLowerCase().contains('humanístico i')) {
          agrupados['ingles']?.add(linea);
        } else if (linea.pensamiento.toLowerCase().contains('humanístico') ||
            linea.pensamiento.toLowerCase().contains('humanístico e')) {
          agrupados['esp']?.add(linea);
        } else if (linea.pensamiento.toLowerCase().contains('social')) {
          agrupados['social']?.add(linea);
        } else if (linea.pensamiento.toLowerCase().contains('tecnológico')) {
          agrupados['tecnologico']?.add(linea);
        }
      }

      if (!mounted) return;
      setState(() {
        if (data.status != "error") {
          estudiante = widget.estudiante == ''
              ? data.estudiante.nombre
              : widget.estudiante;
        } else {
          _error = data.mensaje;
        }
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = '¡Ha ocurrido un error inesperado, inténtalo más tarde!';
      });
    } finally {
      setState(() {
        _cargando = false;
      });
    }
  }

  Widget buildErrorWidget(String? error) {
    if (error == null || error.isEmpty) {
      return const SizedBox.shrink(); // No muestra nada si no hay error
    }

    return Container(
        margin: EdgeInsets.only(top: 10.h, left: 5.w, right: 5.w),
        padding: EdgeInsets.all(3.w),
        child: ErrorMensaje(mensaje: error));
  }

  final String gif = 'assets/img/cerebro.gif';

  final List<Map<String, String>> elementos = const [
    {'img': 'assets/img/matematicas.png', 'text': 'Numérico'},
    {'img': 'assets/img/bioetico.png', 'text': 'Bioético'},
    {'img': 'assets/img/español.png', 'text': 'Humanístico Español'},
    {'img': 'assets/img/ingles.png', 'text': 'Humanístico Inglés'},
    {'img': 'assets/img/social.png', 'text': 'Social'},
    {'img': 'assets/img/tecnologico.png', 'text': 'Tecnológico'},
  ];

  Widget _buildButton(Map<String, String> data, GestureTapCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            data['img']!,
            width: 35.w,
            height: 35.w,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                gif,
                fit: BoxFit.contain,
                height: 10.w,
                width: 10.w,
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 30.w,
                child: Text(
                  "Pensamiento ${data['text']}",
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
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

    return SingleChildScrollView(
        child: Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 10.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Acumulado por Pensamiento (línea roja = 3.5)",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
          ),
          SizedBox(height: 2.h),
          SizedBox(
            //height: 100, // ← Altura fija
            width: double.infinity,
            child: CalificacionChart(promedios: promedios),
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              _buildButton(elementos[0], () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => CalificacionesEspecificasScreen(
                        tituloPensamiento: elementos[0]['text']!,
                        calificaciones: agrupados['matematico']!,
                        estudiante: estudiante!)));
              }),
              SizedBox(width: 8.w),
              _buildButton(elementos[1], () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => CalificacionesEspecificasScreen(
                        tituloPensamiento: elementos[1]['text']!,
                        calificaciones: agrupados['bioetico']!,
                        estudiante: estudiante!)));
              }),
            ],
          ),
          SizedBox(height: 1.h),
          Row(
            children: [
              _buildButton(elementos[2], () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => CalificacionesEspecificasScreen(
                        tituloPensamiento: elementos[2]['text']!,
                        calificaciones: agrupados['esp']!,
                        estudiante: estudiante!)));
              }),
              SizedBox(width: 8.w),
              _buildButton(elementos[3], () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => CalificacionesEspecificasScreen(
                        tituloPensamiento: elementos[3]['text']!,
                        calificaciones: agrupados['ingles']!,
                        estudiante: estudiante!)));
              }),
            ],
          ),
          SizedBox(height: 1.h),
          Row(
            children: [
              _buildButton(elementos[4], () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => CalificacionesEspecificasScreen(
                        tituloPensamiento: elementos[4]['text']!,
                        calificaciones: agrupados['social']!,
                        estudiante: estudiante!)));
              }),
              SizedBox(width: 8.w),
              _buildButton(elementos[5], () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => CalificacionesEspecificasScreen(
                        tituloPensamiento: elementos[5]['text']!,
                        calificaciones: agrupados['tecnologico']!,
                        estudiante: estudiante!)));
              }),
            ],
          ),
        ],
      ),
    ));
  }
}
