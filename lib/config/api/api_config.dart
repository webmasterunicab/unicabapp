import 'dart:io';

class ApiConfig {
  static final String enviroment = 'dev';
  static final String development =
      'http://localhost/hostuniconecta/requests';
  static final String production = '';
  // Base URL de la API - Se adapta automáticamente según la plataforma
  static String get baseUrl {
    String baseUrl = '';

    if (enviroment == 'prod') {
      baseUrl = production;
    } else {
      baseUrl = development;
    }

    return baseUrl;
  }

  // URLs alternativas para debug
  // static const String localhostUrl =
  //     'http://localhost:80/hostuniconecta/requests';
  // static const String androidEmulatorUrl =
  //     'http://10.0.2.2:80/hostuniconecta/requests';

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
  
}
