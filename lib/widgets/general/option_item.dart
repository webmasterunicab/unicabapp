import 'package:flutter/material.dart';
import '../../models/general/options.dart';
import '../../config/app_routes.dart';

class OptionItem extends StatelessWidget {
  final Options option;

  const OptionItem({
    super.key,
    required this.option,
  });

  void _navigateToScreen(BuildContext context) {
    try {
      final screenPath = option.direccion;

      // Verificar si la ruta está registrada
      if (AppRoutes.isRouteRegistered(screenPath)) {
        // Navegar usando el sistema de rutas centralizado
        AppRoutes.navigateToRoute(context, screenPath);
      } else {
        // La ruta no está registrada aún
        _showNotImplemented(context, option.nombre);
      }
    } catch (e) {
      _showError(context, 'Error al navegar a ${option.nombre}');
    }
  }

  void _showNotImplemented(BuildContext context, String screenName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$screenName - Próximamente disponible'),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _navigateToScreen(context),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 60),
        decoration: BoxDecoration(
          color: const Color(0xFFFF9805), // Color naranja de fondo
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Imagen sin fondo
            Image.asset(
              option.imagen,
              width: 30,
              height: 30,
              color: Colors.white, // Aplica tinte blanco a la imagen
              errorBuilder: (context, error, stackTrace) {
                // Fallback genérico si la imagen no carga
                return const Icon(
                  Icons.apps,
                  color: Colors.white,
                  size: 30,
                );
              },
            ),

            // Nombre de la opción centrado
            Expanded(
              child: Center(
                child: Text(
                  option.nombre,
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Flecha sin fondo
            const Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
