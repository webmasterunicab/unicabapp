import 'package:flutter/material.dart';
import '../screens/calificaciones/materias_screen.dart';

class AppRoutes {
  static final Map<String, Widget Function()> _routes = {
    'calificaciones/materias_screen': () => const MateriasScreen(),
    
  };

  /// Obtener el widget builder para una ruta específica
  static Widget Function()? getRouteBuilder(String routePath) {
    return _routes[routePath];
  }

  /// Verificar si una ruta está registrada
  static bool isRouteRegistered(String routePath) {
    return _routes.containsKey(routePath);
  }

  /// Registrar una nueva ruta dinámicamente (útil para testing o rutas runtime)
  static void registerRoute(String routePath, Widget Function() builder) {
    _routes[routePath] = builder;
  }

  /// Obtener todas las rutas registradas (útil para debugging)
  static Map<String, Widget Function()> getAllRoutes() {
    return Map.unmodifiable(_routes);
  }

  /// Navegar a una ruta específica
  ///
  /// Este método es usado por OptionItem para navegar automáticamente
  /// basándose en la dirección que viene del endpoint
  static void navigateToRoute(BuildContext context, String routePath) {
    final builder = getRouteBuilder(routePath);

    if (builder != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => builder()),
      );
    } else {
      // Ruta no encontrada - lanzar excepción para manejo de errores
      throw RouteNotFoundException(routePath);
    }
  }
}

/// Excepción personalizada para rutas no encontradas
class RouteNotFoundException implements Exception {
  final String routePath;

  const RouteNotFoundException(this.routePath);

  @override
  String toString() => 'Route not found: $routePath';
}
