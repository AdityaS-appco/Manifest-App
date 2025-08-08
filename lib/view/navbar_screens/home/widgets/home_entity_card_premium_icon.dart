import 'package:flutter_svg/flutter_svg.dart';
import 'package:manifest/helper/import.dart';

class HomeEntityCardPremiumIcon extends StatelessWidget {
  const HomeEntityCardPremiumIcon({
    super.key,
    this.top = 10,
    this.left,
    this.bottom,
    this.right = 10,
  });

  final double? top;
  final double? left;
  final double? bottom;
  final double? right;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top?.sp,
      left: left?.sp,
      bottom: bottom?.sp,
      right: right?.sp,
      child: Container(
        height: 22.sp,
        width: 22.sp,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SvgPicture.asset(
            IconAllConstants.newLock01,
            color: Colors.white.withOpacity(0.5),
            height: 20.sp,
            width: 20.sp,
          ),
        ),
      ),
    );
  }
}
