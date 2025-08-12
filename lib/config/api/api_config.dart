import 'dart:io';

import 'package:flutter/foundation.dart';

class ApiConfig {
  static final String enviroment = 'dev';
  static final String development =
      'http://192.168.1.13/hostuniconecta/requests';
  static final String developmentChrome =
      'http://localhost/hostuniconecta/requests';
  static final String production = 'https://unicab.org/uniconecta';
  // Base URL de la API - Se adapta automáticamente según la plataforma
  static String get baseUrl {
    String baseUrl = '';

    baseUrl = development;
    if (!kIsWeb) {
      if (Platform.isAndroid) return baseUrl;
      if (Platform.isIOS) return baseUrl;
    }

    return developmentChrome;
  }

  // URLs alternativas para debug
  // static const String localhostUrl =
  //     'http://localhost:80/hostuniconecta/requests';
  // static const String androidEmulatorUrl =
  //     'http://10.0.2.2:80/hostuniconecta/requests';

  // Endpoints específicos
  static String get usuariosRolesL => '${ApiConfig.baseUrl}/registro/roles.php';
  static String get registrarUsuarioL => '${ApiConfig.baseUrl}/registro/registrar_usuario.php';
  static String get subirImagen => '$production/imagen_putdat1.php';
  static String get registrarUsuario => '$production/registro_putdat1.php';
  static String get usuariosRoles => '$production/roles_getdat1.php';
  static String get grados => '$production/grados_getdat1.php';
  static String get estudiantesGrado => '$production/estudiantes_grado_getdat1.php';
  // static String get menusUrl => '$baseUrl/general/menus.php';
  // static String get estudiantesUrl => '$baseUrl/general/estudiantes.php';
  // static String get noticiasUrl => '$baseUrl/general/noticias.php';
  // static String get materiasUrl => '$baseUrl/calificaciones/materias.php';
  // static String get materiasEstudianteUrl =>
  //     '$baseUrl/calificaciones/materias_estudiante.php';
  // static String get calificacionesInscripcionUrl =>
  //     '$baseUrl/calificaciones/calificaciones_inscripcion.php';

  // Headers por defecto para las peticiones
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Timeout por defecto (en segundos)
  static const Duration defaultTimeout = Duration(seconds: 30);
}
