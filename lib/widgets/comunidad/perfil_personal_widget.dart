import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/models/shared/user.dart';
import 'package:uniconecta/widgets/shared/orange_button.dart';
import 'package:uniconecta/widgets/shared/text_area.dart';

class PerfilPersonalWidget extends StatefulWidget {
  final User user;
  const PerfilPersonalWidget({super.key, required this.user});

  @override
  State<PerfilPersonalWidget> createState() => _PerfilPersonalWidgetState();
}

class _PerfilPersonalWidgetState extends State<PerfilPersonalWidget> {
  String? fechaFormateada;

  @override
  void initState() {
    super.initState();
    _formatearFecha();
  }

  Future<void> _formatearFecha() async {
    Intl.defaultLocale = 'es_ES';
    if (widget.user.birthday == "") {
      setState(() {
        fechaFormateada = "Fecha de nacimiento no registrada.";
      });
    } else {
      try {
        await initializeDateFormatting('es_ES');
        DateTime fecha = DateTime.parse(widget.user.birthday);
        String formato =
            DateFormat("d 'de' MMMM 'del' y", "es_ES").format(fecha);
        setState(() {
          fechaFormateada = formato;
        });
      } catch (e) {
        setState(() {
          fechaFormateada = "Fecha invalida";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 0, 8.w, 10.w),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Icon(Icons.arrow_forward_ios),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            width: 100.w,
            padding: EdgeInsets.symmetric(vertical: 4.w),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color.fromRGBO(100, 96, 92, 0.2),
                  width: 1,
                ),
                bottom: BorderSide(
                  color: Color.fromRGBO(100, 96, 92, 0.2),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Columna izquierda
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Cumpleaños",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          color: const Color.fromRGBO(100, 96, 92, 0.7),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        fechaFormateada ?? '',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 5),

                // Columna derecha
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Conectado desde",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          color: const Color.fromRGBO(100, 96, 92, 0.7),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.user.city,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 100.w,
            padding: EdgeInsets.symmetric(vertical: 4.w),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromRGBO(100, 96, 92, 0.2),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Columna izquierda
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Esta en grado",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          color: const Color.fromRGBO(100, 96, 92, 0.7),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Sin Grado",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 5),

                // Columna derecha
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "correo en UNICAB",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          color: const Color.fromRGBO(100, 96, 92, 0.7),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.user.email,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 100.w,
            padding: EdgeInsets.symmetric(vertical: 4.w),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromRGBO(100, 96, 92, 0.2),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Lugares que desea conocer",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w300,
                    color: const Color.fromRGBO(100, 96, 92, 0.7),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.user.visitedPlaces,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w300,
                    color: const Color.fromRGBO(100, 96, 92, 0.7),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 100.w,
            padding: EdgeInsets.symmetric(vertical: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "¿Por qué elige a UNICAB?",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Roboto',
                    color: const Color.fromRGBO(100, 96, 92, 0.7),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.user.whyUnicab,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Roboto',
                    color: const Color.fromRGBO(100, 96, 92, 0.7),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Crear una publicación",
            style: TextStyle(
              fontSize: 16.sp,
              fontFamily: 'Roboto',
              color: Color.fromRGBO(14, 14, 14, 1),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          TextArea(
            fontSize: 15.sp,
            fieldHeight: 200,
          ),
          const SizedBox(
            height: 20,
          ),
          OrangeButton(
            buttonText: "Enviar",
            onPressed: () {},
            fontSize: 16.sp,
            textWeight: FontWeight.w600,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.w),
          )
        ],
      ),
    );
  }
}
