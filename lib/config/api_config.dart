import 'dart:io';

class ApiConfig {
  // Base URL de la API - Se adapta automáticamente según la plataforma
  static String get baseUrl {
    if (Platform.isAndroid) {
      // Android Emulator: Prueba primero 10.0.2.2, si no funciona usa IP real
      // return 'http://10.0.2.2:80/hostuniconecta/requests';
      return 'http://192.168.80.12:80/hostuniconecta/requests'; // Tu IP local
    } else if (Platform.isIOS) {
      // iOS Simulator: localhost funciona directamente
      return 'http://localhost:80/hostuniconecta/requests';
    } else {
      // Para desarrollo web o desktop
      return 'http://localhost:80/hostuniconecta/requests';
    }
  }

  // URLs alternativas para debug
  static const String localhostUrl =
      'http://localhost:80/hostuniconecta/requests';
  static const String androidEmulatorUrl =
      'http://10.0.2.2:80/hostuniconecta/requests';

  // Endpoints específicos
  static String get opcionesUrl => '$baseUrl/general/opciones.php';
  static String get menusUrl => '$baseUrl/general/menus.php';
  static String get estudiantesUrl => '$baseUrl/general/estudiantes.php';
  static String get noticiasUrl => '$baseUrl/general/noticias.php';
  static String get materiasUrl => '$baseUrl/calificaciones/materias.php';
  static String get materiasEstudianteUrl =>
      '$baseUrl/calificaciones/materias_estudiante.php';
  static String get calificacionesInscripcionUrl =>
      '$baseUrl/calificaciones/calificaciones_inscripcion.php';

  // Headers por defecto para las peticiones
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Timeout por defecto (en segundos)
  static const Duration defaultTimeout = Duration(seconds: 30);

  // Método para debug - mostrar configuración actual
  static void printConfig() {
  }
}
