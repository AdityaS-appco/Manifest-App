import 'package:flutter/material.dart';

class AppGradients {
  static LinearGradient grayToGray = LinearGradient(
    colors: [Colors.grey.shade900, Colors.grey.shade700],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient pinkGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomRight,
    colors: [
      Colors.grey.shade900,
      const Color.fromRGBO(140, 90, 128, 20.0), // Purple with 0.6 opacity
      Colors.grey.shade900, // This will create a fade effect
    ],
  );
}
