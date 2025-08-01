import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/screens/inicio_sesion/inicio_sesion_screen.dart';
import 'package:uniconecta/widgets/shared/orange_button.dart';

class RegistroConfirmadoScreen extends StatelessWidget {
  const RegistroConfirmadoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: Adaptive.w(100),
            height: 50.h,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Color.fromRGBO(11, 119, 179, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 4.h,
                ),
                Center(
                  child: Image.asset(
                    'assets/img/unicab-1.png',
                    width: 30.w,
                    height: 30.w,
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.transparent, // fondo transparente
                    border: Border.all(
                      color: Colors.white, // color del borde
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(35),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "¡Ya eres miembro de la comunidad!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        "Uniconecta",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.sp,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w200, // ExtraLight
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 12.h),
                  child: OrangeButton(
                    buttonText: '¡Listo, ya eres parte!',
                    fontSize: 18.sp,
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => InicioSesion()),
                        (Route<dynamic> route) =>
                            false, // Esto elimina todas las rutas anteriores
                      );
                    },
                    textWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5.h,),
                Image.asset('assets/img/pictureIcon.png',
                width: 20.w,
                height: 20.w,
                fit: BoxFit.contain,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
