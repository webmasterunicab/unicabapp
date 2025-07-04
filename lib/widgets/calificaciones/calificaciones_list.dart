import 'package:flutter/material.dart';
import '../../models/calificaciones/calificacion.dart';
import '../../repositories/calificaciones/calificaciones_repository.dart';
import 'calificacion_item.dart';

class CalificacionesList extends StatefulWidget {
  final String inscripcionId;

  const CalificacionesList({
    Key? key,
    required this.inscripcionId,
  }) : super(key: key);

  @override
  State<CalificacionesList> createState() => _CalificacionesListState();
}

class _CalificacionesListState extends State<CalificacionesList> {
  final CalificacionesRepository _repository = CalificacionesRepository();

  List<Calificacion> _calificaciones = [];
  bool _isLoading = true;
  String? _error;
  int? _expandedIndex; // Índice de la calificación expandida

  @override
  void initState() {
    super.initState();
    _cargarCalificaciones();
  }

  Future<void> _cargarCalificaciones() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final calificaciones =
          await _repository.obtenerCalificacionesPorInscripcion(
        widget.inscripcionId,
      );

      // Ordenar las calificaciones por el campo 'orden'
      calificaciones.sort((a, b) => a.orden.compareTo(b.orden));

      setState(() {
        _calificaciones = calificaciones;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Error al cargar calificaciones: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF0B77B3),
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red[300],
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                _error!,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _cargarCalificaciones,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0B77B3),
                ),
                child: const Text(
                  'Reintentar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_calificaciones.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.assessment_outlined,
                color: Colors.grey,
                size: 48,
              ),
              SizedBox(height: 16),
              Text(
                'No hay calificaciones disponibles',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _calificaciones.length,
      itemBuilder: (context, index) {
        final calificacion = _calificaciones[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: CalificacionItem(
            calificacion: calificacion,
            isExpanded: _expandedIndex == index,
            onToggleExpansion: () {
              setState(() {
                _expandedIndex = _expandedIndex == index ? null : index;
              });
            },
          ),
        );
      },
    );
  }
}
