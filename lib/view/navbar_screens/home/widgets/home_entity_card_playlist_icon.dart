import 'package:flutter_svg/flutter_svg.dart';
import 'package:manifest/core/constants/assets/icons_constants.dart';
import 'package:manifest/core/utils.dart';
import 'package:manifest/helper/import.dart';

import '../../../../core/shared/widgets/blur_container.dart';

class HomeEntityCardPlaylistIcon extends StatelessWidget {
  const HomeEntityCardPlaylistIcon({
    super.key,
    this.top,
    this.left = 10,
    this.bottom = 10,
    this.right,
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
      child: BlurContainer(
        borderRadius: BorderRadius.circular(100.0),
        child: Container(
          padding: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(
              IconAllConstants.newLayersThree02,
              color: Colors.white.withOpacity(0.5),
              height: 18.sp,
              width: 18.sp,
            ),
          ),
        ),
      ),
    );
  }
}
