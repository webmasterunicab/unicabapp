import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniconecta/main.dart';
import 'package:uniconecta/providers/user_provider.dart';
import 'package:uniconecta/repositories/usuario_service.dart';
import 'package:uniconecta/screens/ajustar_perfil/ajustar_perfil_screen.dart';
import 'package:uniconecta/screens/foto/subir_foto_screen.dart';
import 'package:uniconecta/screens/video_inicio/splash_inicio_screen.dart';
import 'package:uniconecta/widgets/shared/navegationBar/dropdown_item_nav.dart';
import 'package:uniconecta/widgets/shared/navegationBar/dropdown_nav.dart';
import 'package:url_launcher/url_launcher.dart';

class NavBarAvatar extends StatefulWidget {
  final Widget userAvatar;

  const NavBarAvatar({super.key, required this.userAvatar});

  @override
  State<NavBarAvatar> createState() => _DropdownManager();
}

class _DropdownManager extends State<NavBarAvatar> with RouteAware {
  GlobalKey action = LabeledGlobalKey("MainDropdown");
  bool isOpened = false;

  // dropdown related variables
  double? width;
  double? xPosition;
  double? yPosition;
  OverlayEntry? dropdown;

  double xOffset = 100;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPushNext() {
    _closeDropdown();
  }

  void _getDropdownVariables() {
    RenderBox? box = action.currentContext?.findRenderObject() as RenderBox?;

    if (box != null) {
      yPosition = box.size.height + box.localToGlobal(Offset.zero).dy + 15;
      xPosition = box.localToGlobal(Offset.zero).dx;
      width = box.size.width;
    }
  }

  Future<bool> showDeleteAccountAlert(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false, // evita cerrar tocando fuera
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Confirmación',
              style: TextStyle(
                  color: Colors.orange,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600)),
          content: const Text('¿Está seguro de que quiere eliminar su cuenta?',
              style: TextStyle(fontFamily: 'Roboto')),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all(Colors.blue),
              ),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  overlayColor: Colors.orange,
                  backgroundColor: Colors.orange),
              child: const Text('Eliminar',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto',
                  )),
            ),
          ],
        );
      },
    );
    return result ?? false;
  }

  Future<void> _launchUrl(BuildContext context) async {
    final Uri url = Uri.parse('https://aulavirtual.unicab.org/login/');

    final ok = await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );

    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error al intentar abrir el navegador"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  OverlayEntry _buildDropdown(BuildContext context) {
    return OverlayEntry(builder: (_) {
      return Positioned(
        top: yPosition,
        left: xPosition! - xOffset,
        child: DropdownNav(boxSize: (width! + xOffset), items: [
          DropdownItemNav(
              name: "Ajustar Perfil",
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => AjustarPerfilScreen()));
              }),
          DropdownItemNav(
              name: "Cambiar foto de Perfil",
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => SubirFotoScreen()));
              }),
          DropdownItemNav(
              name: "Ir al aula virtual",
              onPressed: () {
                _launchUrl(context);
              }),
          //DropdownItemNav(name: "Manual de convivencia", onPressed: () {}),
          DropdownItemNav(name: "Cambiar Contraseña", onPressed: () {}),
          DropdownItemNav(name: "Cerrar sesión", onPressed: () {}),
          //DropdownItemNav(name: "Preguntas Frecuentes", onPressed: () {}),
          //DropdownItemNav(name: "Política y privacidad", onPressed: () {}),
          //DropdownItemNav(name: "Terminos y condiciones", onPressed: () {}),
          DropdownItemNav(
            name: "Eliminar cuenta",
            onPressed: () async {
              final confirmed = await showDeleteAccountAlert(context);

              if (!confirmed) return;

              if (!context.mounted) return;
              final UsuarioService service = UsuarioService();
              final UserProvider provider =
                  Provider.of<UserProvider>(context, listen: false);

              final response = await service.eliminarCuenta({
                "email": provider.user!.email,
                "rol": provider.user!.userRole.toString()
              });

              if (!context.mounted) return;
              if (response.status != 'error') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const SplashInicioScreen()),
                );
              }
            },
          ),
        ]),
      );
    });
  }

  void _closeDropdown() {
    if (isOpened && dropdown != null) {
      dropdown!.remove();
      dropdown = null;
      isOpened = false;
    }
  }

  @override
  void dispose() {
    _closeDropdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: TextButton(
            key: action,
            onPressed: () {
              setState(() {
                if (isOpened && dropdown != null) {
                  dropdown!.remove();
                } else {
                  _getDropdownVariables();
                  dropdown = _buildDropdown(context);
                  Overlay.of(context).insert(dropdown!);
                }

                isOpened = !isOpened;
              });
            },
            style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
            child: CircleAvatar(
              radius: 35,
              backgroundColor: Colors.white,
              child: ClipOval(child: widget.userAvatar),
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: -5,
          child: Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white),
            child: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Color.fromRGBO(145, 145, 145, 1),
              size: 25,
            ),
          ),
        ),
      ],
    );
  }
}
