import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/main.dart';
import 'package:uniconecta/providers/user_provider.dart';
import 'package:uniconecta/screens/inicio/inicio_screen.dart';
import 'package:uniconecta/screens/password_related/cambiar_pass_screen.dart';
import 'package:uniconecta/widgets/shared/navegationBar/dropdown_item_nav.dart';
import 'package:uniconecta/widgets/shared/navegationBar/dropdown_nav.dart';

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

  OverlayEntry _buildDropdown(BuildContext context) {
    return OverlayEntry(builder: (_) {
      return Positioned(
        top: yPosition,
        left: xPosition! - xOffset,
        child: DropdownNav(
          boxSize: (width! + xOffset), 
          items: [
            DropdownItemNav(name: "Ajustar Perfil", onPressed: () {}),
            DropdownItemNav(name: "Ir al aula virtual", onPressed: () {}),
            //DropdownItemNav(name: "Manual de convivencia", onPressed: () {}),
            
            DropdownItemNav(name: "Cambiar Contraseña", onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => CambiarPassScreen()));
            }),


            DropdownItemNav(name: "Cerrar sesión", onPressed: () {
              UserProvider provider = Provider.of<UserProvider>(context, listen: false);
              provider.setUser(null);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: const Color.fromRGBO(11, 119, 179, 1), 
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center, 
                    children: [
                      Icon(Icons.check_circle_rounded, color: Colors.white),
                      SizedBox(width: 4),

                      Text("Sesión cerrada con éxito.", style: TextStyle(fontFamily: "Roboto", fontSize: 15.sp, color: Colors.white))
                    ]
                  )
                ),
              );
            }),
            //DropdownItemNav(name: "Preguntas Frecuentes", onPressed: () {}),
            //DropdownItemNav(name: "Política y privacidad", onPressed: () {}),
            //DropdownItemNav(name: "Terminos y condiciones", onPressed: () {}),
            DropdownItemNav(name: "Eliminar cuenta", onPressed: () {}),
          ]
        ),
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
              child: ClipOval(
                child: widget.userAvatar
              ),
            ),
          ),
        ),

        Positioned(
          right: 0, bottom: -5,

          child: Container(
            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),

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