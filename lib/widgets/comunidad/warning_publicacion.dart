import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class WarningPublicacion extends StatelessWidget {
  const WarningPublicacion({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Colors.orange[700],
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "Tu publicación está sujeta a revisión, Nuestro equipo la revisará antes de hacerse visible.",
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.orange.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
