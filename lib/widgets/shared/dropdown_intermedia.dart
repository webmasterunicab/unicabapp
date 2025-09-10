
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/models/intermedia_screen/estudiante_modelo.dart';
import 'package:uniconecta/models/intermedia_screen/grado_modelo.dart';

class DropdownIntermedia extends StatelessWidget {
  final List<GradoModelo> grados;
  final List<EstudianteModelo> estudiantes;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final String? valorSeleccionado;
  final Function(String?)? onChanged;

  const DropdownIntermedia(
      {super.key,
      this.grados = const [],
      this.estudiantes = const [],
      required this.hintText,
      required this.validator,
      required this.valorSeleccionado,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      itemHeight: 52,
      
      isDense: false,
      isExpanded: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      value: valorSeleccionado,
      onChanged: onChanged,
      validator: validator,
      hint: Text(
        hintText,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 16.sp,
          fontFamily: 'Roboto',
          color: Colors.white,
        ),
      ),
      items: [
        DropdownMenuItem<String>(
          value: 'NINGUNO',
          child: Text(
            hintText,
            overflow: TextOverflow.visible,
            style: TextStyle(
              fontSize: 16.sp,
              fontFamily: 'Roboto',
              color: Colors.white,
            ),
          ),
        ),
        if (grados.isNotEmpty)
          ...grados.map((item) {
            return DropdownMenuItem<String>(
              value: item.id,
              child: Text(
                item.grado,
                overflow: TextOverflow.visible,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: 'Roboto',
                  color: Colors.white,
                ),
              ),
            );
          }),
        if (estudiantes.isNotEmpty)
          ...estudiantes.map((item) {
            return DropdownMenuItem<String>(
              value: item.correo,
              child: Text(
                "${item.nombre} ${item.correo}",
                overflow: TextOverflow.visible,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: 'Roboto',
                  color: Colors.white,
                ),
              ),
            );
          }),
      ],
      dropdownColor: Colors.orange,
      iconEnabledColor: Colors.white,
      style: TextStyle(
        fontFamily: 'Roboto',
        color: Colors.white,
        fontSize: 18.sp,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.orange,
        errorStyle: TextStyle(
          fontSize: 14.sp,
          fontFamily: 'Roboto',
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }
}
