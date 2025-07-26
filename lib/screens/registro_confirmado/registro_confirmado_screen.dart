import 'package:flutter/material.dart';

class RegistroConfirmadoScreen extends StatelessWidget {
  const RegistroConfirmadoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Color.fromRGBO(11, 119, 179, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Image.asset(
                    'assets/img/unicab-1.png',
                    width: 100,
                    height: 100,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.transparent, // fondo transparente
                    border: Border.all(
                      color: Colors.white, // color del borde
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(35),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "¡Ya eres miembro de la comunidad!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Uniconecta",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w200, // ExtraLight
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
          Expanded(
            child: Placeholder(),
          ),
        ],
      ),
    );
  }
}
