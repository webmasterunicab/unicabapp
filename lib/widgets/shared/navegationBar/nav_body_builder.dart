import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/models/shared/user.dart';
import 'package:uniconecta/providers/user_provider.dart';
import 'package:uniconecta/screens/comunidad/comunidad_mis_publicaciones.dart';
import 'package:uniconecta/screens/comunidad/comunidad_todas_publicaciones.dart';
import 'package:uniconecta/widgets/shared/navegationBar/main_navegation_bar.dart';
import 'package:uniconecta/widgets/shared/navegationBar/nav_bar_avatar.dart';

List<Widget> navBodyBuilder(
    {
      required NavBarTypes type,
      required BuildContext context,
      Widget? nextScreen,
      bool canGetBackHere = false,
      Color? buttonsColor
    }
  ) {
  
  final User? userProvider = context.watch<UserProvider>().user;

  String? name = '';
  Image? picture;

  if (userProvider != null) {
    name = userProvider.name;

    if (userProvider.profilePicture.isNotEmpty) {
      picture = Image.network(
        userProvider.profilePicture,
        fit: BoxFit.cover,
        width: 70,
        height: 70,
      );
    }
  }

  final misPublicaciones = GestureDetector(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (_) => ComunidadMisPublicaciones(user: userProvider!)),
      );
    },
    child: Image.asset(
      "assets/img/msgIconNav.png",
      height: 25,
      width: 25,
      fit: BoxFit.contain,
      color: Color.fromRGBO(239, 158, 41, 1),
    ),
  );

  final todasPublicaciones = GestureDetector(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (_) => ComunidadTodasPublicaciones(user: userProvider!)),
      );
    },
    child: Image.asset(
      "assets/img/bellNav.png",
      height: 25,
      width: 25,
      fit: BoxFit.contain,
      color: Color.fromRGBO(239, 158, 41, 1),
    ),
  );

  switch (type) {
    case NavBarTypes.normal:
      return [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            
            children: [
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(padding: EdgeInsets.only(bottom: 15)),
                child: Image.asset('assets/img/online-study.png', fit: BoxFit.contain, width: 55, height: 55)
              ),
          
              SizedBox(
                width: 50.w,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      name,
                      softWrap: true,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                      )
                    ),
                
                    SizedBox(height: 8),
                
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        misPublicaciones,
                        SizedBox(width: 8),
                        todasPublicaciones,
                      ],
                    ),
                  ],
                ),
              ),
          
              NavBarAvatar(
                  userAvatar: (picture != null)
                      ? picture
                      : const Icon(Icons.person,
                          color: Color.fromRGBO(145, 145, 145, 1), size: 60))
            ],
          ),
        ),
      ];

    case NavBarTypes.navegating:
      return [
        if (Navigator.of(context).canPop())
          SizedBox(
            height: 40,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              color: (buttonsColor != null) ? buttonsColor : Colors.white,
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
              misPublicaciones,
              SizedBox(width: 18),
              todasPublicaciones,
            ],
          ),
        ),
        if (nextScreen != null)
          SizedBox(
            height: 40,
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios_rounded),
              color: (buttonsColor != null) ? buttonsColor : Colors.white,
              onPressed: () {
                if (canGetBackHere) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => nextScreen));
                } else {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => nextScreen));
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
                  color: (buttonsColor != null) ? buttonsColor : Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            SizedBox(
              height: 40,
              child: IconButton(
                icon: Icon(Icons.arrow_forward_ios_rounded),
                color: (buttonsColor != null) ? buttonsColor : Colors.white,
                onPressed: () {
                  if (canGetBackHere && nextScreen != null) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => nextScreen));
                  } else if (!canGetBackHere && nextScreen != null) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => nextScreen));
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
              misPublicaciones,
              SizedBox(width: 18),
              todasPublicaciones,
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
              color: (buttonsColor != null) ? buttonsColor : Colors.white,
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
              color: (buttonsColor != null) ? buttonsColor : Colors.white,
              onPressed: () {
                if (canGetBackHere) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => nextScreen));
                } else {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => nextScreen));
                }
              },
            ),
          )
      ];
  }
}
