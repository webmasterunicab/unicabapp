import 'package:uniconecta/models/calificaciones/linea_calificacion.dart';

/// Calcula el promedio de calificaciones por pensamiento
/// Recibe una lista de "lineas" del JSON y devuelve un Map con los promedios.
Map<String, double> calcularPromediosPorPensamiento(
    List<LineaCalificacion> lineas) {
  // Creamos un mapa para agrupar calificaciones por pensamiento
  Map<String, List<double>> grupos = {};

  for (var item in lineas) {
    // Extraemos el nombre del pensamiento
    String pensamiento = item.pensamiento;

    // Convertimos la calificación a double (por si viene como string)
    double calificacion = double.tryParse(item.calificacion) ?? 0.0;

    // Si no existe el pensamiento en el mapa, lo creamos con una lista vacía
    grupos.putIfAbsent(pensamiento, () => []);

    // Añadimos la calificación a la lista de ese pensamiento
    grupos[pensamiento]!.add(calificacion);
  }

  // Ahora calculamos el promedio para cada pensamiento
  Map<String, double> promedios = {};
  for (var entry in grupos.entries) {
    List<double> calificaciones = entry.value;
    double suma = calificaciones.reduce((a, b) => a + b);
    double promedio = suma / calificaciones.length;
    promedios[entry.key] = promedio;
  }

  return promedios;
}
