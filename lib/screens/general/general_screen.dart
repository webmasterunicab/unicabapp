import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniconecta/providers/user_provider.dart';
import 'package:uniconecta/screens/calificaciones/calificaciones_intermedia_screen.dart';
import 'package:uniconecta/screens/calificaciones/calificaciones_screen.dart';
import 'package:uniconecta/screens/estado_financiero/estado_financiero_screen.dart';
import 'package:uniconecta/screens/estado_financiero/financiero_intermedia_screen.dart';
import 'package:uniconecta/screens/inicio/inicio_screen.dart';
import 'package:uniconecta/screens/observador/observador_intermedia_screen.dart';
import 'package:uniconecta/screens/observador/observador_screen.dart';
import 'package:uniconecta/widgets/shared/navegationBar/main_navegation_bar.dart';
import 'package:uniconecta/widgets/shared/orange_button.dart';

class GeneralScreen extends StatelessWidget {
  final String userEmail;

  const GeneralScreen({super.key, this.userEmail = ''});

  @override
  Widget build(BuildContext context) {
    const double buttonSpacing = 13;

    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        // if user exists, build normally, if not, move to InicioScreen
        if (provider.user == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const InicioScreen()),
              (Route<dynamic> route) => false,
            );
          });

          // Loading while navegating to InicioScreen
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // If user exists, we take the data
        final rol = provider.user!.userRole;
        final email = provider.user!.email;
        final name = provider.user!.name;

        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              children: [
                MainNavegationBar(navType: NavBarTypes.normal),
                const SizedBox(height: 20),

                // --- Calificaciones Button ---
                OrangeButton(
                  buttonText: "Calificaciones",
                  width: 324,
                  prefix: Image.asset(
                    "assets/img/general_icon2.png",
                    width: 30,
                    height: 30,
                  ),
                  suffix: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                  textWeight: FontWeight.normal,
                  onPressed: () {
                    if (rol == 1) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => CalificacionesScreen(rol: rol, email: email, nombreEstudiante: name,),
                      ));
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => CalificacionesIntermediaScreen(rol: rol, email: email),
                      ));
                    }
                  },
                ),
                const SizedBox(height: buttonSpacing),

                // --- Observador Button ---
                OrangeButton(
                  buttonText: "Observador",
                  width: 324,
                  prefix: Image.asset(
                    "assets/img/general_icon3.png",
                    width: 30,
                    height: 30,
                  ),
                  suffix: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                  textWeight: FontWeight.normal,
                  onPressed: () {
                    if (rol == 1) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => ObservadorScreen(email: email),
                      ));
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => ObservadorIntermediaScreen(rol: rol, email: email),
                      ));
                    }
                  },
                ),
                const SizedBox(height: buttonSpacing),

                // --- Financiera Button ---
                OrangeButton(
                  buttonText: "Financiera",
                  width: 324,
                  prefix: Image.asset(
                    "assets/img/general_icon1.png",
                    width: 30,
                    height: 30,
                  ),
                  suffix: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                  textWeight: FontWeight.normal,
                  onPressed: () {
                    if (rol == 1) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => EstadoFinanciero(obtainedEmail: email, studentName: name),
                      ));
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => FinancieroIntermediaScreen(rol: rol, email: email),
                      ));
                    }
                  },
                ),
                const SizedBox(height: buttonSpacing),
              ],
            ),
          ),
        );
      },
    );
  }
}
