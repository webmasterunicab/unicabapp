import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RegistroAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(100); // Altura personalizada

  final bool mostrarTexto;
  final Color color;
  const RegistroAppBar(
      {super.key,
      required this.mostrarTexto,
      this.color = const Color.fromRGBO(250, 249, 248, 1)});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 200, // Ajusta la altura del AppBar
      centerTitle: true,
      backgroundColor: color,
      flexibleSpace: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/LOGO UNICONECTA.png',
              width: 128,
              height: 45,
              // width: 5.w,
              // height: 5.h,
              color: Color.fromRGBO(11, 119, 179, 1),
              fit: BoxFit.contain,
            ),
            SizedBox(height: 4),
            Visibility(
              visible: mostrarTexto,
              maintainSize: false,
              child: Text(
                "Cuéntanos un poco sobre ti.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.sp,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
