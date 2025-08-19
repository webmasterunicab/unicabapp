import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/models/shared/user.dart';

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
      DateTime fecha = DateTime.parse(widget.user.birthday);
      String formato = DateFormat("d 'de' MMMM 'del' y", "es_ES").format(fecha);
      setState(() {
        fechaFormateada = formato;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
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
                    color: Color.fromRGBO(100, 96, 92, 0.7), // borde superior
                    width: 1,
                  ),
                  bottom: BorderSide(
                    color: Color.fromRGBO(100, 96, 92, 0.7), // borde inferior
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Cumpleaños",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300,
                              color: Color.fromRGBO(100, 96, 92, 0.7)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          fechaFormateada!,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Conectado desde",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300,
                              color: Color.fromRGBO(100, 96, 92, 0.7)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.user.city,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
