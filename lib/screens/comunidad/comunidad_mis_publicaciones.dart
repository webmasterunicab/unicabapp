import 'package:flutter/material.dart';
import 'package:uniconecta/models/shared/user.dart';
import 'package:uniconecta/util/enums/comunidad/tipo_publicaciones.dart';
import 'package:uniconecta/widgets/comunidad/comunidad_publicaciones.dart';
import 'package:uniconecta/widgets/shared/navegationBar/main_navegation_bar.dart';

class ComunidadMisPublicaciones extends StatelessWidget {
  final User user;
  const ComunidadMisPublicaciones({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            MainNavegationBar(navType: NavBarTypes.navegating),
            SafeArea(
                child: ComunidadPublicaciones(
              user: user,
              tipo: TipoPublicaciones.personales,
            )),
          ],
        ),
      ),
    );
  }
}
