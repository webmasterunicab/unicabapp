class CustomFormFieldValidator {
  static String? texto(
    String? value, {
    required bool esRequerido,
    String nombreCampo = 'Campo',
  }) {
    if ((value == null || value.trim().isEmpty || value == 'NA') &&
        esRequerido) {
      return 'Campo: $nombreCampo es obilgatorio';
    }
    final regex = RegExp(
        r'''[-_'"<>\~\^\*\$\!\¡\#\%\&\¿\?\/\=\+\|,;:\(\)\{\}\[\]\\]{1,}''');

    if (regex.hasMatch(value!)) {
      return 'El campo $nombreCampo no permite\nsímbolos especiales\n- _ \' " < > ~ ^ * \$ ! ¡ # % & ¿ ? / = + , ; : ( ) { } [ ] \\ ';
    }

    return null;
  }

  static String? texto1(
    String? value, {
    required bool esRequerido,
    String nombreCampo = 'Campo',
  }) {
    if ((value == null || value.trim().isEmpty) && esRequerido) {
      return 'Campo: $nombreCampo es obilgatorio';
    }
    final regex = RegExp(
        r'''[_'"<>\~\^\*\$\!\¡\#\%\&\¿\?\/\=\+\|,;:\(\)\{\}\[\]\\]{1,}''');
    if (regex.hasMatch(value!)) return 'Caracteres inválidos detectados';
    return null;
  }

  static String? correo(
    String? value, {
    required bool esRequerido,
    String nombreCampo = 'Correo',
  }) {
    if ((value == null || value.trim().isEmpty) && esRequerido) {
      return 'Campo: $nombreCampo es obilgatorio';
    }
    final regex = RegExp(r'''^[_\-\w.]+@[a-z]+\.[a-z\.]{2,7}$''');
    if (!regex.hasMatch(value!)) return 'Correo no válido';
    return null;
  }

  static String? numero(
    String? value, {
    required bool esRequerido,
    String nombreCampo = 'Campo',
  }) {
    if ((value == null || value.trim().isEmpty) && esRequerido) {
      return 'Campo: $nombreCampo es obilgatorio';
    }
    final regex = RegExp(r'''^[0-9]{1,}$''');
    if (!regex.hasMatch(value!)) return 'Solo se permiten números';
    return null;
  }

  static String? fecha(
    String? value, {
    required bool esRequerido,
    String nombreCampo = 'fecha',
  }) {
    if ((value == null || value.trim().isEmpty) && esRequerido) {
      return 'Campo: $nombreCampo es obligatorio';
    }

    // Validación inicial de formato (YYYY-MM-DD)
    final regex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    if (!regex.hasMatch(value!)) {
      return 'Formato inválido. Ej: 2024-05-21';
    }

    // Intentar parsear la fecha
    final partes = value.split('-');
    final anio = int.tryParse(partes[0]);
    final mes = int.tryParse(partes[1]);
    final dia = int.tryParse(partes[2]);

    if (anio == null || mes == null || dia == null) {
      return 'Fecha inválida';
    }

    // Validar año
    final anioActual = DateTime.now().year;
    if (anio > anioActual) {
      return 'El año no puede ser mayor a $anioActual';
    }

    // Validar mes
    if (mes < 1 || mes > 12) {
      return 'El mes debe estar entre 01 y 12';
    }

    // Validar días usando DateTime (detecta meses y años bisiestos)
    try {
      final fecha = DateTime(anio, mes, dia);
      if (fecha.year != anio || fecha.month != mes || fecha.day != dia) {
        return 'El día no es válido para el mes';
      }
    } catch (_) {
      return 'Fecha inválida';
    }

    return null;
  }

  static String? password(
    String? value, {
    required bool esRequerido,
    String nombreCampo = 'Contraseña',
  }) {
    if ((value == null || value.trim().isEmpty) && esRequerido) {
      if (nombreCampo.length > 17) {
        nombreCampo = "$nombreCampo\n";
      }

      return 'Campo: $nombreCampo es obligatorio';
    }

    final regex = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!¡%#*¿?&])[A-Za-z\d@$!¡%#*¿?&]{10,12}$');

    if (!regex.hasMatch(value!)) {
      return 'Debe tener entre 10 y 12 caracteres, con al menos:\n'
          '- 1 letra minúscula '
          '- 1 letra mayúscula\n'
          '- 1 número '
          '- 1 carácter especial\n'
          'No se permiten - y _ como carácter espercial';
    }

    return null;
  }

  static String? passwordConfirmation(String? pass1, String? pass2,
      {bool esRequerido = true, String nombreCampo = 'confirmar contraseña'}) {
    if (esRequerido &&
        (pass1 == null || pass2 == null || pass1 == '' || pass2 == '')) {
      return 'Campo: $nombreCampo es obilgatorio';
    }
    if (pass1 != pass2) return 'Las contraseñas no son iguales!';
    return null;
  }
}
