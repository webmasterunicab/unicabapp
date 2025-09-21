import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DropdownItemNav extends StatelessWidget {
  final VoidCallback onPressed;
  final String name;

  const DropdownItemNav(
      {super.key, required this.name, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.zero)),
            alignment: Alignment.centerLeft),
        child: Text(name,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 15.sp,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            )),
      ),
    );
  }
}
