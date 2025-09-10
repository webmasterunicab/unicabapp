import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OrangeButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  final double? width;
  final double? height;
  final double? fontSize;

  final Widget? prefix;
  final Widget? suffix;

  final EdgeInsets? padding;

  final FontWeight textWeight;

  const OrangeButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.prefix,
    this.suffix,
    this.width,
    this.height, 
    this.padding = const EdgeInsets.all(20),
    this.fontSize = 15, 
    required this.textWeight, 
  });

  @override
  Widget build(BuildContext context) {
    final MainAxisAlignment organizeSpace = (prefix != null && suffix != null)
        ? MainAxisAlignment.spaceBetween
        : MainAxisAlignment.center;

    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: const Color.fromRGBO(255, 152, 5, 1),
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
      child: SizedBox(
        width: width, // if null, auto size
        height: height,
        child: Row(
          mainAxisSize: width == null ? MainAxisSize.min : MainAxisSize.max,
          mainAxisAlignment: organizeSpace,
          children: [
            if (prefix != null) ...[prefix!, SizedBox(width:20)],
            Text(
              buttonText,
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Colors.white,
                fontSize: fontSize!.sp,
                fontWeight: textWeight
              ),
            ),
            if (suffix != null) ...[SizedBox(width:20), suffix!],
          ],
        ),
      ),
    );
  }
}
