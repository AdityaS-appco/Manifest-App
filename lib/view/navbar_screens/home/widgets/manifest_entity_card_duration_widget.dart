import 'package:manifest/core/shared/widgets/blur_container.dart';
import 'package:manifest/helper/import.dart';

class ManifestEntityCardDurationWidget extends StatelessWidget {
  const ManifestEntityCardDurationWidget({
    super.key,
    this.top,
    this.left,
    this.bottom = 10,
    this.right = 10,
    required this.duration,
  });

  final double? top;
  final double? left;
  final double? bottom;
  final double? right;
  final String duration;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top?.sp,
      left: left?.sp,
      bottom: bottom?.sp,
      right: right?.sp,
      child: BlurContainer(
        borderRadius: BorderRadius.circular(6.0),
        child: Container(
          height: 22.sp,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6.0),
          ),
          padding: const EdgeInsets.all(4),
          child: Center(
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Text(
                  duration,
                  style: primaryWhiteTextStyle(
                      fontSize: 11,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
