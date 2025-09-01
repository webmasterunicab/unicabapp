import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniconecta/providers/user_provider.dart';
import 'package:uniconecta/screens/calificaciones/calificaciones_intermedia_screen.dart';
import 'package:uniconecta/screens/calificaciones/calificaciones_screen.dart';
import 'package:uniconecta/screens/estado_financiero/estado_financiero_screen.dart';
import 'package:uniconecta/screens/estado_financiero/financiero_intermedia_screen.dart';
import 'package:uniconecta/screens/observador/observador_intermedia_screen.dart';
import 'package:uniconecta/screens/observador/observador_screen.dart';
import 'package:uniconecta/screens/seguimiento_acuerdos/seguimiento_acuerdos_screen.dart';
//import 'package:uniconecta/widgets/general/see_more_container.dart';
import 'package:uniconecta/widgets/shared/navegationBar/main_navegation_bar.dart';
import 'package:uniconecta/widgets/shared/orange_button.dart';

class GeneralScreen extends StatelessWidget {
  final String userEmail;

  const GeneralScreen({super.key, this.userEmail = ''});

  @override
  Widget build(BuildContext context) {
    const double buttonSpacing = 13;

    final UserProvider provider = context.watch<UserProvider>();
    final rol = provider.user!.userRole;
    final email = provider.user!.email;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        children: [
          MainNavegationBar(navType: NavBarTypes.normal),
          SizedBox(height: 20),

          OrangeButton(
              buttonText: "Calificaciones",
              width: 324,
              prefix: Image.asset("assets/img/general_icon2.png", width: 30, height: 30),
              suffix: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
                size: 24,
              ),
              textWeight: FontWeight.normal,
              onPressed: () {
                if (rol == 1) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) =>
                          CalificacionesScreen(rol: rol, email: email)));
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => CalificacionesIntermediaScreen(
                            rol: rol,
                            email: email,
                          )));
                }
              }),
          SizedBox(height: buttonSpacing),

          OrangeButton(
            buttonText: "Observador", 
            width: 324,
            prefix: Image.asset("assets/img/general_icon3.png", width: 30, height: 30),
            suffix: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 24,), 
            textWeight: FontWeight.normal,
            onPressed: () {
              if(rol == 1){
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => ObservadorScreen(email: email)));
              }else {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => ObservadorIntermediaScreen(rol: rol, email: email)));
              }
            }
          ),
          SizedBox(height: buttonSpacing),

          OrangeButton(
              buttonText: "Seguimientos y Acuerdos",
              width: 324,
              prefix: Icon(
                Icons.terminal_rounded,
                color: Colors.white,
                size: 24,
              ),
              suffix: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
                size: 24,
              ),
              textWeight: FontWeight.normal,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => SeguimientoAcuerdosScreen()));
              }),
          SizedBox(height: buttonSpacing),

          OrangeButton(
              buttonText: "Financiera",
              width: 324,
              prefix: Image.asset("assets/img/general_icon1.png", width: 30, height: 30),
              suffix: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
                size: 24,
              ),
              textWeight: FontWeight.normal,
              onPressed: () {
                if(rol == 1){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => EstadoFinanciero(obtainedEmail: email)));
                }else {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => FinancieroIntermediaScreen(rol: rol, email: email)));
                }
              }),
          SizedBox(height: buttonSpacing),

          // OrangeButton(
          //     buttonText: "Comunidad",
          //     width: 324,
          //     prefix: Icon(
          //       Icons.terminal_rounded,
          //       color: Colors.white,
          //       size: 24,
          //     ),
          //     suffix: Icon(
          //       Icons.arrow_forward_ios_rounded,
          //       color: Colors.white,
          //       size: 24,
          //     ),
          //     textWeight: FontWeight.normal,
          //     onPressed: () {
          //       Navigator.of(context).push(
          //           MaterialPageRoute(builder: (_) => ComunidadScreen(user: provider.user!,)));
          //     }),
          //SizedBox(height: buttonSpacing),

          //SeeMoreContainer(),
        ],
      )),
    );
  }
}
