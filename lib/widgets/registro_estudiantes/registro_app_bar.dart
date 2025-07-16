import 'package:flutter/material.dart';

class RegistroAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(100); // Altura personalizada
  
  const RegistroAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        toolbarHeight: 100, // Ajusta la altura del AppBar
        centerTitle: true,
        backgroundColor: Color.fromRGBO(250, 249, 248, 1),
        flexibleSpace: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/LOGO UNICONECTA.png',
                width: 128,
                height: 45,
                color: Color.fromRGBO(11, 119, 179, 1),
              ),
              SizedBox(height: 4),
              Text(
                "Cuéntanos un poco sobre ti.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontFamily: 'Roboto', // Fuente Roboto
                  fontWeight: FontWeight.w300, // Light
                  fontStyle: FontStyle.italic,
                ), // asegúrate de que se vea
              ),
            ],
          ),
        ),
      );
  }
}