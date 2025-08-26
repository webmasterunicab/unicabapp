import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/models/comunidad/publicacion.dart';
import 'package:uniconecta/models/shared/user.dart';
import 'package:uniconecta/repositories/comunidad_repository.dart';
import 'package:uniconecta/widgets/comunidad/comunidad_megusta_boton.dart';

class ComunidadPostCard extends StatefulWidget {
  final Publicacion publicacion;
  final ComunidadRepository repo;
  final User user;

  const ComunidadPostCard({
    super.key,
    required this.publicacion,
    required this.repo,
    required this.user,
  });

  @override
  State<ComunidadPostCard> createState() => _ComunidadPostCardState();
}

class _ComunidadPostCardState extends State<ComunidadPostCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.w, horizontal: 5.w),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Cabecera ---
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    widget.publicacion.fotoPerfil == ""
                      ? 'https://unicab.org/uniconecta/assets/fotos_perfil/user1.png'
                      : widget.publicacion.fotoPerfil),
                  radius: 22,
                ),
                const SizedBox(width: 10),
                Text(
                  widget.publicacion.nombre,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // --- Texto principal ---
            Text(
              widget.publicacion.texto,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            // --- Imagen de la publicación (si existe) ---
            if (widget.publicacion.imagen.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.publicacion.imagen,
                  fit: BoxFit.contain,
                  width: 100.w,
                  height: 200,
                ),
              ),
            if (widget.publicacion.imagen.isNotEmpty)
              const SizedBox(height: 10),

            // --- Acciones ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComunidadMegustaBoton(
                      dioMeGusta:
                          widget.publicacion.dioLike == 'NO' ? false : true,
                      likeCount: widget.publicacion.megusta,
                      onLikeToggle: (isLiked) async {
                        try {
                          final response =
                              await widget.repo.darLikePublicacion({
                            "email": widget.user.email,
                            "rol": widget.user.userRole,
                            "id_publicacion": widget.publicacion.id
                          });

                          if (response.status != 'error') {
                            return true;
                          } else {
                            return false;
                          }
                        } catch (e) {
                          return false;
                        }
                      },
                    ),
                    SizedBox(width: 10.w),
                    IconButton(
                      icon: Icon(Icons.mode_comment_outlined, size: 8.w),
                      onPressed: () {
                        // Acción de comentarios
                        debugPrint("Comentarios presionado");
                      },
                    ),
                  ],
                ),
              ],
            ),

            // --- FIN CARD ---
          ],
        ),
      ),
    );
  }
}
