import 'package:manifest/helper/import.dart';

/// A reusable dialog handle for bottom sheets
class DialogHandle extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const DialogHandle({
    Key? key,
    this.width = 50,
    this.height = 5,
    this.color = const Color(0xFF9E9E9E),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(height / 2),
      ),
    );
  }
}
