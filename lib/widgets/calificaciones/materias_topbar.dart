import 'package:flutter/material.dart';

class MateriasTopBar extends StatelessWidget {
  const MateriasTopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 16, right: 16, bottom: 16),
      decoration: const BoxDecoration(
        color: Color(0xFF0B77B3),
        borderRadius: BorderRadius.only(
          //bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(45),
          topLeft: Radius.circular(45),
          topRight: Radius.circular(45),
        ),
      ),
      child: Row(
        children: [
          // Botones de navegación (atrás y adelante)
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {
                  // Funcionalidad para ir adelante
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Navegación adelante en desarrollo'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),

          // Espacio para empujar los iconos a la derecha
          const Spacer(),

          // Iconos de mensajes y notificaciones
          Row(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                icon: Image.asset(
                  'assets/img/mensajes.png',
                  width: 20,
                  height: 20,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Funcionalidad de chat en desarrollo'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              const SizedBox(width: 0),
              IconButton(
                padding: EdgeInsets.zero,
                icon: Image.asset(
                  'assets/img/notificaciones.png',
                  width: 20,
                  height: 20,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Funcionalidad de notificaciones en desarrollo'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
