import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/models/registro/subida_imagen_response.dart';
import 'package:uniconecta/repositories/registro_service.dart';
import 'package:uniconecta/screens/registro_confirmado/registro_confirmado_screen.dart';
import 'package:uniconecta/widgets/registro_estudiantes/registro_input.dart';
import 'package:uniconecta/widgets/registro_estudiantes/registro_label.dart';
import 'package:uniconecta/widgets/shared/orange_button.dart';

class SubirFotoBody extends StatefulWidget {
  final Map<String, dynamic> datosRegistro;

  const SubirFotoBody({super.key, required this.datosRegistro});

  @override
  State<SubirFotoBody> createState() => _SubirFotoBodyState();
}

class _SubirFotoBodyState extends State<SubirFotoBody> {
  final Color colorBotones = Color.fromRGBO(11, 119, 179, 1);
  final _service = RegistroService();
  bool terminosAceptados = false;
  String _nombreArchivo = '';

  SubidaImagenResponse response =
      SubidaImagenResponse(status: '', mensaje: '', url: '');

  File? _imagen;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
      maxHeight: 800,
      maxWidth: 800,
      imageQuality: 85, // comprimir un poco la imagen
    );

    if (pickedFile != null) {
      _nombreArchivo = pickedFile.name;
      setState(() => _imagen = File(pickedFile.path));
    }
  }

  void _submit() async {
    if (!terminosAceptados) return;

    widget.datosRegistro['aceptoTerminos'] = 1;


    final respuestaSubida = await _service.subirImagen(_imagen);


    setState(() {
      response = respuestaSubida;
      if (response.status == 'success') {
        widget.datosRegistro['fotoPerfil'] = response.url;
      }
    });


    if (response.status != 'success') return;

    // Subes los datos del registro
    await _service.subirDatosRegistro(widget.datosRegistro);

    // Navegas a la siguiente pantalla
    if (!mounted) return; // buena práctica para evitar errores al navegar
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => RegistroConfirmadoScreen()),
    );
  }

  Widget _mostrarError() {
    if (response.status == 'error') {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 22.sp, horizontal: 33.sp),
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
          color: Colors.redAccent.shade100,
          borderRadius: BorderRadius.circular(8.sp),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.warning_rounded,
                color: Colors.redAccent.shade700, size: 20.sp),
            SizedBox(height: 10.sp),
            Text(
              response.mensaje,
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.redAccent.shade700,
                fontFamily: 'Roboto',
              ),
            ),
          ],
        ),
      );
    } else {
      return SizedBox.shrink(); // o Container() si prefieres
    }
  }

  Widget _mostrarImagenSeleccionada() {
    double size =
        35.w; // Tamaño dinámico del contenedor (ej: 35% del ancho de pantalla)

    if (_imagen == null) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          shape: BoxShape.circle,
          border: Border.all(color: colorBotones, width: 1.5.w),
        ),
        child: Icon(Icons.person, size: 15.w, color: colorBotones),
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: colorBotones, width: 1.5.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 2.w,
            offset: Offset(1.w, 1.w),
          ),
        ],
        image: DecorationImage(
          image: FileImage(_imagen!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _mostrarImagenSeleccionada(),
          Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.symmetric(vertical: 46, horizontal: 25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RegistroLabel(label: 'Sube tu foto de perfil'),
                        RegistroInput(
                          placeholder: _nombreArchivo == ''
                              ? 'Ponle rostro a tu cuenta. ¡Queremos verte!'
                              : _nombreArchivo,
                          readOnly: true,
                          validator: (String? value) {
                            return null;
                          },
                          onSaved: (String? newValue) {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8), // Espacio entre la columna y la flecha
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.arrow_forward_ios,
                  //     color: Colors.grey[600],
                  //     size: 22,
                  //   ),
                  //   onPressed: () {
                  //   },
                  //   splashRadius:
                  //       20, // Opcional: para ajustar el radio del toque
                  //   tooltip:
                  //       'Siguiente', // Opcional: texto al mantener presionado
                  // ),
                ],
              )),
          Align(
            alignment: Alignment.center,
            child: Container(
                width: 55.w,
                color: colorBotones,
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
                          'Elige una foto',
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
          Align(
            alignment: Alignment.center,
            child: Container(
                width: 55.w,
                color: colorBotones,
                margin: EdgeInsets.only(top: 20, bottom: 31),
                child: TextButton(
                    onPressed: () {
                      _pickImage(ImageSource.camera);
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
                          'Tomar foto',
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
          _mostrarError(),
          Container(
              margin: EdgeInsets.only(top: 22),
              child: OrangeButton(
                onPressed: () {
                  _submit();
                },
                buttonText: 'Subir',
                textWeight: FontWeight.w600,
                width: 140,
                fontSize: 16.sp,
              )),
          Container(
            margin: EdgeInsets.symmetric(vertical: 40),
            child: Align(
              alignment: Alignment.center,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 300),
                child: CheckboxListTile(
                  value: terminosAceptados,
                  onChanged: (bool? value) {
                    setState(() {
                      terminosAceptados = value ?? false;
                    });
                  },
                  title: Text(
                    "Acepto los términos y la política de tratamiento de datos de UNICAB. Tus datos están seguros con nosotros. Solo los usaremos para mejorar tu experiencia en UNICAB.",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: Colors.black,
                    ),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 55),
            child: TextButton(
                onPressed: () {
                  // Acción al presionar
                },
                child: Text(
                  'Términos y privacidad (Enlace a políticas de datos)',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: Colors.black,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
