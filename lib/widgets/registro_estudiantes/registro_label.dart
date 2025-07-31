import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class RegistroLabel extends StatelessWidget {
  final String label;

  const RegistroLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
        color: Colors.orange,
        
      ),
    );
  }
}
