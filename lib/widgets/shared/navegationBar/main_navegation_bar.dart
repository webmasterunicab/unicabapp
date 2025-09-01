import 'package:flutter/material.dart';
import 'package:uniconecta/widgets/shared/navegationBar/nav_body_builder.dart';

enum NavBarTypes {
  normal,
  navegating,
  alternative,
  noBody;
}

class MainNavegationBar extends StatelessWidget {
  final NavBarTypes navType;

  final Widget? nextScreen;
  final bool canGetBackHere;

  const MainNavegationBar({super.key, this.navType = NavBarTypes.normal, this.canGetBackHere = false, this.nextScreen});

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
          children: navBodyBuilder(
            type: navType, 
            context: context, 
            canGetBackHere: 
            canGetBackHere, 
            nextScreen: nextScreen
          ),
        ),
      ),
    );
  }
}