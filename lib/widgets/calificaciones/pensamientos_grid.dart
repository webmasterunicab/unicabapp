import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/screens/calificaciones/calificaciones_especificas_screen.dart';

class PensamientosGrid extends StatelessWidget {
  const PensamientosGrid({super.key});

  final String gif = 'assets/img/cerebro.gif';

  final List<Map<String, String>> elementos = const [
    {'img': 'assets/img/matematicas.png', 'text': 'Pensamiento Matemático'},
    {'img': 'assets/img/bioetico.png', 'text': 'Pensamiento Bioético'},
    {
      'img': 'assets/img/español.png',
      'text': 'Pensamiento Humanístico Español'
    },
    {'img': 'assets/img/ingles.png', 'text': 'Pensamiento Humanístico Inglés'},
    {'img': 'assets/img/social.png', 'text': 'Pensamiento Social'},
    {'img': 'assets/img/tecnologico.png', 'text': 'Pensamiento Tecnológico'},
  ];

  Widget _buildButton(Map<String, String> data, GestureTapCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            data['img']!,
            width: 35.w,
            height: 35.w,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                gif,
                fit: BoxFit.contain,
                height: 10.w,
                width: 10.w,
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 30.w,
                child: Text(
                  data['text']!,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              _buildButton(elementos[0], () { 
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => CalificacionesEspecificasScreen()));
              }),
              SizedBox(width: 8.w),
              _buildButton(elementos[1], () {}),
            ],
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              _buildButton(elementos[2], () {}),
              SizedBox(width: 8.w),
              _buildButton(elementos[3], () {}),
            ],
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              _buildButton(elementos[4], () {}),
              SizedBox(width: 8.w),
              _buildButton(elementos[5], () {}),
            ],
          ),
        ],
      ),
    );
  }
}
