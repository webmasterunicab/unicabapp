import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/providers/user_provider.dart';
import 'package:uniconecta/repositories/usuario_service.dart';
import 'package:uniconecta/screens/general/general_screen.dart';
import 'package:uniconecta/widgets/registro_estudiantes/registro_input.dart';
import 'package:uniconecta/widgets/registro_estudiantes/registro_label.dart';
import 'package:uniconecta/widgets/shared/error_mensaje.dart';
import 'package:uniconecta/widgets/shared/orange_button.dart';

class SubirFotoBody extends StatefulWidget {
  const SubirFotoBody({super.key});

  @override
  State<SubirFotoBody> createState() => _SubirFotoBodyState();
}

class _SubirFotoBodyState extends State<SubirFotoBody> {
  final Color colorBotones = Color.fromRGBO(11, 119, 179, 1);
  final _service = UsuarioService();
  final ImagePicker _picker = ImagePicker();

  File? _selectedImage;
  String? _originalFileName; // Para mantener el nombre original
  bool _loading = false;
  bool _isPickerActive = false;
  String? _error;

  // Función para seleccionar imagen desde cualquier carpeta
  Future<void> _filePicker() async {
    if (_isPickerActive) return; // Evita múltiples llamadas
    setState(() {
      _isPickerActive = true;
    });

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
      );

      if (result != null) {
        setState(() {
          _selectedImage = File(result.files.single.path!);
          _originalFileName = result.files.single.name;
        });
      }
    } catch (e) {
      // print('Error en file_picker: $e');
    } finally {
      setState(() {
        _isPickerActive = false;
      });
    }
  }

  Future<void> _imagePicker(ImageSource source) async {
    if (_isPickerActive) return; // Evita múltiples llamadas
    setState(() {
      _isPickerActive = true;
    });
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        maxHeight: 800,
        maxWidth: 800,
        imageQuality: 85, // comprimir un poco la imagen
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
          _originalFileName = pickedFile.name;
        });
      }
    } catch (e) {
      // print('Error en image_picker: $e');
    } finally {
      setState(() {
        _isPickerActive = false;
      });
    }
  }

  void _submit() async {
    if (_loading) return;

    setState(() {
      _loading = true;
    });

    try {
      final provider = context.read<UserProvider>();

      final respuestaSubida = await _service.actualizarFotoPerfil({
        "email": provider.user!.email,
        "rol": provider.user!.userRole.toString(),
        "ImagenA": _selectedImage,
        "originalFileName": _originalFileName
      });

      if (respuestaSubida.status != 'error') {
        provider.updateUser(profilePicture: respuestaSubida.url);
        if (!mounted) return;
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => GeneralScreen()),
        );
      } else {
        _error = respuestaSubida.mensaje;
      }
    } catch (e) {
      setState(() {
        _error = '¡Ha ocurrido un error inesperado, inténtalo más tarde!';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Widget mostrarError() {
    if (_error != null) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 22.sp, horizontal: 33.sp),
        padding: EdgeInsets.all(12.sp),
        child: ErrorMensaje(
          mensaje: _error!,
        ),
      );
    } else {
      return SizedBox.shrink(); // o Container() si prefieres
    }
  }

  Widget _mostrarImagenSeleccionada() {
    double size = 35.w;
    final provider = context.read<UserProvider>();

    if (provider.user!.profilePicture != '' && _selectedImage == null) {
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
            image: NetworkImage(provider.user!.profilePicture),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    if (_selectedImage != null) {
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
            image: FileImage(_selectedImage!),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

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
                          placeholder:
                              'Ponle rostro a tu cuenta. ¡Queremos verte!',
                          readOnly: true,
                          validator: (String? value) {
                            return null;
                          },
                          onSaved: (String? newValue) {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8)
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
                      _filePicker();
                    },
                    child: _isPickerActive
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Row(
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
                      _imagePicker(ImageSource.camera);
                    },
                    child: _isPickerActive
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Row(
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
          mostrarError(),
          Container(
              margin: EdgeInsets.only(top: 22),
              child: _loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.blue,
                      ),
                    )
                  : OrangeButton(
                      onPressed: () {
                        _submit();
                      },
                      buttonText: 'Subir',
                      textWeight: FontWeight.w600,
                      width: 140,
                      fontSize: 16.sp,
                    )),
          // Container(
          //   margin: EdgeInsets.only(top: 55),
          //   child: TextButton(
          //       onPressed: () {
          //         // Acción al presionar
          //       },
          //       child: Text(
          //         'Términos y privacidad (Enlace a políticas de datos)',
          //         style: TextStyle(
          //           fontFamily: 'Roboto',
          //           fontWeight: FontWeight.w400,
          //           fontSize: 12.sp,
          //           color: Colors.black,
          //         ),
          //       )),
          // ),
        ],
      ),
    );
  }
}
