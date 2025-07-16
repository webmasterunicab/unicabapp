import 'package:flutter/material.dart';

class RegistroInput extends StatelessWidget {
  final String placeholder;

  const RegistroInput({super.key, required this.placeholder});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Ocupa todo el ancho disponible
      child: TextField(
        decoration: InputDecoration(
          hintText: placeholder,
          hintMaxLines: 2,
          hintStyle:
              TextStyle(color: Colors.grey, fontSize: 10), // Placeholder gris
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
          fontSize: 16,
        ),
        cursorColor: Colors.grey,
      ),
    );
  }
}
