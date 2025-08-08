import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_visualizer/music_visualizer.dart';

Widget dotsWaveLoading ({Color? color, double? size}){
  return LoadingAnimationWidget.staggeredDotsWave(
    color: color ?? Colors.white,
    size: size ?? 50,
  );
}

final List<Color> colors = [
  Colors.white70,
  Colors.white38,
  Colors.white,
  Colors.white54,
];
final List<int> duration = [900, 500, 800, 900, 600];
Widget dotsWavePlaying ({Color? color, double? size}){
  return MusicVisualizer(
    barCount: 5,
    colors: colors,
    duration: duration,
  );
}



class CustomLoading {
  static final CustomLoading _instance = CustomLoading._internal();

  factory CustomLoading() {
    return _instance;
  }

  CustomLoading._internal();

  OverlayEntry? _overlayEntry;

  void _createOverlayEntry(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          const Opacity(
            opacity: 0.5,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
          Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.white,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }

  void show(BuildContext context) {
    if (_overlayEntry == null) {
      _createOverlayEntry(context);
      Overlay.of(context).insert(_overlayEntry!);
      // Overlay.of(context)!.insert(_overlayEntry!);
    }
  }

  void dismiss() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }
}


class FastCircularProgressIndicator extends StatefulWidget {
  const FastCircularProgressIndicator({super.key});

  @override
  _FastCircularProgressIndicatorState createState() => _FastCircularProgressIndicatorState();
}

class _FastCircularProgressIndicatorState extends State<FastCircularProgressIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Change the duration to increase speed
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2.0 * 3.1415926535897932, // Full circle
          child: const CircularProgressIndicator(
            strokeWidth: 8.0,
            valueColor: AlwaysStoppedAnimation<Color>(
              Color.fromRGBO(194, 194, 194, 0.5),
            ),
          ),
        );
      },
    );
  }
}