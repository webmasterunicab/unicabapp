import 'package:flutter/material.dart';

enum NavBarTypes {
  normal,
  navegating,
  alternative
}

List<Widget> getNavStructure({required NavBarTypes navType}) {
  if (navType == NavBarTypes.normal) {
    return [];
  }
  
  if (navType == NavBarTypes.navegating) {
    return [
      SizedBox(
        height: 40,
        child: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded), 
          color: Colors.white,
          onPressed: () {},
        ),
      ),

      SizedBox(
        height: 40,
        child: Row(
          children: [
            Image.asset("assets/img/msgIconNav.png", height: 25, width: 25, fit: BoxFit.contain, color: Color.fromRGBO(239, 158, 41, 1)),
            SizedBox(width: 18),
            Image.asset("assets/img/bellNav.png", height: 25, width: 25, fit: BoxFit.contain, color: Color.fromRGBO(239, 158, 41, 1),),
          ],
        ),
      ),

      SizedBox(
        height: 40,
        child: IconButton(
          icon: Icon(Icons.arrow_forward_ios_rounded), 
          color: Colors.white,
          onPressed: () {},
        ),
      ),
    ];
  }
  
  if (navType == NavBarTypes.alternative) {
    return [];
  }

  return [];
} 

class MainNavegationBar extends StatelessWidget {
  const MainNavegationBar({super.key, this.navType = NavBarTypes.normal});

  final NavBarTypes navType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(35)),
        color: Color.fromRGBO(11, 119, 179, 1),

        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.16),
            blurRadius: 6,
            offset: Offset(0, 3)
          )
        ],
      ),

      child: Container(
        padding: EdgeInsets.only(bottom: 8, left: 20, right: 20),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: getNavStructure(navType: navType),
        ),
      ),
    );
  }
}