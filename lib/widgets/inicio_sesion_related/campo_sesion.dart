import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CampoSesion extends StatefulWidget {
  final String fieldLabel;
  final String? fieldPlaceholder;
  final TextEditingController? controller;
  final String? Function(String?) validator;
  final String? Function(String?, {required bool esRequerido}) fieldChecking;
  final String? pass;

  const CampoSesion({
    super.key,
    required this.fieldLabel,
    required this.validator,
    required this.fieldChecking,
    this.controller,
    this.fieldPlaceholder,
    this.pass = "NO",
  });

  @override
  State<CampoSesion> createState() => _CampoSesionState();
}

class _CampoSesionState extends State<CampoSesion> {
  final fieldKey = GlobalKey<FormFieldState>();
  late FocusNode focusNode;
  String? errorText;

  // Controla si la contraseña es visible
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UnderlineInputBorder border = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(16.sp),
    );

    final bool esPass = widget.pass == "NO" ? false : true;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // mejora el alineado del label
        children: [
          Row(
            children: [
              Text(
                widget.fieldLabel,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 17.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 9),
          TextFormField(
            key: fieldKey,
            //obscureText: esPass,
            // Aquí controlamos si se oculta o no
            obscureText: esPass ? !_isPasswordVisible : false,
            controller: widget.controller,
            validator: widget.validator,
            focusNode: focusNode,
            onTapOutside: (event) {
              focusNode.unfocus();
            },
            onChanged: (value) {
              String? validatedValue =
                  widget.fieldChecking(value, esRequerido: true);
              setState(() {
                errorText = validatedValue;
              });
            },
            decoration: InputDecoration(
              filled: true,
              enabledBorder: border,
              focusedBorder: border,
              errorBorder: border,
              focusedErrorBorder: border,
              hintText: widget.fieldPlaceholder,
              hintStyle: TextStyle(
                color: Colors.grey,
                fontFamily: 'Roboto',
                fontSize: 15.sp,
              ),
              errorStyle: TextStyle(
                  color: Colors.orangeAccent,
                  fontSize: 14.sp,
                  fontFamily: 'Roboto',
                  overflow: TextOverflow.ellipsis),
              errorText: errorText,
              /*suffixIcon: (errorText != null)
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Image.asset(
                        "assets/img/errorIcon.png",
                        width: 30,
                        height: 30,
                      ),
                    )
                  : null,*/
              // ¡Aquí está el cambio clave! Usamos "suffix" en lugar de "suffixIcon"
              suffix: esPass
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Ícono de error (si existe)
                        if (errorText != null)
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Image.asset(
                              "assets/img/errorIcon.png",
                              width: 30,
                              height: 30,
                            ),
                          ),
                        // Espacio entre íconos si ambos están presentes
                        if (errorText != null) SizedBox(width: 4),
                        // Botón de mostrar/ocultar
                        IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: const Color.fromRGBO(255, 152, 5, 1),
                            size: 24,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          splashRadius: 20,
                          padding: EdgeInsets
                              .zero, // para que no ocupe mucho espacio
                        ),
                      ],
                    )
                  : errorText != null
                      ? Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Image.asset(
                            "assets/img/errorIcon.png",
                            width: 30,
                            height: 30,
                          ),
                        )
                      : null,
              suffixIconConstraints: const BoxConstraints(
                minHeight: 24,
                minWidth: 24,
              ),
            ),
            style: TextStyle(fontFamily: 'Roboto'),
          ),
        ],
      ),
    );
  }
}
