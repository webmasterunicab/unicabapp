import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class InicioHead extends StatelessWidget {
  const InicioHead({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(40),
        child: Center(
          child: Image.asset(
            'assets/img/LOGO UNICONECTA.png',
            width: 45.w,
            height: 45.h,
          ),
        ),
      ),
    );
  }
}
