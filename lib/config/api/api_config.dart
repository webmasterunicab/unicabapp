import 'dart:io';

import 'package:flutter/foundation.dart';

class ApiConfig {
  static final String enviroment = 'dev';
  static final String development =
      'http://192.168.1.12/hostuniconecta/requests';
  static final String developmentChrome =
      'http://localhost/hostuniconecta/requests';
  static final String https = 'unicab.org';
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
  static String get sesionVerify => 'uniconecta/login_getdat1.php';
  static String get recoverPassword => 'uniconecta/olvido_password.php';
  static String get getRemarks => 'uniconecta/observador_getdat1.php';
  static String get getFinancial => 'uniconecta/financiera_getdat1.php';
  static String get cambiarPassword => 'uniconecta/cambio_pass_upddat1.php';
  static String get sendPaymentSupport => 'uniconecta/soporte_putdat1.php';
  static String get estudiantesAcudiente => '$production/estudiantes_acudiente_getdat1.php';
  static String get estudiantesCalificaciones => '$production/calificaciones_getdat1.php';
  static String get estudianteGrado => '$production/grado_getdat1.php';
  static String get subirPublicacion => '$production/publicacion_putdat1.php';
  static String get obtenerMisPublicaciones => '$production/publicaciones_getdat1.php';
  static String get obtenerTodasPublicaciones => '$production/todas_publicaciones_getdat1.php';
  static String get darLikePublicacion => '$production/megusta_publicacion_putdat1.php';
  static String get actualizarFotoPerfil => '$production/cambio_foto_perfil_upddat1.php';
  static String get eliminarCuenta => '$production/eliminar_usuario_deldat1.php';
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
