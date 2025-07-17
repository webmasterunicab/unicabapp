import 'package:flutter/material.dart';

enum NavBarTypes {
  normal,
  navegating,
  alternative,
  noBody;
}

class MainNavegationBar extends StatelessWidget {
  const MainNavegationBar({super.key, this.navType = NavBarTypes.normal, this.canGoBack = false, this.nextScreen});

  final NavBarTypes navType;

  final Widget? nextScreen;
  final bool canGoBack;

  @override
  Widget build(BuildContext context) {

    final EdgeInsets padding = (navType != NavBarTypes.noBody) ? const EdgeInsets.only(bottom: 8, left: 20, right: 20) : const EdgeInsets.symmetric(horizontal: 10);
    final double neededHeight = (navType == NavBarTypes.normal) ? 129 : 86;

    return Container(
      height: neededHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(35)),
        color: Color.fromRGBO(11, 119, 179, 1),

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
      return [];
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
                if (canGoBack) {
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
                if (canGoBack) {
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