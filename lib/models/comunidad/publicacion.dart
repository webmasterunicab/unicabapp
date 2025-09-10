class Publicacion {
  final String id;
  final String idRol;
  final String texto;
  final String imagen;
  final String fechaPublicacion;
  final String estadoRevisionTexto;
  final String estadoRevisionMultimedia;
  final String correo;
  String nombre;
  String fotoPerfil;
  final String megusta;
  final String comentarios;
  final String comento;
  final String dioLike;

  Publicacion(
      {required this.id,
      required this.idRol,
      required this.texto,
      required this.imagen,
      required this.fechaPublicacion,
      required this.estadoRevisionTexto,
      required this.estadoRevisionMultimedia,
      required this.correo,
      required this.nombre,
      required this.fotoPerfil,
      required this.megusta,
      required this.comentarios,
      required this.comento,
      required this.dioLike});

  factory Publicacion.fromJson(Map<String, dynamic> json) {
    return Publicacion(
        id: json['id'] ?? '',
        idRol: json['idRol'] ?? '',
        texto: json['texto'] ?? '',
        imagen: json['imagen'] ?? '',
        fechaPublicacion: json['fechaPublicacion'] ?? '',
        estadoRevisionTexto: json['estadoRevisionTexto'] ?? '',
        estadoRevisionMultimedia: json['estadoRevisionMultimedia'] ?? '',
        correo: json['correo'] ?? '',
        nombre: json['nombre'] ?? '',
        fotoPerfil: json['fotoPerfil'] ?? '',
        megusta: json['megusta'] ?? '',
        comentarios: json['comentarios'] ?? '',
        comento: json['comento'] ?? '',
        dioLike: json['dioLike'] ?? '');
  }
}
