import 'package:flutter/material.dart';

class OrangeButton extends StatelessWidget {
  const OrangeButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.prefix,
    this.suffix,
    this.width,
    this.height,
  });

  final String buttonText;
  final VoidCallback onPressed;

  final double? width;
  final double? height;

  final Widget? prefix;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    final MainAxisAlignment organizeSpace = (prefix != null && suffix != null)
        ? MainAxisAlignment.spaceBetween
        : MainAxisAlignment.center;

    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: const Color.fromRGBO(255, 152, 5, 1),
        padding: const EdgeInsets.all(20),
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
            if (prefix != null) prefix!,
            Text(
              buttonText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            if (suffix != null) suffix!,
          ],
        ),
      ),
    );
  }
}
