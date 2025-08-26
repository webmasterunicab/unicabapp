import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/models/comunidad/publicacion.dart';
import 'package:uniconecta/models/shared/user.dart';
import 'package:uniconecta/repositories/comunidad_repository.dart';
import 'package:uniconecta/util/enums/comunidad/tipo_publicaciones.dart';
import 'package:uniconecta/widgets/comunidad/comunidad_post_card.dart';
import 'package:uniconecta/widgets/shared/error_mensaje.dart';
import 'package:uniconecta/widgets/shared/navegationBar/main_navegation_bar.dart';
import 'package:uniconecta/widgets/shared/screen_name_display.dart';

class ComunidadPublicaciones extends StatefulWidget {
  final User user;
  final TipoPublicaciones tipo;

  const ComunidadPublicaciones(
      {super.key, required this.user, required this.tipo});

  @override
  State<ComunidadPublicaciones> createState() => _ComunidadPublicacionesState();
}

class _ComunidadPublicacionesState extends State<ComunidadPublicaciones> {
  List<Publicacion> _publicaciones = [];
  final ComunidadRepository _repo = ComunidadRepository();
  String? _error;
  String display = '';
  bool _cargando = true;

  @override
  void initState() {
    super.initState();

    if (widget.tipo == TipoPublicaciones.personales) {
      display = "MIS PUBLICACIONES";
      _cargarMisPublicaciones();
      _cargando = false;
    } else if (widget.tipo == TipoPublicaciones.todas) {
      display = "TODAS LAS PUBLICACIONES";
      _cargarTodasPublicaciones();
      _cargando = false;
    }
  }

  Future<void> _cargarMisPublicaciones() async {
    final response = await _repo.obtenerMisPublicaciones(
        {"email": widget.user.email, "rol": widget.user.userRole});

    if (response.status != 'error') {
      setState(() {
        _publicaciones = response.publicaciones;
      });
    } else {
      setState(() {
        _error = response.mensaje;
      });
    }
  }

  Future<void> _cargarTodasPublicaciones() async {
    final response = await _repo.obtenerTodasPublicaciones(
        {"email": widget.user.email, "rol": widget.user.userRole});

    if (response.status != 'error') {
      setState(() {
        _publicaciones = response.publicaciones;
      });
    } else {
      setState(() {
        _error = response.mensaje;
      });
    }
  }

  Widget _loader() {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0B77B3)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_cargando) {
      return _loader();
    }

    return Column(
      children: [
        ScreenNameDisplay(
          name: display,
        ),
        if (_error != null) ErrorMensaje(mensaje: _error!),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(), // desactivar scroll interno
          itemCount: _publicaciones.length,
          itemBuilder: (context, index) {
            var publicacion = _publicaciones[index];

            if ((publicacion.nombre == '' && publicacion.fotoPerfil == '') &&
                publicacion.correo == widget.user.email) {
              publicacion.nombre = widget.user.name;
              publicacion.fotoPerfil = widget.user.profilePicture;
            }

            return ComunidadPostCard(
              publicacion: publicacion,
              repo: _repo,
              user: widget.user,
            );
          },
        ),
      ],
    );
  }
}
