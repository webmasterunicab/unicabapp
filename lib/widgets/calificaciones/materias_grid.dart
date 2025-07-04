import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/student_provider.dart';
import '../../repositories/calificaciones/materias_repository.dart';
import '../../repositories/calificaciones/inscripciones_repository.dart';
import '../../models/calificaciones/materia.dart';
import '../../screens/calificaciones/calificaciones_screen.dart';

class MateriasGrid extends StatefulWidget {
  const MateriasGrid({Key? key}) : super(key: key);

  @override
  State<MateriasGrid> createState() => _MateriasGridState();
}

class _MateriasGridState extends State<MateriasGrid> {
  final MateriasRepository _materiasRepository = MateriasRepository();
  final InscripcionesRepository _inscripcionesRepository =
      InscripcionesRepository();

  List<Materia> _materias = [];
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cargarMaterias();
    });
  }

  Future<void> _cargarMaterias() async {
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);

    if (!studentProvider.hasStudent) {
      setState(() {
        _error = 'No hay estudiante seleccionado';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final estudianteId = studentProvider.currentStudentId;

      // 1. Obtener inscripciones del estudiante
      final inscripciones = await _materiasRepository
          .obtenerInscripcionesPorEstudiante(estudianteId);

      // 2. Extraer IDs de materias
      final materiaIds = inscripciones.map((i) => i.materiaId).toList();

      // 3. Obtener datos específicos de las materias
      final materias =
          await _inscripcionesRepository.obtenerMateriasPorIds(materiaIds);

      setState(() {
        _materias = materias;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Error al cargar materias: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _navigateToCalificaciones(Materia materia) async {
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);

    try {
      // Obtener la inscripción del estudiante para esta materia
      final inscripciones = await _materiasRepository
          .obtenerInscripcionesPorEstudiante(studentProvider.currentStudentId);

      // Buscar la inscripción correspondiente a esta materia
      final inscripcion = inscripciones.firstWhere(
        (i) => i.materiaId == materia.id,
        orElse: () =>
            throw Exception('No se encontró inscripción para esta materia'),
      );

      // Navegar a la pantalla de calificaciones
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CalificacionesScreen(
            inscripcionId: inscripcion.id,
            materiaName: materia.nombre,
          ),
        ),
      );
    } catch (e) {
      // Mostrar error si no se puede navegar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al abrir calificaciones: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: CircularProgressIndicator(
            color: Color(0xFF0B77B3),
          ),
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
              const SizedBox(height: 50),
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
                onPressed: _cargarMaterias,
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

    if (_materias.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.school_outlined,
                color: Colors.grey,
                size: 48,
              ),
              SizedBox(height: 16),
              Text(
                'No hay materias disponibles',
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

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: _materias.length,
          itemBuilder: (context, index) {
            final materia = _materias[index];
            return _buildMateriaCard(materia);
          },
        ),
      ),
    );
  }

  Widget _buildMateriaCard(Materia materia) {
    return GestureDetector(
      onTap: () {
        // Navegación a calificaciones de la materia
        _navigateToCalificaciones(materia);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0B77B3),
              Color(0xFF0A5D8A),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Patrón de fondo sutil
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white.withValues(alpha: 0.05),
                  backgroundBlendMode: BlendMode.overlay,
                ),
                child: CustomPaint(
                  painter: _PatternPainter(),
                ),
              ),
            ),
            // Contenido
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icono de materia
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.school,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Nombre de la materia
                  Text(
                    materia.nombre,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Código de la materia (si existe)
                  if (materia.codigo != null && materia.codigo!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      materia.codigo!,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Painter para crear un patrón de fondo sutil
class _PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const spacing = 20.0;

    // Líneas diagonales
    for (double i = -size.height; i < size.width + size.height; i += spacing) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
