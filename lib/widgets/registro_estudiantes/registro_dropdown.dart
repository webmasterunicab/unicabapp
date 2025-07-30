import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/models/registro/rol_modelo.dart';

class RegistroDropdown extends StatelessWidget {
  final List<RolModelo> registros;
  final FormFieldValidator<String>? validator;
  final String? valorSeleccionado;
  final Function(String?)? onChanged;

  const RegistroDropdown({
    super.key,
    required this.registros,
    required this.validator,
    required this.onChanged,
    required this.valorSeleccionado,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Asegura uso de todo el ancho
      child: DropdownButtonFormField<String>(
        value: valorSeleccionado,
        onChanged: onChanged,
        validator: validator,
        isExpanded: true, // Muy importante para evitar truncamientos
        style: TextStyle(
          fontSize: 18.sp,
          color: Colors.black,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: "Selecciona un rol",
          hintMaxLines: 2,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 18.sp,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w300,
          ),
          errorStyle: TextStyle(
            fontSize: 18.sp,
            fontFamily: 'Roboto',
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 2),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 20),
        ),
        items: registros.map((rol) {
          return DropdownMenuItem<String>(
            value: rol.nombreRol,
            child: Text(
              rol.nombreRol,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: 'Roboto',
                color: Colors.black,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
