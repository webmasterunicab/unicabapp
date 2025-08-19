import 'package:flutter/material.dart';
import 'package:uniconecta/models/shared/user.dart';
import 'package:uniconecta/widgets/comunidad/perfil_personal_widget.dart';
import 'package:uniconecta/widgets/shared/navegationBar/main_navegation_bar.dart';

class ComunidadScreen extends StatelessWidget {
  final User user;
  const ComunidadScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            MainNavegationBar(navType: NavBarTypes.normal),
            SizedBox(height: 5),
            SafeArea(
              child: PerfilPersonalWidget(user: user,)
          ),
          ],
        ),
      ),
    );
  }
}
