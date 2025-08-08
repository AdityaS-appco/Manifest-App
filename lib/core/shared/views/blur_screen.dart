import 'dart:ui';

import 'package:flutter/material.dart';

class BlurScreen extends StatelessWidget {
  final Widget child;
  final double blurAmount;
  const BlurScreen({
    super.key,
    this.blurAmount = 10,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
      child: child,
    );
  }
}
