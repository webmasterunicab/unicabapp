import 'package:flutter/material.dart';
import 'package:uniconecta/widgets/shared/navegationBar/main_navegation_bar.dart';
import 'package:uniconecta/widgets/shared/navegationBar/nav_bar_avatar.dart';

List<Widget> navBodyBuilder({required NavBarTypes type, required BuildContext context, Widget? nextScreen, bool canGetBackHere = false}) {
  switch (type) {
    case NavBarTypes.normal:
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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Juanita Perez", style: TextStyle(
                  fontSize: 13,
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

            NavBarAvatar()
          ],
        ),
      ];

    case NavBarTypes.navegating:
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
          )
        else
          SizedBox(width: 40),

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
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => nextScreen));
                } else {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => nextScreen));
                }
              },
            ),
          )
        else
          SizedBox(width: 40),
      ];

    case NavBarTypes.alternative:
      return [
        Row(
          children: [
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
              child: IconButton(
                icon: Icon(Icons.arrow_forward_ios_rounded), 
                color: Colors.white,
                onPressed: () {
                  if (canGetBackHere && nextScreen != null) {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => nextScreen));
                  } else if (!canGetBackHere && nextScreen != null) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => nextScreen));
                  }
                },
              ),
            )
          ],
        ),

        SizedBox(
          height: 40,
          child: Row(
            children: [
              Image.asset("assets/img/msgIconNav.png", height: 25, width: 25, fit: BoxFit.contain, color: Colors.white),
              SizedBox(width: 18),
              Image.asset("assets/img/bellNav.png", height: 25, width: 25, fit: BoxFit.contain, color: Colors.white),
            ],
          ),
        ),
      ];

    case NavBarTypes.noBody:
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => nextScreen));
                } else {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => nextScreen));
                }
              },
            ),
          )
      ];
  }
}