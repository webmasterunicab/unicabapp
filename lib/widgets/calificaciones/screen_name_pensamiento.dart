import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ScreenNameDisplayPensamiento extends StatelessWidget {
  const ScreenNameDisplayPensamiento({super.key, required this.name, this.suffix, this.suffixSize = 50});

  final Widget? suffix;
  final double? suffixSize;
  final String name;

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(221, 219, 215, 1),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: suffixSize),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: Row(
              children: [
                Text(
                  "Pensamiento",
                  style: TextStyle(
                    color: Color.fromRGBO(134, 132, 129, 1),
                    fontFamily: 'Roboto',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w300
                  ),
                ),
                SizedBox(width: 1.w,),
                Text(
                  name,
                  style: TextStyle(
                    color: Color.fromRGBO(134, 132, 129, 1),
                    fontFamily: 'Roboto',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400
                  ),
                ),
              ],
            ),
          ),

          if (suffix != null)
            SizedBox(width: suffixSize, child: suffix!)
          else
            SizedBox(width: suffixSize),
        ]
      ),
    );
  }
}