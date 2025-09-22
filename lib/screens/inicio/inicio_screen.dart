import 'package:flutter/material.dart';
import 'package:uniconecta/widgets/inicio/inicio_button.dart';
import 'package:uniconecta/widgets/inicio/inicio_head.dart';
import 'package:uniconecta/services/version_service.dart';
import 'package:uniconecta/widgets/shared/orange_button.dart';
import 'package:url_launcher/url_launcher.dart';

/*class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(11, 119, 179, 1),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: Column(
            children: [
              InicioHead(),
              Expanded(
                child: Column(
                  children: [
                    InicioButton(btnNombre: "Inicio de sesión", bottom: false,),
                    InicioButton(btnNombre: "Registro",),
                  ],
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}*/

class InicioScreen extends StatefulWidget {
  const InicioScreen({super.key});

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  bool _requiereActualizar = false;

  @override
  void initState() {
    super.initState();
    _checkVersion();
  }

  Future<void> _checkVersion() async {
    final requiere = await VersionService.hayNuevaVersion();
    if (mounted) {
      setState(() {
        _requiereActualizar = requiere;
      });
    }
  }

  Future<void> _abrirTienda() async {
    Uri url;

    if (Theme.of(context).platform == TargetPlatform.android) {
      //https://play.google.com/store/apps/details?id=com.unicab.uniconecta // Prueba cerrada
      url = Uri.parse(
          "https://play.google.com/store/apps/details?id=com.unicab.uniconecta"); // cambia com.tuapp
    } /*else if (Theme.of(context).platform == TargetPlatform.iOS) {
      url = Uri.parse("https://apps.apple.com/app/idXXXXXXXXX"); // cambia idXXXXXXXXX
    }*/
    else {
      return;
    }

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(11, 119, 179, 1),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: Column(
            children: [
              const InicioHead(),
              Expanded(
                child: _requiereActualizar
                    ? Center(
                        /*child: ElevatedButton(
                          onPressed: () {
                            // Abrir la tienda aquí
                          },
                          child: const Text("Actualizar ahora"),
                        ),*/
                        child: OrangeButton(
                        onPressed: _abrirTienda,
                        buttonText: "Actualizar ahora",
                        textWeight: FontWeight.w600,
                        fontSize: 17,
                      ))
                    : Column(
                        children: const [
                          InicioButton(
                            btnNombre: "Inicio de sesión",
                            bottom: false,
                          ),
                          InicioButton(
                            btnNombre: "Registro",
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
