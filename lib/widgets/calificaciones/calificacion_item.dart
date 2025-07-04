import 'package:flutter/material.dart';
import '../../models/calificaciones/calificacion.dart';

class CalificacionItem extends StatelessWidget {
  final Calificacion calificacion;
  final bool isExpanded;
  final VoidCallback onToggleExpansion;

  const CalificacionItem({
    Key? key,
    required this.calificacion,
    required this.isExpanded,
    required this.onToggleExpansion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header (siempre visible) - Solo período centrado + flecha
          InkWell(
            onTap: onToggleExpansion,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFF9805),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Período centrado
                  Expanded(
                    child: Center(
                      child: Text(
                        calificacion.periodo,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  // Flecha de expansión
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),

          // Contenido expandible - Dos secciones
          if (isExpanded) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(12)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sección izquierda - Diagrama circular (fondo grisecito) - 50%
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Diagrama circular
                            SizedBox(
                              width: 120,
                              height: 120,
                              child: AspectRatio(
                                aspectRatio:
                                    1.0, // Asegura que sea perfectamente circular
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black
                                            .withValues(alpha: 0.15),
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                        spreadRadius: 1,
                                      ),
                                      BoxShadow(
                                        color: Colors.black
                                            .withValues(alpha: 0.05),
                                        blurRadius: 4,
                                        offset: const Offset(0, 1),
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      // Fondo blanco circular con profundidad
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            // Sombra interna simulada con gradiente
                                            BoxShadow(
                                              color: Colors.black
                                                  .withValues(alpha: 0.15),
                                              offset: const Offset(0, 1),
                                              blurRadius: 3,
                                              spreadRadius: -1,
                                            ),
                                            BoxShadow(
                                              color: Colors.grey
                                                  .withValues(alpha: 0.1),
                                              offset: const Offset(0, -1),
                                              blurRadius: 2,
                                              spreadRadius: 0,
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Círculo de progreso
                                      Positioned.fill(
                                        child: CircularProgressIndicator(
                                          value: _getNotaPercentage(),
                                          strokeWidth: 6,
                                          strokeCap: StrokeCap
                                              .round, // Esquinas redondeadas
                                          backgroundColor: Colors.grey[300],
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            _getNotaColor(calificacion.nota),
                                          ),
                                        ),
                                      ),
                                      // Solo porcentaje en el centro
                                      Center(
                                        child: Text(
                                          '${(_getNotaPercentage() * 100).round()}%',
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Nota debajo del círculo (más grande)
                            Text(
                              'Nota: ${calificacion.notaFormateada}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),

                            const SizedBox(height: 6),

                            // Estado del proceso
                            Text(
                              calificacion.estadoProceso,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: calificacion.estaEnProceso
                                    ? Colors.orange
                                    : Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Sección derecha - Retroalimentación - 50%
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F2F0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Título "Retroalimentación"
                          const Text(
                            'Retroalimentación',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Fecha
                          Text(
                            _formatDate(calificacion.fechaPublicacion),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Descripción
                          if (calificacion.descripcion != null &&
                              calificacion.descripcion!.isNotEmpty) ...[
                            Text(
                              calificacion.descripcion!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                                height: 1.4,
                              ),
                            ),
                          ] else ...[
                            Text(
                              'Sin descripción disponible',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                                fontStyle: FontStyle.italic,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  // Calcular porcentaje de la nota (asumiendo máximo 5.0)
  double _getNotaPercentage() {
    return (calificacion.nota / 5.0).clamp(0.0, 1.0);
  }

  Color _getNotaColor(double nota) {
    if (nota >= 4.5) return const Color(0xFF4CAF50); // Verde
    if (nota >= 4.0) return const Color(0xFF8BC34A); // Verde claro
    if (nota >= 3.5) return const Color(0xFFFFEB3B); // Amarillo
    if (nota >= 3.0) return const Color(0xFFFF9800); // Naranja
    return const Color(0xFFF44336); // Rojo
  }

  String _formatDate(String dateString) {
    try {
      final DateTime date = DateTime.parse(dateString);

      const List<String> meses = [
        '', // Mes 0 no existe
        'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
        'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'
      ];

      return '${date.day} de ${meses[date.month]} ${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}
