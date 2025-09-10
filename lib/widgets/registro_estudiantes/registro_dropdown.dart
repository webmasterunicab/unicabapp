import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/models/registro/rol_modelo.dart';

class RegistroDropdown extends StatelessWidget {
  final List<RolModelo> registros;
  final FormFieldValidator<String>? validator;
  final String? valorSeleccionado;
  final Function(String?)? onChanged;
  final FormFieldSetter<String> onSaved;

  const RegistroDropdown({
    super.key,
    required this.registros,
    required this.validator,
    required this.onChanged,
    required this.valorSeleccionado,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Asegura uso de todo el ancho
      child: DropdownButtonFormField<String>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        value: valorSeleccionado,
        onChanged: onChanged,
        validator: validator,
        onSaved: onSaved,
        isExpanded: true, // Muy importante para evitar truncamientos
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.black,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: "Selecciona un rol",
          hintMaxLines: 2,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 13.sp,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.normal,
          ),
          errorStyle: TextStyle(
              fontSize: 14.sp,
              fontFamily: 'Roboto',
              color: Color.fromRGBO(255, 23, 68, 1)),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 2),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromRGBO(255, 23, 68, 1),
                width: 2), // borde en error
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromRGBO(255, 23, 68, 1),
                width: 2), // borde en error con foco
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 20),
        ),
        items: [
          DropdownMenuItem<String>(
            value: 'NA',
            child: Text(
              'Selecciona un rol',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: 'Roboto',
                color: Colors.grey,
              ),
            ),
          ),
          ...registros.map((rol) {
            return DropdownMenuItem<String>(
              value: rol.id,
              child: Text(
                rol.nombreRol,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: 'Roboto',
                  color: Colors.black,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
