import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/models/shared/user.dart';
import 'package:uniconecta/repositories/comunidad_repository.dart';
import 'package:uniconecta/screens/comunidad/comunidad_mis_publicaciones.dart';
import 'package:uniconecta/screens/comunidad/comunidad_todas_publicaciones.dart';
import 'package:uniconecta/util/custom_form_field_validator.dart';
import 'package:uniconecta/widgets/comunidad/imagen_publicacion.dart';
import 'package:uniconecta/widgets/comunidad/warning_publicacion.dart';
import 'package:uniconecta/widgets/shared/error_mensaje.dart';
import 'package:uniconecta/widgets/shared/orange_button.dart';
import 'package:uniconecta/widgets/shared/text_area.dart';

class ComunidadPerfilWidget extends StatefulWidget {
  final User user;
  const ComunidadPerfilWidget({super.key, required this.user});

  @override
  State<ComunidadPerfilWidget> createState() => _ComunidadPerfilWidgetState();
}

class _ComunidadPerfilWidgetState extends State<ComunidadPerfilWidget> {
  final ComunidadRepository _repo = ComunidadRepository();
  String? fechaFormateada;
  final TextEditingController controller = TextEditingController();

  String? _error;
  bool _cargando = true;

  String grado = '';
  // String _nombreArchivo = '';

  File? _imagen;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
      maxHeight: 800,
      maxWidth: 800,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      // _nombreArchivo = pickedFile.name;
      setState(() => _imagen = File(pickedFile.path));
    }
  }

  @override
  void initState() {
    super.initState();
    _formatearFecha();

    if (widget.user.userRole == 1) {
      _cargarGrado();
    } else {
      _cargando = false;
    }
  }

  Future<void> _cargarGrado() async {
    final response = await _repo
        .obtenerGradoEstudiante({"email": widget.user.email, "rol": 1});

    if (response.mensaje != 'error') {
      setState(() {
        grado = response.grado;
        _cargando = false;
      });
    } else {
      setState(() {
        _error = response.mensaje;
        _cargando = false;
      });
    }
  }

  Future<void> _formatearFecha() async {
    Intl.defaultLocale = 'es_ES';
    if (widget.user.birthday == "") {
      setState(() {
        fechaFormateada = "Fecha de nacimiento no registrada.";
      });
    } else {
      try {
        await initializeDateFormatting('es_ES');
        DateTime fecha = DateTime.parse(widget.user.birthday);
        String formato =
            DateFormat("d 'de' MMMM 'del' y", "es_ES").format(fecha);
        setState(() {
          fechaFormateada = formato;
        });
      } catch (e) {
        setState(() {
          fechaFormateada = "Fecha invalida";
        });
      }
    }
  }

  void _subirPublicacion() async {
    if (controller.text.trim() == '') {
      setState(() {
        _error =
            "Para completar tu publicación, escribe al menos una línea de texto.";
      });
      return;
    } else {
      final validarTexto = CustomFormFieldValidator.texto(controller.text,
          esRequerido: true, nombreCampo: "texto publicación");

      if (validarTexto != null) {
        setState(() {
          _error = validarTexto.replaceAll('\n', ' ');
        });
      } else {
        setState(() {
          _error = null;
        });

        final response = await _repo.subirPublicacion({
          'email': widget.user.email,
          'rol': widget.user.userRole.toString(),
          'texto': controller.text.trim(),
          'ImgPublicacion': _imagen
        });

        if (response.status != 'error') {
          if (!mounted) return;
          controller.clear();
          _imagen = null;
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (_) => ComunidadMisPublicaciones(user: widget.user)),
          );
        } else {
          setState(() {
            _error = response.mensaje;
          });
        }
      }
    }

    setState(() {});
  }

  Widget _loader() {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0B77B3)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_cargando) {
      return _loader();
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 0, 8.w, 10.w),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[600],
                size: 22,
              ),
              onPressed: () {
                   Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) =>
                            ComunidadTodasPublicaciones(user: widget.user)),
                  );
              },
              splashRadius: 20, // Opcional: para ajustar el radio del toque
              tooltip:
                  'Todas las publicaciones', // Opcional: texto al mantener presionado
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            width: 100.w,
            padding: EdgeInsets.symmetric(vertical: 4.w),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color.fromRGBO(100, 96, 92, 0.2),
                  width: 1,
                ),
                bottom: BorderSide(
                  color: Color.fromRGBO(100, 96, 92, 0.2),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Columna izquierda
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Cumpleaños",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          color: const Color.fromRGBO(100, 96, 92, 0.7),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        fechaFormateada ?? '',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 5),

                // Columna derecha
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Conectado desde",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          color: const Color.fromRGBO(100, 96, 92, 0.7),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.user.city,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 100.w,
            padding: EdgeInsets.symmetric(vertical: 4.w),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromRGBO(100, 96, 92, 0.2),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Columna izquierda
                if (widget.user.userRole == 1)
                  Expanded(
                    flex: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Esta en grado",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w300,
                            color: const Color.fromRGBO(100, 96, 92, 0.7),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          grado,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(width: 5),

                // Columna derecha
                Expanded(
                  flex: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Correo en UNICAB",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          color: const Color.fromRGBO(100, 96, 92, 0.7),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.user.email,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 100.w,
            padding: EdgeInsets.symmetric(vertical: 4.w),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromRGBO(100, 96, 92, 0.2),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Lugares que desea conocer",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w300,
                    color: const Color.fromRGBO(100, 96, 92, 0.7),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.user.visitedPlaces,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w300,
                    color: const Color.fromRGBO(100, 96, 92, 0.7),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 100.w,
            padding: EdgeInsets.symmetric(vertical: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "¿Por qué elige a UNICAB?",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Roboto',
                    color: const Color.fromRGBO(100, 96, 92, 0.7),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.user.whyUnicab,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Roboto',
                    color: const Color.fromRGBO(100, 96, 92, 0.7),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Crear una publicación",
            style: TextStyle(
              fontSize: 16.sp,
              fontFamily: 'Roboto',
              color: Color.fromRGBO(14, 14, 14, 1),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          TextArea(
            fontSize: 15.sp,
            fieldHeight: 200,
            controller: controller,
          ),
          const SizedBox(
            height: 26,
          ),
          ImagenPublicacion(imagen: _imagen),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
                width: 100.w,
                color: Colors.blue,
                margin: EdgeInsets.only(top: 41, bottom: 31),
                child: TextButton(
                    onPressed: () {
                      _pickImage(ImageSource.gallery);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/img/pictureIcon.png',
                          width: 4.w,
                          height: 4.h,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Elige una imagen',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ))),
          ),
          const SizedBox(
            height: 10,
          ),
          WarningPublicacion(),
          const SizedBox(
            height: 26,
          ),
          if (_error != null)
            ErrorMensaje(
              mensaje: _error!,
            ),
          const SizedBox(
            height: 26,
          ),
          OrangeButton(
            buttonText: "Enviar",
            onPressed: () {
              _subirPublicacion();
            },
            fontSize: 16.sp,
            textWeight: FontWeight.w600,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.w),
          )
        ],
      ),
    );
  }
}
