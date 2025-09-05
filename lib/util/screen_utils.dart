import 'dart:math';
import 'package:flutter/material.dart';

class ScreenUtils {
  static double getDiagonal(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return sqrt(pow(size.height, 2) + pow(size.width, 2));
  }
}
