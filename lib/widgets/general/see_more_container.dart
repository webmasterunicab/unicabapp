import 'package:flutter/material.dart';
import 'package:uniconecta/screens/general/general_screen.dart';
import 'package:uniconecta/widgets/general/see_more_button.dart';

class SeeMoreContainer extends StatelessWidget {
  const SeeMoreContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1, style: BorderStyle.solid, color: Color.fromRGBO(245, 245, 245, 1))
        )
      ),

      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 35, right: 35, top: 9, bottom: 18),
                child: Text(
                  "Descubre más",
                  style: TextStyle(fontFamily: 'Roboto', fontSize: 10),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Container(
              padding: EdgeInsets.only(left: 6, right: 6, top: 25, bottom: 25),
              color: Color.fromRGBO(221, 219, 215, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SeeMoreButton(title: "Conectados", thumbnailPath: "assets/img/placeholder_General.jpg", route: GeneralScreen()),
                  SizedBox(width: 15,),
                  SeeMoreButton(title: "Biblioteca", thumbnailPath: "assets/img/placeholder_General.jpg", route: GeneralScreen()),
                ],
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 5),
            child: TextButton(
              onPressed: () {
                // Acción al presionar
              },
              child: Text(
                'Términos y privacidad (Enlace a políticas de datos)',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: 6,
                  color: Colors.black,
                ),
              )
            ),
          ),
        ],
      ),
    );
  }
}