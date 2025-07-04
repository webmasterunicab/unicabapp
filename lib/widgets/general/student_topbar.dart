import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/general/menu.dart';
import '../../repositories/general/menu_repository.dart';
import '../../providers/student_provider.dart';

class StudentTopBar extends StatelessWidget {
  final GlobalKey _topBarKey = GlobalKey();

  StudentTopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final topBarHeight = screenHeight * 0.15; // 15% de la pantalla
    final screenWidth = MediaQuery.of(context).size.width;
    final topBarWidth = screenWidth * 1; // 100% de la pantalla

    return Consumer<StudentProvider>(
      builder: (context, provider, child) {
        final estudiante = provider.currentStudent;

        return Container(
          key: _topBarKey,
          width: topBarWidth,
          height: topBarHeight +
              MediaQuery.of(context).padding.top, // Incluir el status bar
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top +
                10, // Padding del status bar + padding original
            left: 20,
            right: 20,
            bottom: 30,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF0B77B3),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(45),
              topLeft: Radius.circular(45),
              topRight: Radius.circular(45),
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0B77B3),
                blurRadius: 0,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Row(
            children: [
              // Flecha de regreso y Logo UNICONECTA
              const SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Flecha de regreso
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Logo UNICONECTA
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Logo UNICONECTA'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/img/LOGO UNICONECTA.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
                ],
              ),

              // Información del estudiante
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      estudiante?.nombre ?? provider.studentName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
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
                                content:
                                    Text('Funcionalidad de chat en desarrollo'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                        ),
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
                                content: Text(
                                    'Funcionalidad de notificaciones en desarrollo'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 24),

              // Foto del estudiante con dropdown posicionado justo bajo el topbar
              GestureDetector(
                onTap: () async {
                  final renderBox = _topBarKey.currentContext!
                      .findRenderObject() as RenderBox;
                  final topBarOffset = renderBox.localToGlobal(Offset.zero);
                  final topBarSize = renderBox.size;

                  const buttonWidth = 80.0;
                  const rightMargin = 32.0;

                  // Menú alineado al botón con margen de 24px a la derecha
                  final left = screenWidth - rightMargin - buttonWidth;

                  final position = RelativeRect.fromLTRB(
                    left,
                    topBarOffset.dy + topBarSize.height,
                    rightMargin,
                    0,
                  );

                  // Cargar menús dinámicamente
                  final menuRepository = MenuRepository();
                  await menuRepository.initializeWithSampleData();
                  final menus = await menuRepository.getProfileMenus();

                  if (context.mounted) {
                    showMenu<String>(
                      context: context,
                      position: position,
                      color: const Color(
                          0xFFF4F2F0), // Color de fondo del dropdown
                      elevation: 10,
                      items: [
                        // Espaciador superior
                        const PopupMenuItem<String>(
                          enabled: false,
                          height: 8,
                          child: SizedBox.shrink(),
                        ),
                        // Items del menú
                        ...menus.map((Menu menu) {
                          return PopupMenuItem<String>(
                            value: menu.enlace,
                            height:
                                40, // Reduce la altura de cada item (por defecto es ~48)
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4), // Reduce padding vertical
                            child: Text(
                              menu.titulo,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                              ),
                            ),
                          );
                        }).toList(),
                        // Espaciador inferior
                        const PopupMenuItem<String>(
                          enabled: false,
                          height: 8,
                          child: SizedBox.shrink(),
                        ),
                      ],
                    ).then((value) {
                      if (value != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Navegando a: $value'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    });
                  }
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 0,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: estudiante?.foto != null &&
                                estudiante!.foto.isNotEmpty
                            ? Image.asset(
                                estudiante.foto,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return _buildDefaultAvatar();
                                },
                              )
                            : _buildDefaultAvatar(),
                      ),
                    ),
                    // Flecha pequeña en esquina inferior derecha
                    const Positioned(
                      bottom: -4,
                      right: -4,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Color.fromARGB(255, 255, 255, 255),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Color.fromARGB(255, 0, 0, 0),
                          size: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Colors.grey[300]!, Colors.grey[400]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Icon(
        Icons.person,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
