import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/screens/inicio_sesion/inicio_sesion_screen.dart';
import 'package:uniconecta/widgets/shared/orange_button.dart';

class RecuperarContrasenaExitoScreen extends StatelessWidget {
  const RecuperarContrasenaExitoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(11, 119, 179, 1),
      body: _ScreenBody(),
    );
  }
}

class _ScreenBody extends StatelessWidget {
  const _ScreenBody();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 51),
            child: Image.asset(
              'assets/img/LOGO UNICONECTA.png',
              width: 154,
              height: 54,
            ),
          ),
          SizedBox(height: 75),
      
          Text("Correo enviado con exito.", style: TextStyle(fontFamily: 'Roboto', fontSize: 17.sp, color: Colors.white, fontWeight: FontWeight.w700)),
          Text("¡No lo compartas con nadie!", style: TextStyle(fontFamily: 'Roboto', fontSize: 16.sp, color: const Color.fromRGBO(221, 221, 221, 1), fontWeight: FontWeight.w500)),
          SizedBox(height: 75),
      
          OrangeButton(buttonText: "¡Listo, sigamos!", textWeight: FontWeight.w600, onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => InicioSesion()), (Route<dynamic> route) => false);
          }),
        ],
      ),
    );
  }
}

