import 'package:flutter/material.dart';

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
        fontSize: 13,
        color: Colors.orange,
        
      ),
    );
  }
}
