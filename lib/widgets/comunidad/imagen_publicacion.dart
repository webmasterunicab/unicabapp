import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ImagenPublicacion extends StatelessWidget {
  final File? imagen;

  const ImagenPublicacion({super.key, this.imagen});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Título
        Text(
          "Imagen de la publicación",
          style: TextStyle(
            fontSize: 16.sp,
            fontFamily: 'Roboto',
            color: Color.fromRGBO(14, 14, 14, 1),
          ),
        ),
        const SizedBox(height: 16),

        // Contenedor rectangular
        Container(
          height: 200,
          width: 100.w,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: imagen != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    imagen!,
                    fit: BoxFit.contain,
                    width: double.infinity,
                  ),
                )
              : Center(
                  child: Icon(
                    Icons.image_outlined,
                    color: Colors.grey[600],
                    size: 50,
                  ),
                ),
        ),
      ],
    );
  }
}
