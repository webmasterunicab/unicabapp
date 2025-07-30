import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RegistroInput extends StatelessWidget {
  final String placeholder;
  final bool readOnly;

  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String>? validator;

  const RegistroInput({super.key, required this.placeholder, this.readOnly = false, required this.validator, required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Ocupa todo el ancho disponible
      child: TextFormField(
        validator: validator,
        onSaved: onSaved,
        minLines: 1,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        readOnly: readOnly,
        decoration: InputDecoration(
          errorStyle: TextStyle(
          fontSize: 18.sp,
          ),
          hintText: placeholder,
          hintMaxLines: 2,
          hintStyle:
              TextStyle(color: Colors.grey, fontSize: 18.sp), // Placeholder gris
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey), // Borde inferior gris
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 2),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          filled: false,
          contentPadding: EdgeInsets.symmetric(vertical: 12),
        ),
        style: TextStyle(
          color: Colors.black, // Texto en negro
          fontSize: 18.sp,
        ),
        cursorColor: Colors.grey,
      ),
    );
  }
}
