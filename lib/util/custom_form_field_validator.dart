class CustomFormFieldValidator {
  static String? texto(
    String? value, {
    required bool esRequerido,
    String nombreCampo = 'Campo',
  }) {
    if ((value == null || value.trim().isEmpty || value == 'NA') && esRequerido) {
      return 'Campo: $nombreCampo es obilgatorio';
    }
    final regex = RegExp(
        r'''[-_'"<>\~\^\*\$\!\¡\#\%\&\¿\?\/\=\+\|,;:\(\)\{\}\[\]\\]{1,}''');

    if (regex.hasMatch(value!)) {
      return 'El campo $nombreCampo no permite \nsímbolos especiales';
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
      return 'Campo: $nombreCampo es obilgatorio';
    }
    final regex = RegExp(r'''^[0-9]{4}-[0-1][0-9]-[0-3][0-9]$''');
    if (!regex.hasMatch(value!)) return 'Formato inválido. Ej: 2024-05-21';
    return null;
  }

  static String? password(
    String? value, {
    required bool esRequerido,
    String nombreCampo = 'Contraseña',
  }) {
    if ((value == null || value.trim().isEmpty) && esRequerido) return 'Campo: $nombreCampo es obilgatorio';
    if (value!.length < 8) return 'Debe tener al menos 8 caracteres';
    final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$');
    if (!regex.hasMatch(value)) {
      return 'Debe tener al menos 1 mayúscula, \n1 minúscula y 1 número';
    }
    return null;
  }

  static String? passwordConfirmation(String? pass1, String? pass2, { bool esRequerido = true, String nombreCampo = 'confirmar contraseña'}) {
    if (esRequerido && (pass1 == null || pass2 == null || pass1 == '' || pass2 == '')) return 'Campo: $nombreCampo es obilgatorio';
    if(pass1 != pass2) return 'Las contraseñas no son iguales!';
    return null;
  }
}
