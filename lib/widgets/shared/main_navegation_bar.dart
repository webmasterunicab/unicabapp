import 'package:flutter/material.dart';

enum NavBarTypes {
  normal,
  navegating,
  alternative,
  noBody;
}

class MainNavegationBar extends StatelessWidget {
  const MainNavegationBar({super.key, this.navType = NavBarTypes.normal, this.canGetBackHere = false, this.nextScreen});

  final NavBarTypes navType;

  final Widget? nextScreen;
  final bool canGetBackHere;

  @override
  Widget build(BuildContext context) {

    final EdgeInsets padding = (navType != NavBarTypes.noBody) ? const EdgeInsets.only(bottom: 12, left: 20, right: 20) : const EdgeInsets.symmetric(horizontal: 10);
    final Color bodyColor = (navType != NavBarTypes.noBody) ? const Color.fromRGBO(11, 119, 179, 1) : Colors.transparent;
    final double neededHeight = (navType == NavBarTypes.normal) ? 130 : 86;

    return Container(
      height: neededHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(35)),
        color: bodyColor,

        boxShadow: [
          if (navType != NavBarTypes.noBody)
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.16),
              blurRadius: 6,
              offset: Offset(0, 3)
            )
        ],
      ),

      child: Container(
        padding: padding,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: _getNavStructure(navType: navType, context: context),
        ),
      ),
    );
  }

  List<Widget> _getNavStructure({required NavBarTypes navType, required BuildContext context}) {
    if (navType == NavBarTypes.normal) {
      return [
        TextButton(
          onPressed: () {}, 

          style: TextButton.styleFrom(padding: EdgeInsets.only(bottom: 15)),
          child: Image.asset('assets/img/pictureIcon.png', fit: BoxFit.contain, width: 45, height: 45)
        ),

        Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Juanita Perez", style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600,
                  color: Colors.white
                )),
                SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset("assets/img/msgIconNav.png", height: 25, width: 25, fit: BoxFit.contain, color: Color.fromRGBO(239, 158, 41, 1)),
                    SizedBox(width: 8),
                    Image.asset("assets/img/bellNav.png", height: 25, width: 25, fit: BoxFit.contain, color: Color.fromRGBO(239, 158, 41, 1),),
                  ],
                ),
              ],
            ),
            SizedBox(width: 18),

            CircleAvatar(
              radius: 38,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Color.fromRGBO(145, 145, 145, 1), size: 60,),
            )
          ],
        ),
      ];
    }

    if (navType == NavBarTypes.navegating) {
      return [
        if (Navigator.of(context).canPop())
          SizedBox(
            height: 40,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded), 
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
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

        if (nextScreen != null)
          SizedBox(
            height: 40,
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios_rounded), 
              color: Colors.white,
              onPressed: () {
                if (canGetBackHere) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => nextScreen!));
                } else {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => nextScreen!));
                }
              },
            ),
          ),
      ];
    }

    if (navType == NavBarTypes.alternative) {
      return [];
    }

    if (navType == NavBarTypes.noBody) {
      return [
        if (Navigator.of(context).canPop())
          SizedBox(
            height: 40,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded), 
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),

        if (nextScreen != null)
          SizedBox(
            height: 40,
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios_rounded), 
              color: Colors.white,
              onPressed: () {
                if (canGetBackHere) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => nextScreen!));
                } else {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => nextScreen!));
                }
              },
            ),
          ),
      ];
    }

    return [];
  }
}